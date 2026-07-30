[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](07-governance-and-evolution.md)

---

# 07｜Governance and Evolution

> **Maturity:** SETTLED (governance process); PROVISIONAL (specific thresholds require calibration)
> **Corresponding DOCX chapters:** 8, 12

---

## 7.1 C→D Trigger Flow

```
C scoring complete
  → All green → Normal output
  → Any red → Halt output, escalate to Safety or human
  → Any yellow → Trigger D
```

Once D is triggered:

1. Read A's concise package (200–500 words)
2. Read B's full text (5,000–8,000 words, not a single word deleted)
3. Read C's scoring report (30+ structured paragraphs + 100-dimension ratings)
4. Retrieve historical cases (same dimension, same archetype, approved/rejected proposals)
5. Output 0–3 proposals

---

## 7.2 D's Reading Order

1. **First pass:** Read only B's full text without marking; establish overall rhythm, emotional arc, perspective, and ending impression
2. **Second pass:** With A's core archetype and C's yellow flags, locate discrepancies between "local scoring" and "global reading"
3. **Diagnose the source:** C threshold rigidity, B genuine error, A archetype ambiguity, data OOD, or currently indeterminable

---

## 7.3 D Proposal Format

```json
{
  "case_id": "...",
  "proposals": [
    {
      "dimension_id": "P01",
      "current_rule": "opening_temperature_min = 0.5",
      "suggested_rule": "When archetype convergence is high and the latter half of the full text warms up, the lower bound for the first 20% can be 0.3",
      "scope": "conditional",
      "evidence_ranges": ["B:para1-3", "B:para18-22"],
      "reason": "Early low temperature is necessary buildup for later release",
      "confidence": 0.74,
      "alternative_view": "Could also be that B's tactile description is overly detached; more cases needed to identify"
    }
  ],
  "no_change_reason": null,
  "analysis_summary": "Around 300 words; at most 1000 words",
  "d_version": "D-..."
}
```

---

## 7.4 A/B Voting (Advisory Only)

- **A's vote:** Answers "Would this C modification compromise archetype fidelity?"
- **B's vote:** Answers "Would this modification unnecessarily narrow the narrative space?"
- **Cold start period:** All human adjudication
- **Later stage:** Voting is used only for ranking and confidence assistance; proposals still require historical replay and canary

---

## 7.5 Human Adjudication

| Field | Content |
|-------|---------|
| Case summary | A's core, B full-text reading link, C yellow flags, D proposals, similar historical cases |
| Three-key verdict | Approve / Reject / Need more cases |
| Reason field | C threshold error, B genuine error, A ambiguity, data OOD, preference ≠ truth |
| Scope | Single-case exception / Archetype-cluster rule / Global rule; global not allowed by default |
| Rollback window | Any approval can be revoked if canary metrics deteriorate, with the original rule retained |

---

## 7.6 Backtest, Canary, Rollback

### Backtest

Before each rule modification, replay on historical cases:

- False positive rate (cases originally green that turn red under the new rule)
- False negative rate (cases originally red that turn green under the new rule)
- Yellow flag recall rate (cases originally yellow that are correctly handled by the new rule)
- Cluster bias (whether the new rule is unfair to specific schools/tasks)

### Canary

- Deploy new rule to 5% traffic first
- Monitored metrics: red light accuracy, yellow light accuracy, human intervention rate, user satisfaction
- Canary period: at least 7 days or 100 cases

### Rollback

- Any canary metric deteriorating >10% → automatic rollback
- After rollback, retain the new rule's data for subsequent analysis
- Same rule rolled back twice → requires human adjudication to decide whether to continue trying

---

## 7.7 Golden Divergence Handling

When A scores low, C scores low, but humans like it:

1. Identify cause of A's low score: truth error, school difference, conservative boundary, or A failing to understand the new imagery
2. Identify cause of C's low score: evasion, safety, local threshold, existential stance, or lagging similarity space
3. Classify reason humans like it: objective accuracy, extended thinking, deep empathy, inner thoughts, benevolent lie, corrosive empathy, literary novelty
4. Wait for delayed signal: whether still chosen after 15 days, whether willing to point out specific accuracies, whether still holds after outcomes occur
5. Decide disposition: A truth revision, B masterpiece, C exception rule, situational comfort only, or reject inclusion

---

## 7.8 Model Update Frequency

- **C threshold calibration:** Every 100 accumulated human adjudications
- **D version update:** Every approximately 100 human adjudications builds a candidate version; updates driven by event thresholds, not calendar
- **A/B model update:** Requires full backtest + Canary + rollback
- **E experiment:** Independent of main version, runs in shadow mode
