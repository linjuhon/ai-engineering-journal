[← Back to technical index](../TECHNICAL_INDEX.en.md) | **English** | [繁體中文](E-test-cases.md)

---

# Appendix E: Test Cases

> **Maturity:** PROVISIONAL (test cases require ongoing expansion)

---

## E.1 Constitution Acceptance Tests

| Test | Method | Pass Condition |
|------|--------|---------------|
| Constitution Completeness | Verify 01-thesis-and-constitution.md contains all 12 articles | All 12 articles present |
| Constitution Non-Contradiction | No two articles must conflict | No logical contradictions |
| Constitution Enforceability | Each article has a corresponding implementation mechanism | Implementation exists in corresponding section |

## E.2 Component Boundary Tests

| Test | Method | Pass Condition |
|------|--------|---------------|
| Contract Completeness | Each component defines Allowed/Forbidden/Failure/Fallback | All defined |
| Isolation Check | A and B have no direct communication path | Communication only via Planner |
| Safety Independence | Safety red light must not be overridable by voting | Constitution Article V implementation |

## E.3 Data Engineering Tests

| Test | Method | Pass Condition |
|------|--------|---------------|
| Six-Layer Completeness | Each layer has definition, content, and immutability rules | All defined |
| Index Completeness | Every record has complete index fields | Schema complete |
| OOD Hold-Out | Test set and training set must have no tradition overlap | At least one hold-out strategy defined |

## E.4 Pipeline Tests

| Test | Method | Pass Condition |
|------|--------|---------------|
| Sync Path Completeness | Each stage has input/output definitions | All defined |
| Failure Degradation | Each failure point has a degradation strategy | All defined |
| Emotion Hook Validity | Hook types and failure handling defined | All defined |

## E.5 Cold-Start Tests

| Test | Method | Pass Condition |
|------|--------|---------------|
| Five-Stage Completeness | Each stage has entry/exit conditions | All defined |
| First 200 Shadow Posts | Shadow recording mechanism defined | Defined |
| Self-Distillation Threshold | Threshold conditions and calibration mechanism defined | Defined |

## E.6 Control Plane Tests

| Test | Method | Pass Condition |
|------|--------|---------------|
| Dimension Completeness | Each dimension has a complete definition format | All 50 initial dimensions complete |
| Traffic Light Logic | Red/yellow/green logic must be executable | Pseudocode translatable to implementation |
| Uncertainty Mechanism | Low confidence triggers automatic yellow light | Mechanism defined |

## E.7 Governance Tests

| Test | Method | Pass Condition |
|------|--------|---------------|
| C→D Trigger | Yellow light triggers complete D workflow | Defined |
| D Proposal Format | JSON schema complete | Defined |
| Backtest/Canary/Rollback | Three-layer verification mechanism complete | Defined |

## E.8 Semantic Bridge Tests

| Test | Method | Pass Condition |
|------|--------|---------------|
| Research Hypothesis Tagging | E content tagged as RESEARCH_HYPOTHESIS | Tagged |
| Falsifiability Condition | Clear stopping condition defined | Defined |
| Activation Condition | Clear activation threshold defined | Defined |

## E.9 Experiment Track Tests

| Test | Method | Pass Condition |
|------|--------|---------------|
| Experiment Design Completeness | Experiments A1/A2/A3 fully defined | Defined |
| Hardware Decision Chain | Decision logic complete | Defined |
| Risk Matrix | Risks registered | Appendix B |
