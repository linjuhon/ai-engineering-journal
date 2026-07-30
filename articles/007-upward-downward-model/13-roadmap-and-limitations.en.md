[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](13-roadmap-and-limitations.md)

---

# 13｜Roadmap and Known Limitations

> **Maturity:** PENDING_EXPERIMENT (roadmap defined; timeline requires empirical calibration)
> **Corresponding original sections:** Part XII + XXII + XXIII (perpetual-motion problem, roadmap, known limitations and risks)

---

## 13.1 The Perpetual-Motion Problem

### What Makes It Look Like a Perpetual-Motion Machine

This framework resembles a perpetual-motion machine:

- D↓ produces an answer → U↑ audits → divergence feeds back to D↓ → D↓ improves → audited again by U↑
- If the two keep improving each other, will the loop run forever?

### Why Complete Convergence Will Not Happen

1. **Directional asymmetry:** D↓ and U↑ operate in opposite cognitive directions; they cannot fully align
2. **Purpose vector is fixed:** The purpose vector is locked by a human; both models align to the same external reference
3. **Divergence is structural:** Certain problems inherently admit multiple legitimate answers; divergence is reasonable
4. **Human sampling intervenes:** Periodic human calibration prevents drift

### Core Research Questions

1. Will the two models converge to the same behavioral pattern?
2. Will the divergence signal decay over the course of training?
3. What is the minimum viable frequency of human sampling?
4. Will synthetic data lead to collapse?

---

## 13.2 Implementation Roadmap

### Phase 0: Prototype Validation (1–2 months)

- Use off-the-shelf models to simulate D↓ and U↑ via prompting
- Validate the divergence system on the FA4 case
- Collect initial divergence samples
- **Deliverable:** Divergence system prototype + initial sample set

### Phase 1: Control Plane (2–3 months)

- Implement the purpose-vector schema
- Implement the Gate Engine (PASS / FAIL / UNCERTAIN / INSUFFICIENT_EVIDENCE / AMBIGUOUS)
- Implement the Evidence Receipt system
- **Deliverable:** Control-plane API + evidence system

### Phase 2: Panel Construction (3–4 months)

- Build a Panel of AIs (multiple models producing independent output)
- Implement a cross-review mechanism
- Implement a divergence classifier
- **Deliverable:** Panel prototype + divergence classifier

### Phase 3: Training (4–6 months)

- Train U↑ (inverse database)
- Preference training (divergence samples)
- Improve D↓ (U↑ feedback)
- **Deliverable:** Trained D↓ and U↑

### Phase 4: Human Sampling System (6–7 months)

- Implement a human sampling strategy
- Build a human-feedback interface
- Establish calibration baselines
- **Deliverable:** Human sampling system

### Phase 5: Scale-up (7–12 months)

- Expand to more engineering domains
- Automate work-item generation
- Continuous calibration and monitoring
- **Deliverable:** Deployable bidirectional adversarial system

---

## 13.3 Known Limitations and Risks

### Evidence-Integrity Guarantee

- **Risk:** The system may accept incomplete evidence chains
- **Mitigation:** Enforce evidence-claim binding + integrity checks

### Purpose-Lock Incompleteness and Specification Gaming

- **Risk:** Models may find loopholes in the purpose vector
- **Mitigation:** Periodic human audit of the purpose vector + red-team testing

### Whether Inverse Causal Inference Is Well-Posed

- **Risk:** Tracing causes back from effects may admit multiple legitimate explanations
- **Mitigation:** Divergence system handles multiple explanations + human adjudication

### Judge Deception

- **Risk:** D↓ and U↑ may learn to deceive the judge
- **Mitigation:** Multi-judge heterogeneity + human sampling

### Synthetic-Data Collapse

- **Risk:** Training on synthetic data may reduce diversity
- **Mitigation:** Preserve a proportion of real data + diversity monitoring

### Upward Model Vacuity

- **Risk:** U↑ may learn to produce output that "looks like an audit" but carries no substantive content
- **Mitigation:** Enforce evidence binding + specificity checks

### Downward Model Learns to Deceive the Upward Model

- **Risk:** D↓ may learn to produce answers that U↑ will not challenge
- **Mitigation:** Adversarial training + human sampling
