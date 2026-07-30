[← Back to technical index](../TECHNICAL_INDEX.en.md) | **English** | [繁體中文](E-glossary.md)

---

# Appendix E: Core Glossary

> **Maturity:** SETTLED
> **Corresponding source section:** Part XXVI (Core Glossary)

---

| Term | Definition |
|------|------------|
| **Route Truth** | The first Truth Gate: confirms whether execution is following the correct route. |
| **Numeric Truth** | The second Truth Gate: locates the First Divergence after the route is confirmed. |
| **Quality Truth** | The third Truth Gate: confirms that quality remains acceptable after the repair. |
| **Performance Truth** | The fourth Truth Gate: confirms that performance meets its target after the repair. |
| **S Track** | The only permitted correct execution path, with explicit entry and exit checkpoints. |
| **Route Lock** | A route-sealing mechanism that locks execution to the S Track and excludes every other route. |
| **State Lock** | A state-locking mechanism that ensures the system state does not change during analysis. |
| **First Divergence** | The first position where the difference between actual and expected exceeds the tolerance. |
| **Repair Permission** | Permission to repair: patching is allowed only after Numeric Truth passes. |
| **Downward Model (D↓)** | A model that generates details downward from the purpose. |
| **Upward Model (U↑)** | A model that infers the purpose upward from the result. |
| **Purpose Lock** | Locks the purpose vector so it cannot be changed without authorization. |
| **Event Gate Lock** | Unlocks the next gate only when the current gate emits a passing event. |
| **Dual Format Lock** | Requires D↓ and U↑ to use the same output format. |
| **Canonical Event Graph** | The standard sequence of passing events across the Truth Gates. |
| **Reverse Work-Order Synthesis** | Infers a task description backward from a result. |
| **Trajectory-to-Intent Compilation** | Reconstructs intent from an execution trajectory. |
| **Goal-Locked Bidirectional Adversarial Post-Training** | The framework's core training method: bidirectional adversarial post-training with the purpose locked. |
| **Uncertainty Profile** | A structured expression of the system's uncertainty about itself. |
| **Evidence Receipt** | The standardized record format for each piece of evidence. |
| **Bounded Next Dispatch** | Issues a precise, bounded next action when the system is uncertain. |
