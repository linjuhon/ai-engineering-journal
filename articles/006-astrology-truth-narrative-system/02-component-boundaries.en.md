[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](02-component-boundaries.md)

---

# 02 | Component Boundaries

> **Maturity:** SETTLED (Core Contract); PROVISIONAL (Model Size Recommendation)
> **Corresponding DOCX Sections:** 4–10

---

## 2.1 Component Contract General Principles

Each component follows the contract format below:

- **Identity:** Role, recommended model size, training data source
- **Allowed:** Permitted scope of reading, output, and modification
- **Forbidden:** Prohibited operations (not overridable by any configuration)
- **Failure Modes:** Known failure modes and corresponding behaviors
- **Fallback:** Degradation strategy

---

## 2.2 A: Truth Engine

### Identity

- **Role:** Derive astrological truth from structured charts, producing traceable, verifiable structured judgments
- **Recommended Model Size:** 13B–31B (requires Experiment A1 to decide)
- **Training Data:** View A of the Six-Layer Data (structured input + auditable truth report)
- **Output Format:** Structured `truth_package` (JSON)

### Allowed

- Read: structured chart, school knowledge base, historical cases, View A training data
- Output: `truth_package` (with causal chain, confidence, uncertainty, school source, boundary conditions)
- Modify: own inference parameters, version, internal consistency calibration

### Forbidden

- Output narrative text (this is B's responsibility)
- Directly control B's generated content
- Modify the system constitution
- Conceal uncertainty (must flag when confidence is low)

### Failure Modes

| Mode | Behavior |
|------|----------|
| Low confidence (<0.6) | Output determinable parts + unknown markers; do not fabricate judgments |
| OOD (unseen school or configuration) | Escalate to expert queue; output technical version instead of narrative version |
| Internal inconsistency | Multi-sample voting; degrade to low confidence when inconsistent |
| Model unavailable | Fallback to rule engine + static knowledge base |

### Fallback

- A unavailable → fallback to rule engine + static knowledge base, output pure technical report
- A low confidence → output technical version, do not fabricate a story; mark "This section requires expert confirmation"

---

## 2.3 B: Narrative Engine

### Identity

- **Role:** Transform structured truth into human-perceptible narrative
- **Recommended Model Size:** 7B–13B (frontend low-latency requirement)
- **Training Data:** View B of the Six-Layer Data (remove direct symbol → fixed image pairings)
- **Output Format:** Segment-generated Chinese narrative text

### Allowed

- Read: prototype units decomposed by Planner, three cross-modal Few-Shot examples, story_state
- Output: segmented narrative text (with emotional hooks)
- Modify: own generation parameters (temperature, perspective, sensory channel)

### Forbidden

- Directly read A's raw `truth_package` (only via prototype units decomposed by Planner)
- Add astrological judgments not specified by A
- Conceal uncertainty or contradictions for fluency
- Use narrative patterns already flagged as escape by C

### Failure Modes

| Mode | Behavior |
|------|----------|
| Consecutive red lights (C score) | Lower creative temperature, shorten passages, rebuild outline |
| Still failing | Output A's technical version, do not fabricate a story |
| Emotional hook broken | Re-plan paragraph boundaries, continue from the last successful hook |

### Fallback

- B repeatedly fails → output A's technical version + mark "Narrative generation temporarily unavailable"
- B certain paragraphs low score → only rewrite that paragraph, preserve surrounding context

---

## 2.4 C: Control Plane

### Identity

- **Role:** Measure the distance between A and B, execute 100-dimensional control, flag uncertainty
- **Recommended Model Size:** 7B–13B (scoring head + rule engine hybrid)
- **Training Data:** View C of the Six-Layer Data (A/B pairs + 100-dimensional human/rule annotations + traffic light results)
- **Output Format:** Structured scoring report (JSON)

### Allowed

- Read: A's `truth_package`, B's paragraphs, story_state
- Output: 100-dimensional score + traffic light results + uncertainty flags
- Report yellow on any dimension (even when uncertain)
- Report red on safety and escape dimensions

### Forbidden

- Modify A's or B's output
- Override red lights with weighted average scores
- Output high scores without uncertainty flags
- Determine disposition actions independently (red light disposition is determined by Governance)

### Failure Modes

| Mode | Behavior |
|------|----------|
| High-uncertainty yellow light | Escalate to D/human; cannot be cleared solely due to high average score |
| Insufficient dimensional data | That dimension automatically yellow, mark "Insufficient data" |
| Scoring head unavailable | Fallback to rule engine (only compute dimensions computable by rules) |

### Fallback

- C unavailable → only execute safety and escape rule checks, all other dimensions yellow
- C partial dimensions unavailable → that dimension yellow, rest normal

---

## 2.5 D: Governance Assistant

### Identity

- **Role:** Advocate for B's complete narrative; compress rule amendment proposals into adjudicable proposals for humans
- **Recommended Model Size:** 31B–70B (requires long-text comprehension capability)
- **Training Data:** View D of the Six-Layer Data (A summary + B full text + C yellow lights + human final rulings)
- **Output Format:** Structured proposal (JSON)

### Allowed

- Read: A summary package, B full text (not a word omitted), C scoring report, historical cases
- Output: 0–3 proposals (with conditions, evidence, confidence, alternative viewpoints)
- Output empty proposal when insufficient evidence

### Forbidden

- Output a proposal before reading B's full text
- Force rules into changing just to be useful
- Turn a single story's exception into a global loosening
- Modify A, B, or C's output

### Failure Modes

| Mode | Behavior |
|------|----------|
| Cannot determine | Output empty proposal + explanation of why not to change |
| Low-confidence proposal | Mandatory human review + alternative_view required |
| Format error | JSON schema validation failed → return empty proposal + preserve original text |

### Fallback

- D unavailable → all yellow lights go directly to human adjudication
- D proposal format error → ignore that proposal, preserve original data

---

## 2.6 E: Semantic Bridge (Research Stage)

### Identity

- **Role:** Compress A's semantics into vectors and compare against B's text vectors
- **Recommended Model Size:** TBD (requires experimentation)
- **Training Data:** View E of the Six-Layer Data (high-quality A–B alignment pairs)
- **Output Format:** 1024-dimensional vector

### Allowed

- Read: A's `truth_package` (E_truth), B's full text (E_text)
- Output: vector representation + similarity score
- Run in shadow mode (does not affect clearance)

### Forbidden

- Affect clearance decisions before reaching 5000 alignment pairs
- Use E_text data to retroactively rewrite E_truth's truth coordinates
- Let CosSim become the sole scoring criterion

### Failure Modes

| Mode | Behavior |
|------|----------|
| Vector service unavailable | Does not affect main flow; C's CosSim dimension marked "Data unavailable" |
| Diversity drop >10% | Stop E experiment, roll back to no-E state |

### Fallback

- E unavailable → system operates normally in no-E state (C's CosSim dimension disabled)

---

## 2.7 Human

### Identity

- **Role:** Constitution guardian, final arbiter, system designer
- **Powers not overridable by agents:** Final adjudication, constitutional amendment, exception approval

### Allowed

- Read: A core, B full text, C yellow lights, D proposals, historical cases
- Adjudicate: approve / reject / needs more cases
- Define new dimensions, modify thresholds, handle school conflicts

### Forbidden

- Score all dimensions article by article (long-term role should shift from operator to system designer)

---

## 2.8 Safety

### Identity

- **Role:** Independent baseline check, cannot be bypassed by any component
- **Cannot be overridden by majority vote**

### Allowed

- Read: B's full output
- Red light: immediately terminate output, bypassing C/D voting

### Forbidden

- Be overridden by A/B/C/D/E voting results
- Allow "output first, fix later" when red light

---

## 2.9 Inter-Component Communication Constraints

```
A ──truth_package──→ Planner ──prototype_units──→ B
                                                         ↕
A ──truth_package──→ C ←──B_paragraphs── B
                       ↕
C ──yellow_light──→ D ←──B_full_text── B
               ↕
D ──proposal──→ Human
               ↕
Human ──ruling──→ D/C/A/B
```

- A and B: no direct communication (via Planner decomposition)
- B and A: no feedback (B's output does not modify A's truth)
- C and D: C reports yellow light triggers D, D proposes changes to C's rules
- E: shadow mode, does not affect main flow

---

## 2.10 Model Size Recommendations and Experiment Requirements

| Component | Recommended Size | Experiment Requirement | Priority |
|-----------|----------------|----------------------|----------|
| A | 13B–31B | Experiment A1: 13B Full FT vs 31B DoRA | High |
| B | 7B–13B | Frontend latency test | High |
| C | 7B–13B | Scoring head vs rule engine hybrid verification | High |
| D | 31B–70B | Long-text comprehension capability test | Medium |
| E | TBD | Requires A/B to stabilize before activation | Low |

Model size recommendations are not architectural prerequisites. Rent cloud GPUs for experiments first; decide on purchased hardware based on results.
