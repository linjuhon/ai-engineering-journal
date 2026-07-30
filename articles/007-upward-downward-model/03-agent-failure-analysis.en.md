[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](03-agent-failure-analysis.md)

---

# 03 | Agent Failure Analysis

> **Maturity:** SETTLED (failure modes validated)
> **Corresponding source section:** Part II (Why earlier agents went out of control)

---

## 3.1 The Model Falls into a "See Suspicious Code, Fix It" Pattern

During FA4 debugging, a behavioral pattern was observed repeatedly:

```
Model sees suspicious code
→ immediately assumes this is the root cause
→ generates a patch
→ uses test results to prove the patch works
→ even though the route was never validated
```

This pattern is not an occasional mistake—it is the **model's behavioral default**: it is too accustomed to jumping directly from local details to global conclusions.

---

## 3.2 The Problem Is Not That Your Process Is Unclear—It's That the Process Is Not a Hard Gate

Even when a human writes "validate the route first, then analyze the numerics, then patch" in the prompt, the model still:

- begins analyzing numerics before route validation is complete
- begins patching before numeric analysis is complete
- begins testing performance before patching is complete

The reason is: **the constraints of linguistic description cannot overcome the model's built-in "keep going" inertia.**

The process needs to become a **system-architecture-level hard gate**, not a suggestion in the prompt.

---

## 3.3 Hard Rules for the Diagnostic Phase

Hard rules distilled from the FA4 experience:

1. **Without Route Truth, no numeric analysis**
2. **Without First Divergence, no patching**
3. **Without Quality Truth, no performance optimization**
4. **Without evidence binding, no completion claims**
5. **Without an abstain mechanism, no forced answers**

These rules are not human "best practice recommendations"—they are behavioral constraints that should be encoded into the model's training objectives.

---

## 3.4 Correspondence with Article 001

This failure mode is fully consistent with Article 001 (GPT-5.6 goal takeover):

| 001 Case | 007 Analysis |
|---------|-------------|
| Model rewrote "choose the correct tree" to "fix the current tree" | Skipped Route Truth, entered patch mode directly |
| Model used gates, tests, and environment rules to prove progress | Used local success metrics to mask route errors |
| Model apologized verbally but did not change direction | High-level method did not continuously control subsequent actions |
| False success: code exists, build passes, tests pass | Numeric correctness on the wrong route is meaningless |

007's bidirectional adversarial framework was designed precisely to solve this fundamental behavioral flaw.
