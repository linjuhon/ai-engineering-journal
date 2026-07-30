[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](04-runtime-pipeline.md)

---

# 04｜Runtime Pipeline

> **Maturity:** PROVISIONAL (synchronous path finalized; async preview mode pending product requirements)
> **Corresponding DOCX Section:** 13

---

## 4.1 Formal Synchronous Path

```
User Input
  → Request Gateway (validate input, consent, school, task, time scale)
  → Chart Normalizer (generate canonical JSON and input_hash)
  → A Truth Service (produce truth_package, multi-sample consistency when needed)
  → Planner (decompose into archetype units + full-article arc + three cross-sensory Few-Shots)
  → B Narrative Service (segment generation; write story_state and trace per segment)
  → C Scorer (segment scoring; hard-red regenerates or terminates, yellow-light marks, green-light continues)
  → Global Reviewer (read full text, recompute global 100 dimensions and escape)
  → Safety Service (independent final check)
  → Assembler (output human-readable version, preserve all versions and scoring events)
```

---

## 4.2 Segment-Level State

B's generation state is tracked by `story_state`:

```yaml
story_state:
  case_id: str
  global_arc: [建立, 堆疊, 轉折, 收束]
  current_unit: AU-03
  completed_units: [AU-01, AU-02]
  emotion_temperature_curve: [0.2, 0.25, 0.4]
  motifs:
    - name: Door
      uses: 2
      angles: [Childhood Upward Gaze, Adult External Gaze]
  last_hook: str
  forbidden_escape: [Comforting Escape, Template Escape]
  segment_index: 7
```

---

## 4.3 Emotion Hooks

Each segment ends with an emotion hook; the next segment continues from the hook to avoid mechanical assembly.

- **Format:** The last sentence of the segment, containing emotional tension or suspense
- **Hook Types:** Emotion hook (emotional continuity), Question hook (spark curiosity), Imagery hook (imagery resonance)
- **Failure Handling:** If C judges the hook invalid (C-23 red light), B regenerates the segment's end
- **Avoiding Templates:** The same hook type must not be used consecutively in the same case

---

## 4.4 Three Cross-Sensory Few-Shots

The Planner selects three Few-Shots from different sensory channels for each case:

1. **Vision-Dominant:** Focus on imagery, color, spatial description
2. **Emotion/Introspection-Dominant:** Focus on emotions, inner feelings, value judgments
3. **Action/Narrative-Dominant:** Focus on events, time progression, causality

The purpose of the three Few-Shots is to preserve B's freedom, not to constrain B's style.

---

## 4.5 De-Marking

De-marking is an engineering state to prevent repeated use of the same angle for imagery, not a creative rule.

- **Before ~1,000 cold-start generations:** Record only, no hard blocking
- **After B stabilizes:** Gradually require the same archetype to switch sensory channel, perspective, or time
- **Activation timing:** Tentative, to be decided after observing B's actual performance

---

## 4.6 Synchronous vs Asynchronous

| Mode | Latency | Truth Risk | Applicable Scenarios |
|------|---------|------------|---------------------|
| **Fully Synchronous** | High (A+B+C serial) | Low | Production, standard chart reading |
| **Frontend Preview + Backend Verify** | Low (draft first) | Medium | Must clearly label "Not verified by A/C" |
| **Pure Async** | Low (return taskId first) | Low | Heavy reports, batch processing |

Production is recommended to use the fully synchronous path. Async preview mode requires product requirements to decide whether to implement.

---

## 4.7 Failure Fallback

| Failure Point | Fallback Strategy |
|---------------|------------------|
| A low confidence/OOD | Stop pretending; display what is certain and unknown; escalate to expert queue if necessary |
| B consecutive red lights | Lower creative temperature, reduce segment size, rebuild outline; if still failing, output A's technical version |
| C high-uncertainty yellow light | Escalate to D/human; must not greenlight based on high average score |
| D cannot judge | Output low confidence and alternative explanations, forbid modification of C |
| Safety triggered | Based on risk, respond directly, clearly, and without romanticization |
