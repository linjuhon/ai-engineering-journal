[← Back to technical index](../TECHNICAL_INDEX.en.md) | **English** | [繁體中文](A-gate-specs.md)

---

# Appendix A: Gate Specs

> **Maturity:** PROVISIONAL (spec must be updated in sync with implementation)

---

## A.1 GateSpec Schema

```yaml
gate_id: str
name: str
entry_condition: str
checkpoints: list[str]
pass_condition: str
fail_condition: str
uncertain_condition: str
insufficient_evidence_condition: str
ambiguous_condition: str
next_gate: str | null
fallback_gate: str | null
timeout_ms: int
retry_limit: int
```

## A.2 Route Truth GateSpec

```yaml
gate_id: G1
name: Route Truth
entry_condition: binary/source/hash aligned
checkpoints:
  - clean build exists
  - native FP4 nb=1 enters target CUDA route
  - allowed route entry checkpoint exists
  - allowed route exit checkpoint exists
  - mixed FP4 fail-closed
  - nb>1 unsupported / fail-closed
  - fallback excluded
  - vec false route not mistaken for native FP4 success
  - stale binary excluded
pass_condition: all checkpoints PASS
fail_condition: any checkpoint FAIL
uncertain_condition: checkpoint evidence insufficient
insufficient_evidence_condition: missing critical checkpoint evidence
ambiguous_condition: checkpoint evidence contradictory
next_gate: G2
fallback_gate: null
timeout_ms: 30000
retry_limit: 3
```

## A.3 Numeric Truth GateSpec

```yaml
gate_id: G2
name: Numeric Truth
entry_condition: G1 PASS
checkpoints:
  - P0 input / tensor metadata
  - P1 FP4 block bytes / scale / nibble
  - P2 dequant Q/K/V
  - P3 QK score / MMA
  - P4 mask / scale
  - P5 online softmax
  - P6 p_all / probability
  - P7 V load / V decode
  - P8 P·V accumulation
  - P9 normalize
  - P10 output store
  - P11 final GPU vs oracle
pass_condition: all checkpoints within tolerance
fail_condition: first divergence exists
uncertain_condition: checkpoint data incomplete
insufficient_evidence_condition: missing oracle comparison baseline
ambiguous_condition: multiple checkpoints diverge simultaneously
next_gate: G3
fallback_gate: G1
timeout_ms: 60000
retry_limit: 2
```

## A.4 Quality Truth GateSpec

```yaml
gate_id: G3
name: Quality Truth
entry_condition: G2 PASS
checkpoints:
  - PPL regression or improvement
  - downstream tasks unaffected
  - numeric correctness consistent across configurations
  - fix does not introduce new numeric instability
pass_condition: all quality metrics within threshold
fail_condition: any quality metric exceeds threshold
uncertain_condition: quality metric data insufficient
insufficient_evidence_condition: missing downstream task evaluation
ambiguous_condition: quality metrics inconsistent across configurations
next_gate: G4
fallback_gate: G2
timeout_ms: 120000
retry_limit: 2
```

## A.5 Performance Truth GateSpec

```yaml
gate_id: G4
name: Performance Truth
entry_condition: G3 PASS
checkpoints:
  - latency within budget
  - throughput meets target
  - performance consistent across hardware configurations
  - performance improvement built on correct numeric and quality foundation
pass_condition: all performance metrics within threshold
fail_condition: any performance metric exceeds threshold
uncertain_condition: performance data insufficient
insufficient_evidence_condition: missing hardware configuration baseline
ambiguous_condition: performance inconsistent across hardware configurations
next_gate: null
fallback_gate: G3
timeout_ms: 120000
retry_limit: 2
```
