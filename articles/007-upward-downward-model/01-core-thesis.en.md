[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](01-core-thesis.md)

---

# 01 | Core Thesis

> **Maturity:** SETTLED (core proposition)
> **Corresponding source section:** Part 0 (One-Sentence Summary)

---

## 1.1 One-Sentence Summary

This is not an ordinary prompt, not a set of pure engineering workflows, not a reviewer-agent, but a **bidirectional, adversarial-coordinative, uncertainty-calibrated post-training capability alignment framework**.

Its core is:

> One model is responsible for generating details downward from purpose; the other model is responsible for reasoning upward from results, details, reports, and traces back to purpose, contract, gate, and causal chain.
> Both produce answers, and compete, complement, reorganize, and retrain under the same purpose vector.
> The system does not rush to produce a determinate answer; instead it first judges whether there is currently sufficient evidence to enter the next truth gate; when evidence is insufficient, it must honestly abstain and emit a precise bounded next dispatch.

The ultimate goal is not to make AI better at "guessing answers," but to teach AI:

```
Upon seeing details, do not immediately revise downward;
first reason upward:
Which route does this detail belong to?
Which gate?
Which contract?
Which human intent?
Is there currently sufficient qualification to proceed to the next step?
```

This is a **reverse abstraction ability**.

---

## 1.2 Core Contradiction

Existing AI systems (especially large language models) have a fundamental behavioral flaw:

> **Models jump too easily from details directly to patches, skipping route verification, skipping causal diagnosis, skipping uncertainty assessment.**

Typical behavior chain:

```
See suspicious code
→ Guess root cause downward
→ Patch
→ Cover uncertainty with a polished narrative
→ Claim completion
```

This is especially dangerous in engineering scenarios because:

- Fixing the wrong route is worse than not fixing (introduces new bugs, contaminates evidence)
- False success is harder to detect than obvious failure (complete narrative, tests pass, but root problem remains unsolved)
- Uncertainty is hidden rather than managed (the model does not say "I am uncertain," but fabricates a plausible answer)

---

## 1.3 Core Solution

### Engineering Layer: Four-Layer Truth Gate

```
Route Truth → Numeric Truth → Quality Truth → Performance Truth
```

- If Route does not pass, numeric root cause is not allowed
- If Numeric has no first divergence, patching is not allowed
- If Quality does not pass, performance is not allowed
- Performance cannot be built on a wrong route or false success

### Model Layer: Downward Model × Upward Model

- **Downward Model D↓**: generates answers, code, reports downward from purpose (purpose vector)
- **Upward Model U↑**: reasons upward from results, details, traces back to purpose, contract, gate, causal chain
- The two compete, complement, reorganize, and retrain under the same purpose vector

### Training Layer: Goal-Locked Bidirectional Adversarial Post-Training

```
Goal-Locked Bidirectional Adversarial Post-Training
```

- Not an ordinary prompt
- Not an ordinary reviewer
- Not ordinary debate
- Not a solver-verifier

### Uncertainty Layer: Uncertainty-Facing Framework

The system's ultimate goal is not to "always give a determinate answer," but:

```
Identify uncertainty → Express uncertainty → Calibrate uncertainty
→ Face uncertainty → Abstain when evidence is insufficient
→ Emit bounded next dispatch under uncertainty
```

Divergence is not noise. Divergence is the system's primary sensor for its own uncertainty.

---

## 1.4 Relationship to Existing Articles

| Article | Relationship |
|---------|-------------|
| **001** | 007's "upward model audits claims, detects false success" is precisely the systematic solution to the 001 case (GPT-5.6 goal takeover) |
| **005** | 005 proposes the "global intelligence" theoretical framework (cognitive dispatcher, saturation estimation, paradigm shift); 007 is a more concrete bidirectional adversarial post-training architecture; the two complement each other |
| **006** | 006's A–E system (C control surface, D governance loop, truth gates) shares the same DNA as 007's engineering truth gates (Route/Numeric/Quality/Performance), but 007 abstracts them into a general framework |
