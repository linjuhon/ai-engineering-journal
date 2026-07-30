[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](05-upward-downward-model.md)

---

# 05｜Downward Model and Upward Model

> **Maturity:** PROVISIONAL (concept finalized; training framework not yet implemented)
> **Corresponding source section:** Part IV + V (abstracting engineering methodology into AI training philosophy, downward model and upward model)

---

## 5.1 Problems with Existing Models: Only Capable of Downward Reasoning

The essence of existing language models is **predicting the next token from context**. This mechanism is effective for generating fluent text, but has a structural defect when it comes to "inferring causes from results":

- Models are good at generating steps from a purpose (downward), but not at inferring purpose from steps (upward)
- Models are good at deriving local conclusions from details, but not at reviewing global assumptions from local conclusions
- Models are good at producing answers, but not at judging "whether sufficient evidence exists to produce an answer"

---

## 5.2 The Reverse Abstraction You Proposed

The core of reverse abstraction is:

```
See details
→ Reason upward
→ Find purpose / route / gate / contract
→ Assess uncertainty
→ Abstain if evidence is insufficient
→ Issue a precise work order
```

This is not "talking in reverse," but a **different cognitive direction**: inferring intent from results, root cause from patch, and the whole from the parts.

---

## 5.3 Downward Model D↓

The downward model generates details from a purpose.

**Input:** purpose vector + task description + context

**Output:** answer, code, report, execution trace

**Behavioral characteristics:**

- Good at moving from abstract to concrete
- Good at producing complete solutions
- Good at following formats and contracts
- Prone to premature patch (fixing as soon as details are seen)
- Prone to covering uncertainty with narrative

---

## 5.4 Upward Model U↑

The upward model infers purpose upward from results.

**Input:** result, details, report, trace + original purpose vector

**Output:** inferred purpose, gate status, causal chain, uncertainty assessment, bounded next dispatch

**Behavioral characteristics:**

- Good at moving from concrete to abstract
- Good at auditing claim-to-evidence binding
- Good at identifying false successes
- Good at assessing uncertainty
- Prone to being overly conservative (requires calibration)

---

## 5.5 Not an Ordinary Planner/Executor

This is not a planner/executor architecture:

| Architecture | Division of Labor | 007's Difference |
|---|---|---|
| Planner/Executor | One plans, one executes | Both produce answers, competing under the same purpose vector |
| Solver-Verifier | One solves, one verifies | The upward model is not verification; it infers purpose from results |
| Debate | Two models debate | Not a debate, but complementary recombination |
| GAN | Generator vs. Discriminator | Not true/false classification, but bidirectional purpose alignment |

Downward and upward are **two cognitive directions**, not a hierarchy.
