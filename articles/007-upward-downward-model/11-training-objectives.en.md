[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](11-training-objectives.md)

---

# 11 | Training Objectives

> **Maturity:** PROVISIONAL (training objectives defined; training sequence needs experimentation)
> **Corresponding source sections:** Part XVIII + XIX + XX (Training Objectives, Human Sampling Strategy, Evaluation Metrics)

---

## 11.1 Primary Objective: Calibration

Calibration is the system's most important training objective.

**Objective:** Align the model's confidence with its actual accuracy.

**Training signal:**

- Correct + high confidence → positive reward
- Correct + low confidence → mild negative reward
- Wrong + high confidence → strong negative reward
- Wrong + low confidence → mild positive reward
- Abstain + correct judgment → positive reward
- Abstain + wrong judgment → negative reward

---

## 11.2 Auxiliary Objective 1: Divergence Classification

**Objective:** Enable the model to correctly classify divergence types.

**Training signal:** Actual divergence types of D↓ and U↑ (route / numeric / purpose / evidence / gate)

**Evaluation metric:** Divergence classification accuracy

---

## 11.3 Auxiliary Objective 2: Uncertainty Source Attribution

**Objective:** Enable the model to correctly attribute uncertainty sources.

**Training signal:** Actual uncertainty sources (insufficient evidence / contradictory evidence / model limitation / ambiguous task / OOD)

**Evaluation metric:** Attribution accuracy

---

## 11.4 Auxiliary Objective 3: Bounded Next Dispatch

**Objective:** Enable the model to issue a precise next dispatch when uncertain.

**Training signal:** Human expert's next action

**Evaluation metric:** Dispatch precision / recall

---

## 11.5 Training Sequence

### Phase 0: No Training, Dual-Prompt Validation

- Use the existing model, simulate D↓ and U↑ via prompts
- Verify whether the divergence system produces useful signals
- Collect initial divergence samples

### Phase 1: Train U↑ First

- Train the upward model using the reverse database
- Objective: Infer purpose, gate status, and causal chain from outcomes
- Evaluation: Reverse inference accuracy

### Phase 2: Preference Training

- Perform preference training using divergence samples
- D↓ and U↑ answers → human preference annotations
- Objective: Teach the model to abstain when divergence occurs

### Phase 3: Improve D↓

- Improve the downward model using U↑ feedback
- Objective: Reduce premature patches
- Evaluation: Route verification rate before patching

### Phase 4: Offline Alternating Update

- D↓ update → collect new divergence samples
- U↑ update → collect new divergence samples
- Alternate updates to avoid convergence

---

## 11.6 Human Sampling Strategy

Humans do not label everything — only high-value points:

| Sampling Priority | Sample Type | Reason |
|------------------|-------------|--------|
| Highest | D↓ and U↑ divergence samples | Divergence is the system's uncertainty sensor |
| High | Low-confidence correct samples | Signal of insufficient calibration |
| High | High-confidence wrong samples | Signal of overconfidence |
| Medium | OOD samples | Out-of-distribution behavior |
| Low | High-confidence correct samples | Low information value |

---

## 11.7 Evaluation Metrics

### Primary Metrics

- **Calibration error**: mean of |confidence - accuracy|
- **Divergence detection rate**: proportion of divergences correctly detected by the system
- **Abstain accuracy**: proportion of abstentions that are genuinely uncertain
- **Dispatch precision**: accuracy of dispatches

### Auxiliary Metrics

- **Divergence classification accuracy**
- **Uncertainty attribution accuracy**
- **False success detection rate**
- **Premature patch rate**

### Most Important Single Metric

> **False success detection rate**: the proportion of false successes the system correctly identifies and stops.

If this metric does not improve, no amount of improvement in other metrics matters.
