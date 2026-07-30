[← Back to technical index](../TECHNICAL_INDEX.en.md) | **English** | [繁體中文](D-training-curriculum.md)

---

# Appendix D: Training Curriculum

> **Maturity:** PROVISIONAL (curriculum requires experimental calibration)

---

## D.1 Phase 0: Dual-Prompt Verification

**Goal:** Verify whether the divergence system produces useful signals

**Method:**
- Use existing models, simulate D↓ and U↑ via prompts
- Test divergence detection rate on FA4 cases
- Collect initial divergence samples

**Deliverable:**
- Divergence system prototype
- Initial divergence sample set (at least 100 pairs)

**Success condition:** Divergence detection rate > 60%

---

## D.2 Phase 1: Train U↑

**Goal:** Enable the model to infer purpose from results

**Data:** Reverse database (at least 1000 records)

**Training targets:**
- Inverse-inference purpose accuracy > 80%
- Gate state classification accuracy > 75%
- Evidence binding accuracy > 85%

**Evaluation:**
- Inverse-inference accuracy on test set
- Consistency with human expert inference

---

## D.3 Phase 2: Preference Training

**Goal:** Enable the model to abstain when divergence occurs

**Data:** Divergence samples + human preference annotations

**Training targets:**
- Abstain accuracy > 80%
- Uncertainty calibration error < 0.1

**Evaluation:**
- Proportion of cases where abstention truly corresponds to uncertainty
- Calibration curve of confidence vs. accuracy

---

## D.4 Phase 3: Improve D↓

**Goal:** Reduce premature patches

**Data:** U↑ feedback + divergence samples

**Training targets:**
- Route verification rate before patching > 90%
- Premature patch rate < 10%

**Evaluation:**
- Premature patch rate on test set
- Patch-timing consistency with human experts

---

## D.5 Phase 4: Offline Alternating Update

**Goal:** Continuously improve both models

**Method:**
- D↓ update → collect new divergence samples
- U↑ update → collect new divergence samples
- Alternate updates to avoid convergence

**Monitoring metrics:**
- Divergence rate (divergence samples / total samples)
- Calibration error
- False success detection rate
- Diversity metric

**Stop condition:** Divergence rate below 5% and calibration error below 0.05
