[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](09-experiment-and-hardware-roadmap.md)

---

# 09 | Experiment & Hardware Roadmap

> **Maturity:** PENDING_EXPERIMENT (experimental design finalized; hardware decisions depend on experimental results)
> **Corresponding DOCX sections:** 17–20

---

## 9.1 Core Experiments: Model Scale vs Capability

### Experiment A1: 13B Full FT vs 31B DoRA

**Fixed variables:**

- Same training data
- Same test set
- Same output length
- Same decoding conditions

**Comparison metrics:**

| Metric | Measurement Method |
|--------|-------------------|
| Unseen configuration reasoning | Accuracy on OOD schools |
| Cross-school transfer | Train on school B, test on school C |
| Detail granularity | Judgment quality on rare configurations |
| Hallucination rate | Proportion of unfounded astrological judgments |
| Format adherence | Schema compliance rate for structured output |
| Catastrophic forgetting | Degradation on general capabilities after training |
| Training cost | GPU hours, memory, time |

### Experiment A2: Data Scale Marginal Returns

**Comparison:** 10K vs 50K vs 100K samples

**Goal:** Identify the diminishing returns inflection point to avoid wasting compute on data with negligible marginal benefit.

### Experiment A3: B Scale vs Quality

**Comparison:** 7B vs 13B B model

**Goal:** Confirm whether the frontend low-latency requirement (7B) suffices, or an upgrade to 13B is needed.

---

## 9.2 Hardware Decision Logic Chain

```
Question: How large of a model is needed?
  ↓
Experiment A1: 13B Full FT vs 31B DoRA
  ↓
If 13B suffices → Single RTX 4090 (24GB) feasible
If 31B necessary → Needs RTX 6000 Ada (48GB) or A6000
If 70B necessary → Needs multi-GPU or cloud
  ↓
Question: How much data is needed?
  ↓
Experiment A2: Marginal returns of 10K vs 50K vs 100K samples
  ↓
Determine storage and bandwidth requirements
  ↓
Question: How much inference resource is needed?
  ↓
Experiment A3: B scale vs quality
  ↓
Determine deployment configuration
```

---

## 9.3 Cloud-First, Buy-Later Rule

| Phase | Compute Resource | Purpose |
|-------|-----------------|---------|
| Phase 0 | Cloud GPU (rental) | Run experiments A1/A2/A3 |
| Phase 1 | Cloud GPU (rental) | Human annotation + C calibration |
| Phase 2 | Cloud GPU (rental) | Shadow C + D training |
| Phase 3 | Evaluate buy-out | Decide based on resource usage from Phases 0–2 |
| Phase 4 | Buy-out or hybrid | Production deployment |

---

## 9.4 20-Step Crosswalk

| Original Step | Original Approach | Final Decision | Reason for Difference |
|--------------|-------------------|----------------|----------------------|
| Step 5: C 100 dimensions | Hard-enforce all 100 dimensions | Observe all, hard-enforce few | Avoid premature false positives |
| Step 9: 5000 Few-Shot | 5000 Few-Shot examples | Start cold with a smaller database | Insufficient data |
| Step 10: De-over-marking | Enable from day one | Conditional enablement | Avoid forming rigid constraints too early |
| Step 14: B self-distillation | Can start early | Defer until 2000 pieces of 80+ quality work | Prevent mediocrity from solidifying into style |
| Step 18: 1024-dim injection | Can start early | Defer until 5000 alignment pairs | Prevent templating |

---

## 9.5 Known Risks

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Blurring boundary between A and B | Medium | High | Contract tests + CI checks |
| C's dimensions covered by average score | High | High | Traffic-light logic + uncertainty mechanism |
| D learns human shortcuts | Medium | Medium | Mandate confidence + alternative_view |
| E's vector injection suppresses B | Low | High | Diversity monitoring + stop condition |
| Error self-reinforcement during cold start | Medium | High | Shadow first 200 articles + human anchoring |
| Data leakage (cross-school / cross-client) | Medium | High | Six-layer isolation + authorization checks |
