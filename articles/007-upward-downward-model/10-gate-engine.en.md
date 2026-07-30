[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](10-gate-engine.md)

---

# 10 | Gate Engine, Divergence System, and Evidence System

> **Maturity:** PROVISIONAL (gate states defined; divergence classification needs experimentation)
> **Corresponding source sections:** Part XV + XVI + XVII (Gate Engine, Divergence System, Evidence System)

---

## 10.1 Gate States

Each truth gate has five possible states:

| State | Definition | Next Action |
|-------|-----------|-------------|
| **PASS** | Sufficient evidence, gate passes | Unlock next gate |
| **FAIL** | Evidence shows gate did not pass | Lock all subsequent gates, report failure reason |
| **UNCERTAIN** | Insufficient evidence to determine PASS or FAIL | Trigger divergence system |
| **INSUFFICIENT_EVIDENCE** | Lacks necessary evidence | Dispatch a bounded next dispatch to collect evidence |
| **AMBIGUOUS** | Evidence points to contradictory conclusions | Trigger divergence system + human adjudication |

---

## 10.2 FA4 Gate Sequence

```
Gate 1: Route Truth
  PASS → Unlock Gate 2
  FAIL → Stop, report route error

Gate 2: Numeric Truth
  PASS → Unlock Gate 3
  FAIL → Report first divergence, no patch allowed

Gate 3: Quality Truth
  PASS → Unlock Gate 4
  FAIL → Report quality issue, no optimization allowed

Gate 4: Performance Truth
  PASS → Complete
  FAIL → Report performance issue
```

---

## 10.3 GateSpec Example

```yaml
gate_id: G1
name: Route Truth
entry_condition: binary/source/hash aligned
checkpoints:
  - clean build exists
  - native FP4 nb=1 enters target route
  - mixed FP4 fail-closed
  - fallback excluded
  - stale binary excluded
pass_condition: all checkpoints PASS
fail_condition: any checkpoint FAIL
uncertain_condition: checkpoint evidence insufficient
next_gate: G2
```

---

## 10.4 Divergence Types

| Divergence Type | Definition | Possible Cause |
|----------------|-----------|---------------|
| Route divergence | D↓ and U↑ disagree on current route | Insufficient route evidence |
| Numeric divergence | D↓ and U↑ disagree on numeric analysis | Insufficient numeric evidence |
| Purpose divergence | D↓ and U↑ disagree on purpose understanding | Purpose vector ambiguous |
| Evidence divergence | D↓ and U↑ disagree on evidence interpretation | Evidence contradictory |
| Gate divergence | D↓ and U↑ disagree on gate state judgment | Gate condition ambiguous |

---

## 10.5 Divergence as Primary Output

Divergence is not a system failure mode—it is the **system's primary sensor for its own uncertainty**.

Divergence handling flow:

1. Detect divergence (D↓ vs U↑ inconsistency)
2. Classify divergence (route / numeric / purpose / evidence / gate)
3. Assess uncertainty (divergence degree + confidence)
4. Determine action (collect evidence / abstain / dispatch / human adjudication)
5. Record divergence (divergence sample → retraining data)

---

## 10.6 Evidence Receipt

Each piece of evidence must include:

```yaml
evidence_id: str
type: binary | log | test_result | oracle | human_feedback
source: str
timestamp: datetime
content_hash: str
claim_id: str
binding_strength: direct | indirect | circumstantial
validity: valid | invalid | expired | superseded
```

---

## 10.7 Evidence Integrity

Evidence integrity checks:

1. **Binding check**: Does each claim have corresponding evidence?
2. **Validity check**: Is the evidence still valid (not expired, not superseded)?
3. **Consistency check**: Do multiple pieces of evidence point to the same conclusion?
4. **Completeness check**: Is any critical evidence missing?

---

## 10.8 Claim-Evidence Binding

The binding between claims and evidence is the system's core governance mechanism:

- Any claim must bind at least one piece of evidence
- Any evidence must indicate the claim it binds to
- Unbound claim → automatically marked as "unverified"
- Evidence with invalid binding → automatically marks the claim as "evidence expired"
