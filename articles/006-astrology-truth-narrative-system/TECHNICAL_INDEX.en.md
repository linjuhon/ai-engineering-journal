[← Back to article page](README.md) | **English** | [繁體中文](TECHNICAL_INDEX.md)

---

# A–E Truth–Narrative Symbiotic System: Implementation Specification

> **Article Type:** Normative Implementation Specification
> **Maturity:** Mixed (per-chapter annotation)
> **Version:** 2026-07-30
> **Related Articles:** 002 (Product Architecture Overview), 005 (General Intelligence Theory Framework)

---

## Problem Definition

Astrological chart reading faces a fundamental contradiction: **truth demands precision, but humans need stories.**

Traditional solutions force a single model to learn both truth and narrative simultaneously, causing the model to compromise when the two conflict. The A–E system physically isolates five capabilities — truth, narrative, measurement, governance, and semantic bridging — preventing any single component from simultaneously holding full power over definition, creation, scoring, and modification rules.

---

## One-Sentence Core Architecture

> **A is the skeleton, B is the flesh, and C is the dynamic boundary between them; A and B should not converse directly, but intersect in the prototype vector space.**

---

## A–E Component Table

| Component | Name | Core Responsibility | Recommended Model Scale | Maturity |
|-----------|------|-------------------|------------------------|----------|
| **A** | Truth Engine | Truth reasoning and structured output | 13B–31B | SETTLED |
| **B** | Narrative Engine | Free narrative and concretization | 7B–13B | SETTLED |
| **C** | Control Plane | A–B distance measurement, 100-dimension control | 7B–13B | PROVISIONAL |
| **D** | Governance Assistant | Read full text, propose amendments | 31B–70B | SETTLED |
| **E** | Semantic Bridge | Semantic compression and bridging (research phase) | TBD | RESEARCH_HYPOTHESIS |
| **Human** | — | Constitution and final adjudication | — | SETTLED |
| **Safety** | — | Independent baseline check | — | SETTLED |

---

## Reading Order

```
First reading (build overall understanding):
  README.md → 01 → 02 → 06 → 04

Second reading (deep dive into governance and training):
  03 → 05 → 07 → 08 → 09

Appendices (reference):
  Appendices A–E consult on demand
```

---

## Relationship to Other Articles

| Article | Relationship | Description |
|---------|-------------|-------------|
| **002** | Product Architecture Overview | 002 answers "what the entire astrology website is being built as"; this article answers "how the core intelligence is trained, run, and governed" |
| **005** | Theoretical Framework | 005 defines the general intelligence framework; this article is that theory's concrete implementation in the astrology domain |

If 002 conflicts with this article on implementation details, this article takes precedence.

---

## Status Summary

| Chapter | Maturity | Key Uncertainty |
|---------|----------|-----------------|
| 01 Constitution | SETTLED | — |
| 02 Component Boundaries | SETTLED (core contract); PROVISIONAL (model scale) | Model scale requires Experiment A1 |
| 03 Data Engineering | PROVISIONAL | Specific schema and thresholds require verification |
| 04 Pipeline | PROVISIONAL | Async mode requires product requirements |
| 05 Cold Start | PROVISIONAL | Five-stage thresholds require calibration |
| 06 100-Dimension Control Plane | PROVISIONAL | Dimension grouping and thresholds require experimentation |
| 07 Governance | SETTLED (process); PROVISIONAL (thresholds) | Specific thresholds require calibration |
| 08 Semantic Bridge | RESEARCH_HYPOTHESIS | Injection method and effect not verified |
| 09 Experiment Roadmap | PENDING_EXPERIMENT | Hardware decisions depend on experimental results |

---

## Chapter Directory

| Chapter | Content |
|---------|---------|
| [01 — Thesis and System Constitution](01-thesis-and-constitution.en.md) | Core contradiction, 12 articles of constitution, escape definition, Safety baseline |
| [02 — Component Boundaries](02-component-boundaries.en.md) | A/B/C/D/E/Human/Safety complete contract |
| [03 — Data Engineering](03-data-engineering.en.md) | Six-layer data model, 20+ school index, OOD holdout |
| [04 — Runtime Pipeline](04-runtime-pipeline.en.md) | Synchronous path, emotion hook, dedup marking, failure degradation |
| [05 — Cold Start and Training](05-cold-start-and-training.en.md) | Five stages, first 200 shadow articles, self-distillation threshold |
| [06 — 100-Dimension Control Plane](06-control-plane-100d.en.md) | 50 initial dimensions, traffic light logic, uncertainty mechanism |
| [07 — Governance and Evolution](07-governance-and-evolution.en.md) | C→D trigger, D proposal, human adjudication, backtest/Canary/rollback |
| [08 — 1024-Dimension Semantic Bridge](08-semantic-bridge-1024d.en.md) | E_truth/E_text separation, injection hypothesis, endgame research |
| [09 — Experiment and Hardware Roadmap](09-experiment-and-hardware-roadmap.en.md) | Experiments A1/A2/A3, hardware decision chain, 20-step crosswalk |

### Appendices

| Appendix | Content |
|----------|---------|
| [A — Component Contracts and Schemas](appendices/A-contracts-and-schemas.en.md) | A/B/C/D/E complete JSON schema |
| [B — Risk Register](appendices/B-risk-register.en.md) | Risk matrix and mitigation measures |
| [C — Decision Ledger](appendices/C-decision-ledger.en.md) | Decided/provisional/deprecated/research hypothesis |
| [D — Twenty-Step Crosswalk](appendices/D-twenty-step-crosswalk.en.md) | Original 0–20 steps → formal chapter mapping |
| [E — Test Cases](appendices/E-test-cases.en.md) | Per-chapter acceptance tests |

### Sources

| Document | Description |
|----------|-------------|
| [sources/README.md](sources/README.md) | Source list and superseded sections |
| [sources/original-complete-spec.docx](sources/original-complete-spec.docx) | Original integrated specification (evidence retention) |
| [sources/original-complete-spec.en.md](sources/original-complete-spec.en.md) | Noncanonical English derivative of the original specification |
