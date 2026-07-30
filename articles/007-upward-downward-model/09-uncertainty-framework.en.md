[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](09-uncertainty-framework.md)

---

# 09 | Uncertainty-Facing Framework

> **Maturity:** PROVISIONAL (framework defined; calibration mechanism requires experimentation)
> **Corresponding source section:** Part XIII + XIV (Uncertainty-Facing Framework, Confidence and Calibration)

---

## 9.1 Framework Positioning

The Uncertainty-Facing Framework is the **underlying philosophy** of the entire system:

> The system does not rush to produce a determinate answer; instead it first judges whether there is currently sufficient evidence to enter the next truth gate; when evidence is insufficient, it must honestly abstain, and emit a precise bounded next dispatch.

---

## 9.2 Core Propositions

1. **Uncertainty is not a bug, but information**: The system's uncertainty reflects the completeness of evidence
2. **Uncertainty must be expressed, not hidden**: The model must not fabricate answers just to "appear useful"
3. **Uncertainty must be calibrated**: The system's confidence must be consistent with actual accuracy
4. **Uncertainty must be managed**: Abstain under high uncertainty, emit dispatch under moderate uncertainty

---

## 9.3 Overall System Architecture

```
Panel of AIs (multiple models independently generate)
  → Cross-review (compare consistency)
  → Divergence classification (divergence type + uncertainty source)
  → Confidence calibration (confidence vs accuracy)
  → Gate Engine (PASS / FAIL / UNCERTAIN / INSUFFICIENT_EVIDENCE / AMBIGUOUS)
  → Output or dispatch
```

---

## 9.4 Confidence Definition

Confidence is the system's estimate of the correctness of its own answer, ranging from 0.0–1.0.

Confidence is not "what the model feels is correct," but the **calibrated predicted accuracy**:

- confidence = 0.8 → In historical data, this class of answers has approximately 80% accuracy
- confidence = 0.95 → In historical data, this class of answers has approximately 95% accuracy

---

## 9.5 Uncertainty Source Classification

| Source | Definition | Handling |
|--------|-----------|----------|
| Insufficient Evidence | Lacks sufficient evidence to support a conclusion | Collect more evidence |
| Conflicting Evidence | Different evidence points to different conclusions | Divergence classification + human adjudication |
| Model Capability Limitation | Model cannot handle the current task | Downgrade or route to expert |
| Ambiguous Task | Task description is unclear | Return to human for clarification |
| OOD | Input falls outside training distribution | abstain + mark OOD |

---

## 9.6 Calibration Mechanism

The goal of calibration is to align confidence with accuracy:

- If confidence = 0.8 but accuracy = 0.6 → Overconfident → needs down-calibration
- If confidence = 0.6 but accuracy = 0.8 → Overly conservative → needs up-calibration

Calibration methods:

1. **Temperature calibration**: Adjust softmax temperature
2. **Bin calibration**: Bin confidence values, calibrate each bin independently
3. **Divergence calibration**: Use the degree of divergence between D↓ and U↑ as an uncertainty signal

---

## 9.7 Calibration Incentives

Add calibration incentives during training:

- Correct answer + high confidence → Reward
- Correct answer + low confidence → Mild penalty (encourage confidence)
- Wrong answer + high confidence → Strong penalty (prevent overconfidence)
- Wrong answer + low confidence → Mild reward (honesty is better than false success)
- abstain + correctly judged uncertainty → Reward
- abstain + incorrectly judged uncertainty → Penalty
