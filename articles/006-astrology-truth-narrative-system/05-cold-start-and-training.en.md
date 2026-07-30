[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](05-cold-start-and-training.md)

---

# 05｜Cold Start and Training

> **Maturity:** PROVISIONAL (five-phase framework finalized; specific thresholds require experimental calibration)
> **Corresponding DOCX chapter:** 14

---

## 5.1 Five Phases of Cold Start

### Phase 0: Offline Verification

**Objective:** Confirm A's correctness in a controlled environment.

- **Entry criteria:** Data preparation complete (at least 1,000 labeled cases)
- **Activities:**
  - A initial training (13B Full FT or 31B DoRA)
  - Verify accuracy on test set
  - Establish correctness baseline
- **Exit criteria:** A achieves 85%+ accuracy on test set
- **Key risk:** Test set does not represent the true distribution

### Phase 1: Human Anchoring

**Objective:** Establish C's initial judgment baseline.

- **Entry criteria:** Phase 0 complete
- **Activities:**
  - First batch of human labeling for C (at least 500 articles covering 50+ dimensions)
  - Humans label B's output quality article by article
  - Establish C's initial thresholds
- **Exit criteria:** C's yellow/red light agreement rate with human judgment >80%
- **Key risk:** Early labeler bias (first 200 articles are shadow records only)

### Phase 2: Shadow C

**Objective:** C collects false positives and false negatives without affecting release.

- **Entry criteria:** Phase 1 complete
- **Activities:**
  - C runs in shadow mode (reports yellow light but does not block)
  - Humans continuously calibrate C's thresholds
  - Collect false positive and false negative cases
- **Exit criteria:** C's false positive rate <15%
- **Key risk:** Over-conservatism causes C to be ignored

### Phase 3: D-Assisted Governance

**Objective:** D begins assisting humans with yellow-light cases.

- **Entry criteria:** Phase 2 complete
- **Activities:**
  - D training (positive 40%, no-adjustment 40%, boundary 20%)
  - D proposes → human adjudicates → backtest → Canary → rollback
  - Establish decision log
- **Exit criteria:** Human adoption rate of D proposals >60%
- **Key risk:** D learns human shortcuts

### Phase 4: E Bridging Experiment

**Objective:** Verify E's effectiveness without affecting the main pipeline.

- **Entry criteria:** Phase 3 stable for 3 months + 5,000 alignment data pairs
- **Activities:**
  - E runs in shadow mode
  - Monitor B's diversity and OOD fidelity
  - Small-traffic injection experiments
- **Exit criteria:** E does not reduce B's diversity (diversity decline <10%)
- **Key risk:** Vector injection suppresses B

---

## 5.2 First 200 Shadow Records

Early users are often friends, testers, or people deeply invested in astrology, and their upvote standards differ from future general users.

- The first 200 articles are fully recorded but do not change C's boundaries
- Humans remain the sole anchor
- This is not wasted data; it establishes a bias baseline first

---

## 5.3 Self-Distillation Threshold

Do not use works scoring 70 with occasional bright spots to retrain B; that would cement early mediocrity into a fixed style.

- **Provisional threshold:** At least 2,000 articles with 80+ quality scores confirmed by humans or stable evaluation
- **Coverage:** Different schools, tasks, and emotional types
- **Distillation data:** Keep only task input and high-quality output; remove original prompts
- **Testing method:** Shadow model first, blind evaluation, regression testing, then gradually remove Few-Shot

---

## 5.4 B Initial Training Strategy

| Strategy | Advantages | Disadvantages | Recommendation |
|----------|-----------|---------------|--------------|
| Freeze pretrained weights | Retains general capability | May not adapt enough to astrology narrative | Not recommended |
| LoRA fine-tuning | Low cost, swappable | Capacity may be insufficient | Adopt at Phase 0 |
| Full parameter fine-tuning | Maximum adaptability | High cost, risk of catastrophic forgetting | Requires experimental verification |
| Training from scratch | Full control | Extremely high cost, large data requirement | Not recommended for initial adoption |

**Recommendation:** Start with LoRA fine-tuning at Phase 0; upgrade to full parameter fine-tuning if capacity proves insufficient.

---

## 5.5 C Initial Dimension Activation

| Dimension Group | Day 1 | Phase 1 | Phase 2+ |
|----------------|-------|---------|----------|
| Safety and Escape (C-41–C-50) | Hard enforcement | Hard enforcement | Hard enforcement |
| Prototype Loyalty (C-01–C-05) | Observe | Yellow light | Hard enforcement |
| Logic and Causality (C-06–C-10) | Observe | Yellow light | Hard enforcement |
| Emotional Temperature (C-11–C-15) | Observe | Observe | Yellow light |
| Sensory Grounding (C-16–C-20) | Observe | Observe | Yellow light |
| Remaining dimensions | Observe | Observe | Enable as needed |

---

## 5.6 D Training Recipe

| Sample Type | Proportion | Expected Behavior |
|-------------|-----------|------------------|
| C requires adjustment | 40% | Full-text evidence that C rules are too strict, too lenient, or missing conditions; output 1–3 proposals |
| No adjustment needed | 40% | The yellow light is actually organic narrative; output empty proposals and explain why no change |
| Boundary / human review | 20% | Multiple interpretations, A/B split, or OOD; low confidence, alternative_view required |
