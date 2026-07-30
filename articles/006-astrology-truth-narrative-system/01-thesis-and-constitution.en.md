[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](01-thesis-and-constitution.md)

---

# 01 | Thesis and System Constitution

> **Maturity:** SETTLED
> **Corresponding DOCX Sections:** 1–3, 10, 14
> **Relationship to Article 005:** This article is a concrete implementation of Article 005 theory in the domain of astrology. Article 005 defines the general framework of "Global Intelligence"; this article defines how the A–E system translates that framework into executable component contracts and governance mechanisms.

---

## 1.1 The Core Contradiction the System Solves

Astrological chart reading faces a fundamental contradiction: **Truth demands precision, but humans need stories.**

- If only precise chart data and school rules are provided, users cannot resonate — the reading becomes a dry technical report.
- If only a smooth narrative is provided, the model may deviate from astrological truth to please the reader — the reading becomes a placebo.

The traditional approach is to have one model learn both truth and narrative simultaneously, but this forces the model to compromise when the two conflict: either sacrifice truth for fluency, or sacrifice narrative for safety.

**The A–E system's core proposition: physically isolate the five capabilities — truth, narrative, measurement, governance, and semantic bridging — preventing any single model from holding all the power over definition, creation, scoring, and modification of rules.**

---

## 1.2 Five-Component Architecture Overview

| Component | Name | Core Responsibility | Isolation Rationale |
|-----------|------|-------------------|-------------------|
| **A** | Truth Engine | Truth reasoning and structured output | Cannot define truth and create stories simultaneously |
| **B** | Narrative Engine | Free narrative and concretization | Cannot be directly controlled by truth in expression |
| **C** | Control Plane | A–B distance measurement, 100-dimensional control, and uncertainty | Cannot be both player and referee |
| **D** | Governance Assistant | Read the full story, propose amendments to C | Cannot modify rules directly |
| **E** | Semantic Bridge | Semantic compression and bridging of A (research stage) | Cannot contaminate truth coordinates |
| **Human** | — | Constitution and final adjudication | Cannot be overridden by an agent |
| **Safety** | — | Independent baseline check | Cannot be overridden by majority vote |

---

## 1.3 Key Definitions

### Truth

Truth is not absolute correctness, but **structured judgment that is traceable, verifiable, and challengeable.** A's output must include:

- Causal chain (why this configuration leads to this judgment)
- Confidence (A's uncertainty about its own judgment)
- School source (which astrological school, which author's perspective)
- Boundary (conditions under which this judgment does not hold)

### Narrative

Narrative is **the transformation of structured truth into language that humans can feel.** B's output may:

- Use metaphor, imagery, emotional pacing
- Adjust temperature, perspective, sensory channels
- Build a story arc

But B's output **must not**:

- Quietly replace the core archetypes specified by A
- Add astrological judgments without evidence
- Conceal uncertainty for the sake of fluency

### Escape

Escape is not an ordinary quality issue, but a **direction problem.** When B's narrative deviates from A's truth to a certain degree and the system fails to intercept, it is called an escape. Typical patterns of escape:

- Comforting escape: watering down a true judgment to make the user feel better
- Template escape: using generic narrative templates to override personalized analysis
- Pleasing escape: adjusting conclusions based on user preferences
- Obscuring escape: using vague language to mask uncertain judgments

**Escape must be strictly blocked from day one, because it erodes the trust foundation of the entire system.**

### Feedback Triage

Customer feedback is divided into three categories that must not be mixed:

| Type | Example | May Influence |
|------|---------|---------------|
| Truth Evidence | Expert corrections, verifiable events, long-term outcomes | A's truth corpus, school constitution |
| Resonance Evidence | Bookmarks, shares, still chosen after 15 days | B's quality library, C's resonance dimensions |
| Immediate Comfort | Instant likes, feeling comforted | Situational signal only; does not directly modify A |

---

## 1.4 The Twelve Constitutional Articles

The following articles are inviolable and may not be modified by any component or agent without authorization:

### Article One: A and B Physical Isolation

A and B must not communicate directly. A's structured output is decomposed by the Planner into archetype units and fed to B; B's output must not loop back to modify A's truth judgments. The two intersect in the archetype vector space, not at the raw text level.

### Article Two: C Must Not Allow Averages to Override Red Lights

Traffic light logic: weighted averages must not wash out critical dimensions.

- `hard_red` = `safety_fail` OR `escape_fail` OR `severe_truth_breach`
- `yellow` = NOT hard_red AND (any_dimension_uncertain OR score_in_borderline_zone OR A_B_C_disagreement OR OOD_detected OR segment_global_conflict)
- `green` = NOT hard_red AND NOT yellow
- `ranking_score` = SUM(w_i * s_i) — may only rank, must not override hard_red

### Article Three: D Must Read B's Full Text

D must not read only summaries or excerpts. Local features such as coldness, repetition, or open endings can only be judged as failure or buildup within the full narrative sequence. D's reading order: first read B's full text to establish an overall impression, then carry A's core archetypes and C's yellow lights to pinpoint inconsistencies.

### Article Four: Escape Is a Hard Gate from Day One

Safety and escape dimensions may trigger direct red lights from day one. Other dimensions should first collect false positives and misses to avoid early rules wrongfully killing B's organic low-temperature passages, imagistic resonance, or open endings.

### Article Five: Safety Must Not Be Overridden by Majority Vote

The Safety layer is independent of the voting mechanism of A/B/C/D/E. No component may bypass Safety's red light on the grounds of majority agreement.

### Article Six: Human Final Adjudication

During the cold-start period, all D proposals are adjudicated by humans. Later, voting is used only for ranking and confidence assistance; proposals still require historical replayback and canary testing. Humans are not grunt workers reviewing every piece, but system architects.

### Article Seven: Feedback Must Be Triaged

Truth evidence, resonance evidence, and immediate comfort evidence must not be mixed into the same training data. Golden divergence (both A and C rate low but humans still like the output) must undergo delayed confirmation and classification investigation before being turned green.

### Article Eight: Model Updates Require Regression Testing + Canary + Rollback

Every model update must:

1. Replay on historical cases to check false kills, false releases, yellow-light recall, and clustering bias
2. Pass canary tests (no degradation in specified metrics)
3. Retain rollback capability (any approval can be revoked when canary metrics degrade)

### Article Nine: All 100 Dimensions Observed, Few Hard-Enforced

All 100 dimensions are computed and may report yellow; safety and escape may trigger direct red from day one; severe truth errors may also trigger red. Other dimensions should first collect false positives and misses without hard enforcement.

### Article Ten: Self-Distillation Has a Strict Threshold

Do not retrain B on 70-point works with occasional bright spots. Provisional threshold: at least 2,000 pieces of 80+ quality work confirmed by human or stable evaluation, covering different schools, tasks, and emotional types. Distillation data retains only task input and quality output, removing original prompt text.

### Article Eleven: E Requires Sufficient Alignment Data to Start

At least several thousand high-quality A–B alignment data pairs (provisionally 5,000 pairs). E first runs shadow scores without affecting release decisions; only after confirming it improves OOD fidelity and does not reduce diversity should small-traffic injection begin.

### Article Twelve: Every Deviation Has a Visible Chain of Responsibility

True controllability is not about binding the model tightly, but ensuring every deviation has a visible chain of responsibility. Every decision (approval, rejection, exception) must record: who made it, the basis, the scope of effect, and rollback conditions.

---

## 1.5 Relationship to Article 002

Article 002 is the **product architecture overview** of the astrology system, answering "what the entire astrology website should be built as." This article is the **deep construction specification** of the A–E system, answering "how this core intelligence is trained, run, governed, and evolved."

- Article 002 explains; this article defines.
- If the two conflict in implementation details, this article takes precedence.
- Recommended reading order: read Article 002 first to build product understanding, then read this article for deep component contracts.

---

## 1.6 Relationship to Article 005

Article 005 defines the general theoretical framework for "Global Intelligence": cognitive scheduler, saturation estimation, paradigm switching, goal sovereignty. This article is the concrete implementation of that theory in the domain of astrology:

| Article 005 Concept | Article 006 Corresponding Implementation |
|---------------------|----------------------------------------|
| Saturation Estimator | C's marginal return dimension |
| Dual-Mode Controller | C's convergence/exploration mode switching |
| Counter-Hypothesis Generator | D's proposal mechanism |
| Anomaly Cultivator | C's golden divergence handling |
| Champion–Challenger Manager | D's version management and regression testing |
| Constitutional Governance Layer | This article's 12 constitutional articles |

---

## 1.7 Status Summary

| Article | Status | Notes |
|---------|--------|-------|
| Articles 1–6 | SETTLED | Core isolation principles, should not be changed casually |
| Article 7 | SETTLED | Feedback triage mechanism |
| Article 8 | SETTLED | Update governance process |
| Article 9 | PROVISIONAL | Specific 100 dimensions require experimental validation |
| Article 10 | PROVISIONAL | 2,000-piece threshold to be calibrated after cold start |
| Article 11 | PROVISIONAL | 5,000-pair threshold to be calibrated after data preparation |
| Article 12 | SETTLED | Chain of responsibility principle |
