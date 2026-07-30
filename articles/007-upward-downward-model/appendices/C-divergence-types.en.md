[← Back to technical index](../TECHNICAL_INDEX.en.md) | **English** | [繁體中文](C-divergence-types.md)

---

# Appendix C: Divergence Types

> **Maturity:** PROVISIONAL (divergence types require experimental calibration)

---

## C.1 Divergence Type Definitions

| Type | Definition | Detection Method | Possible Cause |
|------|------------|-----------------|----------------|
| Route Divergence | D↓ and U↑ disagree on the current route | Compare route ID | Insufficient route evidence |
| Numeric Divergence | D↓ and U↑ disagree on numeric analysis | Compare first divergence | Insufficient numeric evidence |
| Purpose Divergence | D↓ and U↑ disagree on purpose understanding | Compare purpose vector | Ambiguous purpose vector |
| Evidence Divergence | D↓ and U↑ disagree on evidence interpretation | Compare evidence-claim binding | Contradictory evidence |
| Gate Divergence | D↓ and U↑ disagree on gate status | Compare gate status | Ambiguous gate conditions |

## C.2 Divergence Degree

| Degree | Definition | Action |
|--------|------------|--------|
| Minor Divergence | Answers agree, confidence differs slightly | Take the higher-confidence answer |
| Moderate Divergence | Answers agree, but route/gate judgment differs | Classify divergence + dispatch |
| Severe Divergence | Answers disagree | Abstain + human adjudication |

## C.3 Divergence Processing Flow

```
1. Detect divergence
2. Classify divergence type
3. Assess divergence degree
4. Assess uncertainty
5. Decide action:
   - Minor divergence → take the higher-confidence answer
   - Moderate divergence → dispatch to collect evidence
   - Severe divergence → abstain + human adjudication
6. Record divergence sample
7. Divergence sample → retraining data
```
