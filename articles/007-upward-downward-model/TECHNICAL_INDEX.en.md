[← Back to article page](README.md) | **English** | [繁體中文](TECHNICAL_INDEX.md)

---

# Upward Model × Downward Model: Reverse-Abstraction Post-Training and the Uncertainty-Facing Framework

> **Article Type:** AI Training Architecture / Bidirectional Adversarial Post-Training
> **Maturity:** PROVISIONAL (engineering truth gates validated; bidirectional adversarial training framework not yet implemented)
> **Version:** 2026-07-30
> **Corresponding Articles:** 001 (engineering case study), 005 (global intelligence theory), 006 (A–E construction specification)

---

## Problem Definition

Existing AI systems have a fundamental behavioral flaw: **models jump too easily from details directly to patches, skipping route verification, skipping causal diagnosis, skipping uncertainty assessment.**

Typical behavior chain: see suspicious code → guess root cause downward → patch → cover uncertainty with a polished narrative → claim completion.

This is especially dangerous in engineering scenarios: fixing the wrong route is worse than not fixing, and false success is harder to detect than obvious failure.

---

## One-Sentence Core Architecture

> **One model is responsible for generating details downward from purpose (downward model D↓); the other model is responsible for reasoning upward from results, details, reports, and traces back to purpose, contract, gate, and causal chain (upward model U↑). Both produce answers, and compete, complement, reorganize, and retrain under the same purpose vector.**

---

## Four-Layer Architecture

| Layer | Content | Maturity |
|-------|---------|----------|
| **Engineering Method** | FA4 Four-Layer Truth Gate: Route → Numeric → Quality → Performance | SETTLED |
| **Model Behavior** | Downward Model D↓ vs Upward Model U↑ | PROVISIONAL |
| **Training Framework** | Goal-Locked Bidirectional Adversarial Post-Training | PROVISIONAL |
| **Uncertainty** | Uncertainty-Facing Framework: identify, express, calibrate, manage | PROVISIONAL |

---

## Relationship to Existing Articles

| Article | Relationship |
|---------|-------------|
| **001** | 007's "upward model audits claims, detects false success" is precisely the systematic solution to the 001 case (GPT-5.6 goal takeover) |
| **005** | 005 proposes the "global intelligence" theoretical framework; 007 is a more concrete bidirectional adversarial post-training architecture; the two complement each other |
| **006** | 006's A–E system (C control surface, D governance loop, truth gates) shares the same DNA as 007's engineering truth gates, but 007 abstracts them into a general framework |

---

## Chapter Directory

| Chapter | Content | Maturity |
|---------|---------|----------|
| [01 — Core Thesis](01-core-thesis.en.md) | One-sentence summary, core contradiction, four-layer solution | SETTLED |
| [02 — Engineering Origin](02-engineering-origin.en.md) | Full definition of FA4 Four-Layer Truth Gate | SETTLED |
| [03 — Agent Failure Analysis](03-agent-failure-analysis.en.md) | Why agents lose control, premature patch pattern | SETTLED |
| [04 — S Track and Route Lock](04-s-track-and-route-lock.en.md) | S Track, Route Lock, State Lock, Reference Contract | SETTLED |
| [05 — Downward Model and Upward Model](05-upward-downward-model.en.md) | Definition and behavioral characteristics of D↓ and U↑, differences from planner/executor | PROVISIONAL |
| [06 — True Adversarial Dual Model](06-adversarial-training.en.md) | Not solver-verifier, but bidirectional adversarial | PROVISIONAL |
| [07 — Purpose Vector and Three Locks](07-purpose-vector-and-scoring.en.md) | 20-dimensional purpose vector, Purpose/Event Gate/Dual Format Lock | PROVISIONAL |
| [08 — Reverse Problem Design](08-problem-design.en.md) | Engineering upward problem types, work order generation, reverse database, trace decompilation | PROVISIONAL |
| [09 — Uncertainty-Facing Framework](09-uncertainty-framework.en.md) | Confidence calibration, uncertainty source classification, calibration reward/penalty | PROVISIONAL |
| [10 — Gate Engine](10-gate-engine.en.md) | Gate states, divergence system, evidence system, Claim-Evidence binding | PROVISIONAL |
| [11 — Training Objectives](11-training-objectives.en.md) | Calibration, divergence classification, uncertainty attribution, training sequence, human sampling | PROVISIONAL |
| [12 — Comparison with Existing Frameworks](12-comparison-with-existing.en.md) | GAN/AlphaZero/RLHF/Debate/Solver-Verifier difference analysis | SETTLED |
| [13 — Roadmap and Limitations](13-roadmap-and-limitations.en.md) | 6-phase roadmap, perpetual motion problem, known risks | PENDING_EXPERIMENT |

### Appendices

| Appendix | Content |
|----------|---------|
| [A — Gate Specs](appendices/A-gate-specs.en.md) | Complete GateSpec for the Four-Layer Truth Gate |
| [B — Evidence Schema](appendices/B-evidence-schema.en.md) | Evidence Receipt, Claim, binding rules |
| [C — Divergence Types](appendices/C-divergence-types.en.md) | Divergence type definitions, degree, processing flow |
| [D — Training Curriculum](appendices/D-training-curriculum.en.md) | 5-phase training curriculum |
| [E — Core Glossary](appendices/E-glossary.en.md) | 21 core vocabulary definitions |

### Sources

| File | Description |
|------|-------------|
| [sources/README.md](sources/README.md) | Source list |
| [sources/original-spec.txt](sources/original-spec.txt) | Original consolidated specification (evidence preserved) |
| [sources/original-spec.en.md](sources/original-spec.en.md) | Noncanonical English derivative of the original specification |
