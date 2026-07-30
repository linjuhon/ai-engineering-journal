[← Back to technical index](../TECHNICAL_INDEX.en.md) | **English** | [繁體中文](B-risk-register.md)

---

# Appendix B: Risk Register

> **Maturity:** PROVISIONAL (risks must be updated continuously)

---

| ID | Risk | Probability | Impact | Mitigation | Status |
|----|------|-------------|--------|------------|--------|
| R-01 | Boundary blur between A and B (B starts reading A's raw output directly) | Medium | High | Contract tests + CI checks + architecture review | Active |
| R-02 | C's dimensions overridden by average score (traffic light logic bypassed) | High | High | Traffic light logic enforcement + uncertainty mechanism | Active |
| R-03 | D learns human shortcuts (only outputs proposals humans would approve) | Medium | Medium | Enforce confidence + alternative_view + counterexample training | Active |
| R-04 | E's vector injection suppresses B's diversity | Low | High | Diversity monitoring + stop condition (stop if drop >10%) | Active |
| R-05 | Error self-reinforcement during cold start (C's early misjudgments treated as truth) | Medium | High | First 200 cases shadow + human anchoring + calibration cycles | Active |
| R-06 | Data leakage (cross-tradition/cross-client data mixing) | Medium | High | Six-layer isolation + tradition_id preservation + authorization checks | Active |
| R-07 | Early annotator bias (first 200 users do not represent general users) | High | Medium | First 200 cases shadow-only + establish bias baseline | Active |
| R-08 | Performance budget not closed (sync path latency too high) | Medium | Medium | Explicit p95 definition + optional stages + parallel optimization | Active |
| R-09 | Model update regression (new version performs worse on historical cases) | Medium | High | Backtesting + Canary + rollback mechanism | Mitigated |
| R-10 | Safety overridden by majority vote (A/B/C/D voting overrides Safety red light) | Low | High | Safety is independent + cannot be overridden by majority vote (Constitution V) | Mitigated |
