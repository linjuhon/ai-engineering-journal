[← Back to Article 004](README.md) | [繁體中文](ARCHITECTURE_REVISION_2026-08-07.md) | **English**

---

# Personal Context OS V2 Architecture Revision

## Canonical Context × Skill Federation × Pi Runtime Kernel

**Date:** 2026-08-07  
**Status:** Accepted Architecture Revision  
**Role:** Incremental revision to the 2026-07-30 `FULL_ARTICLE.md`. V1 remains preserved as the design-history baseline. This document supersedes V1 specifically on skill layering, third-party skill compatibility, Pi's full-product role, upward promotion/downward compilation, and data contracts.

> **New core conclusion:** Personal Context OS should not own every Skill. It should own the control semantics around what is currently canonical, who may modify it, which capabilities should run, whether capability outputs may be promoted, and how canonical constraints are compiled downward into executable gates.
>
> **Skills are capabilities; Context OS is the control plane that makes those capabilities operate against the correct reality.**

---

# 1. Why V2 exists

V1 correctly identified the dangerous failure mode in long-horizon AI collaboration: the issue is not merely insufficient chat history, but missing governance over goals, success criteria, boundaries, versions, conflicts, and authority.

V1 modeled Purpose, Criteria, Boundary, State, Plan, Decision, Hypothesis, Interaction, Method, and Evidence as different kinds of Skills. That works inside a closed system, but creates semantic overload once the product must coexist with mature Agent Skill ecosystems.

V2 fixes five problems:

1. Canonical state and procedural capability should not be the same object type.
2. Evidence is not a capability.
3. Third-party Skills may generate their own context/spec/ADR artifacts, creating competing sources of truth unless promotion is governed.
4. Mature Skill ecosystems naturally form primitive → workflow → composite layers that Context OS should preserve rather than rewrite.
5. Pi's SDK and extension model are broad enough to host the complete product, so Pi should be treated as the reference runtime kernel rather than merely a coding adapter.

V2 is a boundary correction, not a rejection of V1.

---

# 2. V1 invariants that remain unchanged

- The current user turn owns conversational focus.
- Purpose, Criteria, and Boundary cannot be silently rewritten by the model.
- tentative/hypothesis can never masquerade as confirmed.
- The Clerk remains the central recorder, differ, conflict checker, and context compiler.
- Question Gate is based on decision ownership, not raw uncertainty.
- Execution Spec remains the frozen pre-execution contract.
- Completion requires external evidence, not model narration.
- Corrections become scoped, versioned, replayable eval cases.

---

# 3. Four planes

```text
Current Turn
    ↓
Governance Plane
    ↓
Canonical Context Plane
    ↓ Context Envelope
Capability / Skill Plane
    ↓
Evidence / Runtime Plane
```

## Governance Plane

Owns authority, scope, conflict, promotion, approval, lifecycle, and execution policy.

## Canonical Context Plane

Owns what is currently valid:

- Purpose
- Criteria
- Boundary
- Current State
- Active Plan
- Confirmed Decisions
- Tentative/Hypotheses
- Interaction Policy

## Capability / Skill Plane

Owns reusable ways of doing work:

- primitive skills
- workflow skills
- composite/domain skills

Sources may include internal Context OS skills, Pi skills, third-party repositories, community skills, and project-local skills.

## Evidence / Runtime Plane

Owns what happened and what supports a claim:

- sessions and tool traces
- Git changes
- tests and logs
- ADRs/specs/CONTEXT.md
- code/media/document artifacts
- external research evidence

Evidence may support a canonical update but never gains automatic write authority.

---

# 4. V1 type migration

| V1 type | V2 location |
|---|---|
| Purpose | Canonical Context |
| Criteria | Canonical Context |
| Boundary | Governance + Canonical Context |
| State | Canonical Context |
| Plan | Canonical Context |
| Decision | Decision Ledger |
| Hypothesis | Canonical Context, non-confirmed |
| Interaction | Split: policy upward, procedural technique downward |
| Method | Capability Skill |
| Evidence | Evidence Plane |

The key correction is simple:

> Long-lived information must be governed, but it does not all need to be called a Skill.

---

# 5. Skill Federation: coexist, do not replace

Context OS must leave room for independent Skill ecosystems.

```text
skills/
├── system/
├── internal/
├── project/
└── external/
    ├── aihero/
    ├── pi/
    ├── vendor-a/
    └── community/
```

## External Skill Non-Overwrite Principle

Context OS may discover, index, classify, route, invoke, constrain, observe, evaluate, wrap, or propose patches for external Skills.

By default it may not:

- silently rewrite third-party Skill source,
- override a third-party Skill because Context OS has a similar method,
- absorb external Skill content into a global prompt as the canonical copy,
- promote external Skill conclusions directly into Canonical Context,
- flatten a third-party primitive/workflow hierarchy merely to fit an internal schema.

Source, namespace, and version must remain traceable.

---

# 6. Mature Skill ecosystems as a validation case

Modern Skill ecosystems already show useful patterns:

- reusable primitives shared by multiple workflows,
- planning/spec/ticket/implementation/review separated by responsibility,
- persistent artifacts such as CONTEXT.md, ADRs, specs, and tickets,
- explicit user-invoked skills where automatic model activation would be undesirable.

Context OS should not compete with these capabilities. It should answer the higher-level question:

> With many capabilities, many projects, and years of decisions, which capability should run now, what canonical context should it receive, what may its output modify, and who owns the final decision when conflicts appear?

---

# 7. Third-party CONTEXT.md / ADR / spec is not automatically canonical

```text
Third-party Skill
    ↓
Artifact
    ↓
Clerk extraction
    ↓
Diff against Canonical Context
    ↓
ContextPatch Proposal
    ↓
Promotion Gate
    ↓
Canonical Context
```

A file named `CONTEXT.md` can be excellent evidence and still lack governance authority.

---

# 8. Dual activation paths

## Canonical Context activation

Purpose, Criteria, Boundary, and Current State are proactively selected by the Context Router. The main model is not expected to remember to request them.

- current turn: focus authority
- confirmed purpose/criteria/boundary: specification authority
- state/history: interpretive background

## Capability Skill activation

Procedural skills may use progressive disclosure:

```text
index / explicit command / workflow dependency
    ↓
select capability
    ↓
load full skill on demand
    ↓
invoke
```

Context OS routes and supplies a clean Context Envelope instead of injecting every procedural Skill every turn.

---

# 9. Pi as the Reference Application Kernel

The complete system can be a Pi SDK application:

```text
Personal Context OS
├── UI
├── Context Domain
├── Governance
├── Skill Federation
├── Clerk
├── Context Compiler
├── Evals
└── Pi Runtime Kernel
    ├── AgentSession
    ├── ModelRuntime
    ├── ResourceLoader
    ├── Extensions
    ├── Tools
    └── Session Events
```

Pi may be the full runtime kernel without defining the product's real-world semantics.

## AgentRuntime boundary

```ts
interface AgentRuntime {
  createSession(config: SessionConfig): Promise<RuntimeSession>;
  run(packet: ContextPacket): Promise<RunResult>;
  abort(sessionId: string): Promise<void>;
}
```

The reference implementation can be only `PiAgentRuntime`.

This abstraction is an engineering boundary, not a claim that another runtime is currently needed.

---

# 10. Multi-session complete form

Separate roles should use separate sessions:

- Chat Session
- Clerk Session
- Execution Session
- Review Session
- Memory Worker
- Eval Session

The Execution Session should receive the frozen ExecutionSpec rather than the full ambiguous history.

---

# 11. Upward Promotion

```text
Skill Result
    ↓
Evidence
    ↓
Reusable candidate
    ↓
ContextPatch Proposal
    ↓
scope classification
    ↓
conflict + regression check
    ↓
approval when required
    ↓
Canonical Context
```

Promote reusable verified rules, not whole procedural Skills.

---

# 12. Downward Compilation

```text
Canonical Boundary
    ↓
Context Compiler
    ↓
ExecutionSpec
    ↓
runtime policy
    ↓
Pi tool-call gate
    ↓
ALLOW / BLOCK / REQUIRE APPROVAL
```

> The upper layer preserves semantic truth; the lower layer turns that truth into machine-enforceable constraints.

---

# 13. Contract revisions

- `ContextPatch`: updates canonical state only.
- `SkillPatch`: updates capability definitions only.
- `SkillInvocation`: records source/version, envelope hash, permissions, and session.
- `SkillResult`: records outputs, proposed decisions, artifacts, evidence, assumptions, and status.
- `ArtifactRef`: tracks CONTEXT.md, ADRs, specs, tickets, code, media, and other outputs.
- `ExecutionSpec`: adds canonical context version, allowed namespaces/tools, forbidden mutations, evidence requirements, and policy hash.

---

# 14. V1 → V2 outcome difference

| Area | V1 | V2 |
|---|---|---|
| Core abstraction | many kinds of Skill | Context / Capability / Evidence / Governance |
| Purpose | Skill | Canonical Context |
| Method | Skill | Capability Skill |
| Evidence | Skill | Evidence / Artifact |
| Third-party skills | underspecified | federated and version-preserving |
| Third-party context docs | may collide with state | artifact → Promotion Gate |
| Loading | broadly unified | proactive canonical + progressive capability |
| State update | SkillPatch | ContextPatch |
| Capability update | ambiguous | SkillPatch |
| Pi | executor adapter | reference application kernel |
| Enforcement | prompt/spec | spec + runtime policy gate |
| Growth model | add more internal Skills | integrate external Skill ecosystems without absorbing them |

V2 positioning:

> **A personal AI control plane built from Canonical Context + Skill Federation + Evidence-Gated Runtime.**

---

# 15. Final architecture

```text
Personal Context OS UI
    ↓
Context / Governance
    ↓ Context Envelope / ExecutionSpec
Skill Federation
    ↓
Pi Runtime Kernel
    ↓
Evidence / Artifact Stores
```

---

# 16. Repository shape

```text
personal-context-os/
├── apps/
├── packages/
│   ├── context-domain/
│   ├── governance/
│   ├── context-store/
│   ├── context-compiler/
│   ├── skill-federation/
│   ├── evidence/
│   ├── evals/
│   └── pi-runtime/
├── services/
├── pi-extensions/
├── context/
├── skills/
├── artifacts/
├── evals/
└── contracts/
```

---

# 17. New evaluation dimensions

- external-skill-non-overwrite
- artifact-promotion
- context-vs-capability-routing
- namespace-integrity
- promotion-scope
- downward-policy-compilation
- runtime-kernel-independence
- multi-session-isolation

---

# 18. Accepted architecture decisions

- Canonical Context and Capability Skill are separate semantic types.
- Evidence is a separate plane.
- External Skills cannot directly overwrite canonical state.
- External context artifacts require promotion.
- Pi is the reference application kernel.
- AgentRuntime remains an abstraction boundary.
- Experience moves upward through Promotion; constraints move downward through Compilation.

---

# 19. Open questions

- Multi-skill control conflicts in one turn.
- Trust/sandbox levels for third-party skills.
- Regression policy when an external Skill version changes.
- Artifact ranking when CONTEXT.md, ADRs, and specs conflict.
- Whether major promotion requires an independent reviewer.
- Whether extension loading order can bypass governance.
- Reproducible Context Envelope hashing across sessions.
- Canonical Context sharding at scale.
- Capability contracts across agent harnesses.
- How structured natural-language boundaries must become before runtime enforcement.

---

# 20. Relationship to Articles 005 and 007

- Article 004: canonical reality, capability routing, authority, execution contract.
- Article 005: method switching and escaping local optima.
- Article 007: upward/downward reasoning and evidence gates.

```text
Evidence / Skill Result
        ↑ Promotion
Canonical Context
        ↓ Compilation
ExecutionSpec / Runtime Gate
```

---

# 21. Final positioning

V1:

> Not longer chat history, but multiple continuously maintained Skills injected when relevant.

V2:

> **Do not absorb more Skills into one monolith. Build a control plane of Canonical Context and Skill Federation that preserves goals, criteria, boundaries, and state; gives internal and external capabilities the right context; promotes results only through evidence and authority gates; and compiles canonical constraints downward into enforceable runtime policy.**

> **The more capable the Skill ecosystem becomes, the more valuable a control plane becomes that does not swallow those capabilities, but decides when they run, what they can see, what they can change, and what counts as real completion.**

---

## External references

- Pi SDK: https://pi.dev/docs/latest/sdk
- Pi Extensions: https://pi.dev/docs/latest/extensions
- Pi Skills: https://pi.dev/docs/latest/skills
- AI Hero `grill-with-docs`: https://www.aihero.dev/grill-with-docs
- AI Hero `grilling`: https://www.aihero.dev/skills-grilling
- AI Hero `to-spec`: https://www.aihero.dev/skills-to-spec
- AI Hero `to-tickets`: https://www.aihero.dev/skills-to-tickets

These systems are validation and compatibility examples, not mandatory dependencies.
