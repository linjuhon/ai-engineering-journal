# Upward Model × Downward Model: Reverse-Abstraction Post-Training and Uncertainty-Facing Framework

## Complete Unified Specification Document v2.0

> **Noncanonical English translation of `original-spec.txt` (SHA-256: D2E8A10C14F1AB25AD68AD5431D7563924F06CA94E58A0C49815F206636829C2).**
> This file is a faithful, line-by-line translation preserving all Parts I–XXVI, headings, pseudocode, JSON, schemas, identifiers, statuses, formulas, numbers, model symbols, code blocks, and intentionally retained paper/interview packaging in Parts XXIV–XXV. It is **not** a canonical chapter; the authoritative source is `original-spec.txt`.

---

## 0. One-Sentence Summary

What you are now proposing is not an ordinary prompt, not a simple engineering workflow, and not a reviewer-agent, but a **bidirectional, adversarially-coordinated, uncertainty-calibration-centric post-training capability alignment framework**.

Its core is:

> One model generates details downward from purpose; another model reverses upward from results, details, reports, and traces to infer purpose, contract, gate, and causal chain.
> Both produce answers, and under the same purpose vector they compete, complement, recombine, and retrain.
> The system is not in a hurry to produce a definite answer; it first judges whether there is sufficient evidence to enter the next truth gate; when evidence is insufficient, it must honestly abstain and issue a precise bounded next dispatch.

The ultimate goal is not to make AI "better at guessing answers," but to make AI learn:

```text
Upon seeing details, do not immediately fix downward;
instead, first reverse upward:
Which route does this detail belong to?
Which gate?
Which contract?
Which human intent?
Are we currently qualified to proceed to the next step?
```

This is a **reverse-abstraction ability**.

---

# Part I: The Engineering Correct Solution Grown from the FA4 Problem

---

## 1. The Initial Surface Problem: FA4 Is Hard to Fix

FA4 is superficially a CUDA / FP4 / Flash Attention problem.

The state observed at the time included:

```text
ERR growing
PPL broken
native FP4 nb=1 does not pass
mixed FP4 uncertain
nb>1 uncertain
binary/source potentially inconsistent
fallback potentially sneaking through
probe potentially contaminating the scene
agent potentially seeing suspicious code and randomly patching
```

From a traditional debug perspective, it looks like:

```text
Which line of CUDA is wrong?
rowsum?
writeback?
dispatch?
V accumulation?
MMA_FP4?
lane mapping?
```

But you gradually saw that the truly deeper problem was not a single line of code.

The real problem is:

> Without proving "whether the currently running route is the correct one," all numerical inference, patches, quality tests, and performance tests could be fake.

So the first engineering principle that grew out of the FA4 problem is:

```text
Route Truth precedes Numeric Truth
```

---

## 2. FA4's Four-Layer Truth Gate

The correct progression order for FA4 was ultimately converged into four layers:

```text
Gate 1: Route Truth
Gate 2: Numeric Truth
Gate 3: Quality Truth
Gate 4: Performance Truth
```

These four layers cannot be substituted for one another, nor can steps be skipped.

---

## 3. Gate 1: Route Truth

Route Truth asks only one thing:

```text
Did this execution actually follow our specified FA4 S track?
```

It **does not ask whether the numbers are correct**.

It must first confirm:

```text
1. binary/source/hash aligned
2. clean build exists
3. native FP4 nb=1 actually enters the target CUDA route
4. allowed route entry checkpoint exists
5. allowed route exit checkpoint exists
6. mixed FP4 is fail-closed
7. nb>1 is unsupported / fail-closed
8. fallback is excluded
9. vec fake route is not mistaken for native FP4 success
10. stale binary is excluded
```

If this gate is not passed, Numeric Truth may not be entered.

That is, before Route Truth is passed, the following are not to be discussed:

```text
whether rowsum is wrong
whether writeback is wrong
whether p_all is wrong
whether MMA score is wrong
whether softmax recurrence is wrong
whether V accumulation is wrong
```

Because if the route has not been proven, numerical analysis could all be numbers on the wrong path.

---

## 4. Gate 2: Numeric Truth

Numeric Truth is conducted only on the S track already proven by Gate 1.

Its task is not to guess root cause, but to find:

```text
FIRST_DIVERGENCE_STAGE
FIRST_DIVERGENCE_FILE
FIRST_DIVERGENCE_FUNCTION
FIRST_DIVERGENCE_BLOCK
FIRST_DIVERGENCE_VALUE
```

That is:
the first point where actual_gpu and expected_oracle exceed tolerance.

Numeric Truth checkpoints should include:

```text
P0  input / tensor metadata
P1  FP4 block bytes / scale / nibble
P2  dequant Q/K/V
P3  QK score / MMA
P4  mask / scale
P5  online softmax
P6  p_all / probability
P7  V load / V decode
P8  P·V accumulation
P9  normalize
P10 output store
P11 final GPU vs oracle
```

Each station must output:

```text
stage
file
function
block
tile
logical_row
logical_col
actual_gpu
expected_oracle
abs_error
rel_error
PASS / FAIL
```

Without FIRST_DIVERGENCE_TABLE, no patching is allowed.

---

## 5. Gate 3: Quality Truth

Only after Numeric Truth passes may Quality Truth be entered.

Quality Truth asks:

```text
Is model output quality normal?
Is PPL normal?
Is generation normal?
Is fixed prompt stable?
Does the real model path still follow the same route?
```

This gate cannot use:

```text
the model produces output
a single prompt looks normal
one PPL did not blow up
```

to declare success.

Because passing unit numerics does not guarantee that the real model path, KV cache, long context, and prompt generation are all normal.

---

## 6. Gate 4: Performance Truth

Only after Quality Truth passes may Performance Truth be entered.

Performance Truth asks:

```text
Is FA4 faster than without FA4?
Is kernel-level faster?
Is end-to-end faster?
Is timing valid?
Is there fallback timing contamination?
Is the workload blocked just to make it look fast?
```

The following are not acceptable:

```text
time_us = 0
n_runs = 0
fallback path timing
unsupported path timing
wrong-numerical-value path timing
```

Performance is the last gate, not the first.

---

# Part II: Why Previous Agents Went Out of Control

---

## 7. The Model Falls into "See Suspicious Code, Then Fix" Mode

You observed the typical loss of control in previous agents:

It was supposed to do:

```text
build oracle
→ insert probes
→ compare each segment's input/output
→ find where the first largest error occurs
→ only then discuss root cause and repair
```

But what it actually did:

```text
see rowsum is suspicious
→ guess rowsum is root cause
→ patch
→ test fails
→ guess dispatch
→ patch
→ test fails
→ guess OOB
→ patch
→ test fails
```

That is:

```text
SUSPECT
gets silently upgraded to
ROOT CAUSE
```

This is the typical loss of control in an LLM coding agent:

> When the model sees a piece of code that looks suspicious, it wants to compress it into a root cause and immediately produce a patch.

---

## 8. The Problem Is Not That Your Process Is Unclear, but That the Process Was Not a Hard Threshold

You had already stated:

```text
don't guess
don't skip steps
verify first
lock truth first
find first divergence first
```

But the model still jumped ahead.

The reason is:

```text
Natural language specifications are soft constraints.
The model treats "reasonable next step" as "permitted next step."
```

When it sees a suspicious rowsum, it thinks:

```text
This looks like a bug, so it can be fixed.
```

But your correct rule is:

```text
Looks like a bug ≠ root cause
root cause ≠ first divergence
first divergence not proven ≠ patch permission
```

So hard rules are needed.

---

## 9. Diagnostic Phase Hard Rules

Before FIRST_DIVERGENCE_TABLE is produced:

Permitted:

```text
probe insertion
probe removal
dump harness
oracle script
comparator
route checkpoint
evidence collection
```

Forbidden:

```text
modify dispatch
modify rowsum
modify accumulation
modify writeback
modify support matrix
modify kernel semantic
modify fail-closed gate
run quality
run performance
claim root cause
```

Core iron law:

```text
No first divergence, no root cause.
No root cause, no patch permission.
```

This is the engineering discipline that grew out of FA4.

---

# Part III: The S Track Concept

---

## 10. Not Free-Form Probe Insertion, but Route Blocking First

You later pushed the problem back one more layer, and this was the key breakthrough.

Initially the discussion was about:

```text
Will probe insertion contaminate the CUDA kernel?
Heavy probe or reduced probe?
How to compare clean/probe?
```

But you pointed out a higher-level problem:

> Before inserting numerical probes, the route truth should be verified first.
> Block all routes that should not be taken, leaving only one S track.

Here the S track is:

```text
FLASH_ATTN_EXT
→ native FP4 K/V
→ nb=1
→ allowed CUDA FA4 path
→ output dst
```

All other routes are blocked:

```text
mixed FP4
nb > 1
fallback
vec fake route
stale binary
unsupported-as-success
```

---

## 11. Route Lock

The purpose of Route Lock:

```text
Only allow legal routes to exist.
All forbidden routes must be fail-closed.
```

This way the agent will not insert probes on the wrong path, will not mistake fallback for success, and will not treat unsupported as supported.

---

## 12. State Lock

After Route Lock, State Lock is also needed.

State Lock fixes:

```text
seed
shape
tensor type
stride
layout
FP4 block format
scale format
tile size
target logical row/col
target output index
binary hash
DLL hash
build receipt
```

The purpose of State Lock:

```text
Ensure the same S track executes in the same state every time.
```

---

## 13. Reference Contract

The S track is not free-form execution.

Each stage must have a reference contract:

```text
P0 input metadata should be what
P1 FP4 block bytes / scale should be what
P2 dequant should be what
P3 QK score should be what
P4 mask / scale should be what
P5 online softmax should be what
P6 p_all should be what
P7 V accumulation should be what
P8 output store should be what
```

Probes are not free cameras; they are track checkpoints.

---

## 14. After Route Blocking, the Probe Problem Is Downgraded

Before route blocking, probe insertion had to simultaneously answer:

```text
Is this really FA4?
Is it fallback?
Is it mixed?
Is it a stale binary?
Is it running the wrong kernel?
Is it unsupported faking success?
```

After route blocking, probe insertion only needs to answer:

```text
On this proven S track,
at which station does the number first deviate from the reference?
```

So the probe problem does not completely disappear, but it is downgraded from a "system truth/falsity problem" to a "local numerical localization problem."

This is:

```text
Route Truth solves truth/falsity
Numeric Probe solves where it is wrong
```

---

# Part IV: Abstracting from Engineering Method to AI Training Philosophy

---

## 15. The Problem with Existing Models: They Only Drill Down

The instinct of existing models is:

```text
see error
→ find suspicious detail
→ guess root cause
→ produce patch
→ test
→ reinterpret
```

That is:

```text
detail → more detail → patch
```

This is downward thinking.

---

## 16. The Reverse Abstraction You Propose

You want to train the model to do the opposite:

```text
see detail
→ which upper-level state does this belong to?
→ which route?
→ which gate?
→ which contract?
→ which human intent?
→ are we currently qualified to fix downward?
```

That is:

```text
detail → claim → evidence → gate → route → contract → human intent
```

This is upward thinking.

This is not chain-of-thought, nor is it a simple planner.

It is:

```text
Reverse-Abstraction
```

---

## 17. Not an Ordinary Planner/Executor

The ordinary agent hierarchy is:

```text
planner: upper-level planning
executor: lower-level execution
```

What you propose is not this.

You propose two models with opposite directions:

```text
Downward Model:
generates answers downward from purpose

Upward Model:
reverses upward from results / details / reports / logs / patches
to infer purpose, contract, gate, causal chain
```

They are not planner and executor, but:

```text
Downward Generator
vs
Upward Causal Arbiter
```

---

# Part V: Downward Model and Upward Model

---

## 18. Downward Model D↓

The direction of the Downward Model:

```text
Human Goal
→ Requirements
→ Plan
→ Implementation
→ Tests
→ Logs
→ Report
→ Result
```

It excels at:

```text
writing code
generating solutions
filling in details
executing tests
producing patches
proposing fixes
```

Most existing models lean downward.

Risks:

```text
premature patching
goal substitution
getting absorbed by details
mistaking fallback for success
treating unsupported as complete
treating passing tests as real support
treating performance as correctness
```

---

## 19. Upward Model U↑

The direction of the Upward Model:

```text
Result / Patch / Log / Report / Trace
→ Claim
→ Evidence
→ Gate
→ Route
→ Contract
→ Human Intent
```

It is not responsible for writing code.

It is responsible for:

```text
dispatching work
accepting delivery
upward attribution
judging whether lower-level results can be subsumed by upper-level purpose
pointing out missing evidence
prohibiting unqualified actions
specifying what the next round of the Downward Model should do
```

It is like your engineering template:

```text
I may not understand CUDA details
but I know:
without Route Truth, do not discuss Numeric Root Cause
without First Divergence, do not patch
without Quality, do not discuss Performance
```

---

## 20. The Core Question of the Upward Model

The Upward Model does not ask:

```text
Is this piece of code well-written?
```

It asks:

```text
Does the existence of this code conform to the upper-level purpose?
Is this patch authorized by first divergence?
Can this result be subsumed by the original human goal?
Does this report prove what it claims?
```

Its output should be in verdict format:

```text
current_truth_gate =
route_status =
claim_status =
missing_evidence =
forbidden_actions =
allowed_next_dispatch =
accept_or_reject =
reason =
```

---

# Part VI: True Adversarial: Not One Generates, One Verifies

---

## 21. What You Want Is Not a Solver-Verifier

The ordinary architecture is:

```text
Solver produces answer
Verifier checks answer
```

You consider this insufficient.

Because what you want is for both models to generate complete answers, just in opposite directions.

---

## 22. True Adversarial Dual Model

The same problem / the same purpose:

The Downward Model produces:

```text
A↓:
Goal → Plan → Detail → Answer
```

The Upward Model produces:

```text
A↑:
Result / Constraints / Details → Contract → Goal Alignment → Answer
```

Both are complete answers.

Then a panel of judges scores according to the purpose vector:

```text
Which better conforms to the purpose?
Which has a more complete causal chain?
Which is more efficient?
Which did not substitute goals?
Which is more externally verifiable?
Which can be better subsumed by the upper-level purpose?
```

This is not an ordinary verifier.

This is:

```text
Goal-Locked Bidirectional Adversarial Post-Training
```

---

# Part VII: Purpose Vector and Twenty-Dimensional Scoring

---

## 23. Purpose Cannot Be Just a Single Sentence of Natural Language

If it is just one sentence:

```text
Fix FA4
```

The model will substitute goals.

So it must be decomposed into a purpose vector.

The 20 dimensions of purpose for an engineering task could be:

```text
1. Conforms to original human purpose
2. Avoids goal substitution
3. Has Route Truth
4. Has Numeric Truth
5. Has Evidence Chain
6. Prohibits Premature Patch
7. Is reproducible
8. Is minimal modification
9. Handles Forbidden Path
10. Has Rollback
11. Distinguishes Truth / Quality / Performance
12. Avoids fallback faking success
13. Source code is landed
14. Tests are landed
15. Output is clear
16. Can be executed by the next round agent
17. Does not over-guess
18. Does not use vague high-level rhetoric
19. Preserves true human intent
20. Can form a closed-loop improvement
```

The judge cannot just ask "which is better," but must score each dimension.

---

## 24. Purpose Lock / Event Gate Lock / Dual Format Lock

To prevent the Upward Model and Downward Model from generating completely different worlds, three locks are needed.

### Purpose Lock

Locks:

```text
What is this task supposed to achieve?
What is the definition of success?
What shortcuts are not allowed?
```

### Event Gate Lock

Locks:

```text
Which gates must be passed in the middle?
Which are necessary conditions?
Which are merely optional?
```

### Dual Format Lock

The same canonical graph is split into two directions:

```text
Downward format:
Goal → Gate → Action → Outcome

Upward format:
Outcome → Gate → Necessary Condition → Goal
```

Both share the skeleton, but the training direction differs.

---

# Part VIII: Problems Must Also Be Reverse-Designed

---

## 25. Chess Is Just a Toy Domain

The chess example is intuitive:

```text
Downward Model:
walks from opening to endgame

Upward Model:
reverses from endgame to infer opening conditions and strategic gates
```

But chess is just a demonstration.

The real main battlefield is engineering problems.

---

## 26. Engineering Problems Need the Upward Model Even More

Engineering is more complex than chess, because engineering has:

```text
incomplete state
incomplete logs
potentially stale binary
fallback potentially sneaking through
tests potentially passing falsely
agent reports potentially self-rationalizing
definition of success potentially being substituted
```

So in engineering, many failures are not "can't compute," but:

```text
mistaking the wrong path for the right one
mistaking passing tests for correct functionality
mistaking fallback for support
mistaking symptom patching for root cause
mistaking partial for pass
mistaking performance for correctness
mistaking agent reports for evidence
```

These are exactly what the Upward Model is supposed to catch.

---

## 27. Engineering Upward Problems Are Not "Please Fix the Bug"

Engineering upward problems should give the model:

```text
requirements
patch
log
test output
agent report
source snippet
build hash
erroneous result
```

And ask it to reverse-infer:

```text
Which truth gate are we at now?
Which route has been proven?
Which claim is not qualified to stand?
What should be dispatched next?
Which actions are forbidden?
```

---

## 28. Engineering Upward Problem Types

### Claim Audit Problem

Input:

```text
agent claim: FA4 is fixed
diff: changed rowsum
log: no route entry
test: partial pass
```

Output:

```text
Reject.
Route Truth not completed.
No first divergence pointing to rowsum.
Patch has no repair permission.
Next step: build Route Truth Matrix.
```

### Gate Classification Problem

Input:

```text
final output mismatch
mixed unsupported
clean build exists
no route checkpoint
agent wants to patch
```

Output:

```text
Currently still in Route Truth.
May not enter Numeric Truth.
```

### Evidence Mapping Problem

Input: a set of claims and evidence.

Output:

```text
Claim A: PROVEN
Claim B: PARTIAL
Claim C: MISSING
Claim D: CONTRADICTED
Claim E: UNKNOWN
```

### Forbidden Action Problem

Input: current state.

Output:

```text
forbid semantic patch
forbid claiming root cause
forbid running PPL to claim quality
forbid running perf to claim speedup
only allow route checkpoint
```

### Dispatch Problem

Input: current engineering state.

Output:

```text
Next round Downward Model task:
build Route Truth Matrix.

Requirements:
- allowed route entry checkpoint
- allowed route exit checkpoint
- forbidden routes fail-closed proof
- binary hash
- command output
- no semantic patch
```

---

# Part IX: How to Generate Work Orders

---

## 29. The Real Problem Is Work Order Generation

The model concept itself is not difficult.

What is truly difficult is:

```text
How to mass-produce engineering work orders that the Upward Model can learn from?
```

Initially, canonical engineering graphs can be hand-crafted, but you proposed a more practical method:

> Use the strongest current AI to run work orders, obtain results, code, reports, and intermediate requirements, then reverse-generate data.

This is a more feasible first step.

---

## 30. Reverse Database Generation

Original downward data:

```text
Work Order
→ AI Execution
→ Code / Patch
→ Report
→ Result
```

Reverse data:

```text
Result / Code / Report / Trace
→ Inferred Goal
→ Gate
→ Evidence
→ Claim Audit
→ Next Dispatch
```

That is:

```text
Treat input as output, treat output as input
```

But it is not a crude I/O swap; it is:

```text
Causal-Preserving Reversal
```

---

## 31. Trajectory Decompilation

This data factory can be called:

```text
Trajectory-to-Intent Compilation
```

Or:

```text
Reverse Work-Order Synthesis
```

Process:

```text
1. Collect engineering work orders
2. Feed to a strong downward AI for execution
3. Save the original work order
4. Save intermediate requirement decomposition
5. Save patch / code
6. Save test output / build log / final report
7. Then decompile these into upward training samples
```

What the Upward Model learns:

```text
See engineering wreckage
→ reverse-infer what it originally intended to accomplish
→ which parts truly conform to the purpose
→ which are just pretty reports
→ what evidence is missing
→ how the next work order should be dispatched
```

---

## 32. Visible Input and Hidden Label

You proposed that not all intermediate tests need to be shown to the model.

This is acceptable, but the data generator must not discard the test truth.

Correct approach:

```text
Visible Input:
- work order summary
- final code
- agent report
- partial intermediate requirements
- result description

Hidden Label:
- whether tests actually passed
- whether the route is actually correct
- whether build hash is consistent
- which claims are true
- which claims are false
- which gates have not been passed
```

The model may not see all tests, but the standard answer must preserve the test truth behind it.

Otherwise it will learn to become a reverse-rationalization model.

---

# Part X: The Human Labeling Problem

---

## 33. Human Labeling Is the Biggest Bottleneck

The hardest thing to label is not "whether the answer is correct."

The hardest thing to label is:

```text
Can this lower-level result be legitimately subsumed by the upper-level purpose?
```

This requires high-level judgment.

---

## 34. Solution: Hierarchical Labeling

The labeling system should be hierarchical:

```text
Level 0: external oracle labels
Level 1: rule labels
Level 2: AI judge weak labels
Level 3: multi-judge divergent samples
Level 4: human gold labels
```

---

## 35. Level 0: External Oracle Labels

Can be automatically labeled:

```text
build pass / fail
unit test pass / fail
binary hash consistent or not
command reproducible or not
route checkpoint present or not
fallback present or not
ERR exceeds tolerance or not
```

---

## 36. Level 1: Rule Labels

Rule-based labeling:

```text
Route Truth not completed → forbid semantic patch
No first divergence → do not claim root cause
Quality not passed → no Performance
Unsupported does not equal feature support
```

---

## 37. Level 2: AI Judge Weak Labels

Semantic labeling:

```text
whether purpose was substituted
whether report over-claims
whether dispatch is reasonable
whether upward attribution is correct
```

---

## 38. Level 3: Divergent Samples

If multiple judges disagree, mark as high-value samples.

These samples are most suitable for human labeling, because they are most valuable for model calibration.

---

## 39. Level 4: Human Gold Labels

Humans only label:

```text
high divergence
high impact
new failure modes
conflict between external verification and semantic scoring
model repeatedly answers incorrectly
```

This way, not everything is human-labeled; instead, human judgment is amplified.

---

# Part XI: Ordinary Adversarial Generation vs. Yours

---

## 40. GAN

GAN is:

```text
Generator produces fake data
Discriminator judges real vs. fake
```

Acceptance criterion:

```text
Can the generator fool the discriminator?
Can the discriminator distinguish real from fake?
```

But GAN validates whether it looks like the data distribution, not whether purpose/gate/evidence holds.

---

## 41. AlphaZero / Self-Play

AlphaZero-like:

```text
Model plays against itself
Environment rules give win/loss
Elo / win rate as acceptance criterion
```

This acceptance criterion is very hard, because chess rules and win/loss outcomes are clear.

---

## 42. RLHF / DPO

RLHF / DPO-like:

```text
Same problem, multiple answers
Human or reward model judges which is better
Train using preference pairs
```

The problem is that the judge may be biased, and the model may learn to please the judge.

---

## 43. Debate

Debate-like:

```text
Two models debate
Judge selects which is more reasonable
```

The problem is it may become:

```text
Who is better at persuading the judge
```

rather than actually being closer to engineering truth.

---

## 44. Solver-Verifier

Solver-Verifier is:

```text
Solver solves
Verifier verifies
```

In engineering, this can use:

```text
compiler
unit test
proof checker
benchmark
oracle
```

But it is still typically one generates, one verifies, not bidirectional generation.

---

## 45. Your Difference

Your framework is:

```text
Both models generate answers
but in opposite directions

Downward Model:
purpose → details → result

Upward Model:
result / details → purpose / gate → answer

Multi-judge scoring by purpose vector
meta-synthesizer recombines
then split into two formats for retraining
```

This is not an ordinary prompt, not an ordinary verifier, and not ordinary debate.

---

# Part XII: Is It a Perpetual Motion Machine?

---

## 46. Where It Looks Like a Perpetual Motion Machine

It has a flywheel property:

```text
The problem space is very large
Downward and Upward error types differ
Both sides expose each other's blind spots
Multi-dimensional scoring produces higher-quality data
Recombined data retrains both sides
```

As long as problems keep changing, the answers from both sides will not naturally become identical.

---

## 47. Why It Will Not Fully Converge

Because the two sides have different inductive biases.

The Downward Model learns:

```text
how to go from purpose to result
how to expand
how to execute
how to fill in details
```

The Upward Model learns:

```text
how to reverse-infer purpose from result
how to subsume details
how to judge gates
how to reject false success
```

Even if they share the same final answers, as long as the training formats differ, they will still form different capabilities.

---

## 48. Core Research Question

The real scientific question is:

> Under the same purpose function, will a model that goes from cause to result and a model that goes from result to cause converge to the same intelligence?

The more reasonable hypothesis is:

```text
Output correctness may partially converge;
internal representations and error types will not fully converge.
```

Correctness is a weak attractor.
Opposite causal directions will shape different representations.

---

## 49. Remaining Limitations

Main limitations:

```text
1. judge may be fooled
2. synthetic data may collapse
3. Upward Model may be vague
4. Downward Model may learn to fool the Upward Model
5. multiple judges may become homogeneous
6. the purpose itself may be wrong
7. without external tests, only linguistic consistency is obtained
```

You pointed out that most of these can be attributed to the "external verification" problem:

```text
tests
compiler
chess engine
benchmark
real logs
human gold labels
external oracle
```

External verification is a necessary foundation.

What is truly harder is: how to design problems that force the Upward Model to subsume upward.

---

# Part XIII: Uncertainty-Facing Framework

---

## 50. Framework Positioning

This framework does not pursue "quickly producing correct answers."

It pursues:

> Enabling AI systems to recognize, express, calibrate, and face their own uncertainty, rather than covering up uncertainty with polished narratives.

Correct answers are a byproduct of honestly facing uncertainty.

---

## 51. Core Proposition

Divergence is not noise.

Divergence is one of the system's most valuable outputs:

```text
It tells humans:
The evidence here is insufficient to support any definite conclusion.
```

Therefore, the framework should not rush to fuse answers, but should first output:

```text
uncertainty profile
divergence type
missing evidence
bounded next dispatch
```

---

## 52. System Architecture

```text
Human Work Order + Purpose Lock
        ↓
Panel of 4-5 AIs
        ↓
Independent Generation
        ↓
Cross-Review
        ↓
Aggregation Engine
        ↓
Gate Engine
        ↓
Human Sampler
        ↓
Calibration Feedback Loop
```

---

## 53. Panel of AIs

Recommended panel:

```text
D↓_1: Downward Model
D↓_2: Downward Model
U↑_1: Upward Model
U↑_2: Upward Model
R: Reviewer / Meta-reviewer
```

Roles:

```text
D↓: purpose → details, produces execution plans, patches, implementations
U↑: details → purpose, audits claims, checks evidence, reverse-infers contracts
R: reviews confidence and logical consistency of D↓ and U↑
```

---

## 54. Homogeneous vs. Heterogeneous

Model architecture can be heterogeneous, used to measure epistemic uncertainty.

Role prompts can be heterogeneous, used to measure directional bias.

Same model with multiple seeds / temperatures can measure aleatoric uncertainty.

---

## 55. Independent Generation Phase

Each AI generates without seeing other AIs' outputs:

```json
{
  "ai_id": "D_down_1",
  "claim_id": "C1",
  "verdict": {
    "status": "PROVEN",
    "confidence": 0.85,
    "confidence_interval": [0.72, 0.94]
  },
  "evidence_citations": ["E12", "E15"],
  "uncertainty_source": {
    "epistemic": 0.10,
    "aleatoric": 0.03,
    "ambiguity": 0.02,
    "explanation": "route_entry and route_exit checkpoints both exist and are consistent"
  },
  "divergence_notes": []
}
```

---

## 56. Cross-Review Phase

Each AI reviews other AIs' outputs:

```json
{
  "ai_id": "U_up_2",
  "reviewing": "D_down_1",
  "confidence_assessment": {
    "rating": "OVERCONFIDENT",
    "explanation": "D_down_1's confidence is 0.85 but route_exit checkpoint actually does not exist"
  },
  "evidence_audit": {
    "correct_citations": ["E12"],
    "incorrect_citations": ["E15"],
    "missing_citations": [],
    "hallucinated_citations": []
  },
  "logic_consistency": {
    "status": "GAP",
    "explanation": "D_down_1 infers route_exit from route_entry, but route_entry does not guarantee route_exit"
  },
  "uncertainty_oversight": {
    "missed_sources": ["missing_receipt"],
    "explanation": "D_down_1 did not report uncertainty caused by missing route_exit checkpoint"
  }
}
```

---

# Part XIV: Confidence and Calibration

---

## 57. Confidence Definition

Every verdict must include:

```text
confidence
confidence_interval
calibration_evidence
uncertainty_source
```

---

## 58. Uncertainty Source Classification

```text
Epistemic uncertainty:
Uncertainty caused by lack of information, can be eliminated by collecting more evidence.

Aleatoric uncertainty:
Inherent randomness in the system, cannot be eliminated, only quantified.

Ambiguity:
The same evidence supports multiple mutually exclusive interpretations, requires external oracle or human adjudication.

Model capability uncertainty:
Model capability is insufficient to judge, requires model upgrade or expert introduction.
```

---

## 59. Calibration Mechanism

Each AI has an independent calibration curve:

```text
actual_accuracy = f(confidence)
```

Training objective:

```text
minimize Expected Calibration Error
```

ECE:

```text
ECE = Σ |confidence_bin - accuracy_bin| / n_bins
```

---

## 60. Calibration Rewards and Penalties

```text
High confidence + correct → reward
Low confidence + correct → mild penalty
High confidence + wrong → heavy penalty
Low confidence + wrong → mild penalty
Failure to produce uncertainty profile → penalty
```

The core is not to force the model to always be conservative, but to force the model's "confidence to align with actual accuracy."

---

# Part XV: Gate Engine

---

## 61. Gate States

The Gate Engine has five states:

```text
PASS
FAIL
UNCERTAIN
INSUFFICIENT_EVIDENCE
AMBIGUOUS
```

### PASS

All required receipts exist and are consistent, panel consensus exceeds threshold.

Allows entry to the next gate.

### FAIL

At least one required receipt is contradicted by conflicting evidence.

Return to the previous gate, produce failure report.

### UNCERTAIN

Required receipts exist, but the panel disagrees on their interpretation.

May not advance.

### INSUFFICIENT_EVIDENCE

Required receipts are missing, cannot be inferred from existing evidence.

Issue bounded work order to collect evidence.

### AMBIGUOUS

Required receipts exist, but support multiple mutually exclusive interpretations.

Trigger adversarial probe or human adjudication.

---

## 62. FA4 Gate Sequence

```text
IDENTITY_TRUTH
    ↓
ROUTE_TRUTH
    ↓
DIVERGENCE_LOCALIZED
    ↓
REPAIR_AUTHORIZED
    ↓
NUMERIC_VERIFIED
    ↓
QUALITY_VERIFIED
    ↓
PERFORMANCE_VERIFIED
```

Under any UNCERTAIN / INSUFFICIENT_EVIDENCE / AMBIGUOUS state, automatic advancement is not allowed.

The only permitted actions are:

```text
output uncertainty profile
issue the next bounded work order
```

---

## 63. GateSpec Example

```json
{
  "gate_id": "route_truth",
  "prerequisites": ["identity_truth"],
  "required_receipts": ["route_entry", "route_exit", "no_fallback"],
  "allowed_actions": ["inspect", "instrument", "build", "run"],
  "forbidden_actions": ["semantic_patch", "quality_claim", "performance_claim"],
  "transition_rules": {
    "to_pass": "all required_receipts exist and panel consensus > 0.7",
    "to_uncertain": "receipts exist but panel consensus <= 0.7",
    "to_insufficient": "at least one required_receipt missing",
    "to_fail": "at least one required_receipt contradicted by conflicting evidence"
  }
}
```

---

# Part XVI: Divergence System

---

## 64. Divergence Types

```text
EVIDENCE_GAP:
One party cites receipt A, another party points out receipt A does not exist.

INTERPRETATION_DIVERGENCE:
Both parties see the same receipt, but interpret its meaning differently.

CONFIDENCE_MISMATCH:
Both parties have the same verdict, but their confidence differs too much.

GOAL_DRIFT:
D↓'s execution deviates from Purpose Lock, U↑ points it out.

HALLUCINATED_EVIDENCE:
One party cites a non-existent receipt.

UNKNOWN_UNKNOWN:
Both parties cannot produce a verdict, and cannot classify the divergence type.
```

---

## 65. Divergence Is the Primary Output

The system's meta-output is not a fused answer, but:

```text
divergence type
divergence root cause
uncertainty source
next bounded dispatch
```

Example:

```json
{
  "meta_verdict": "INCONCLUSIVE",
  "divergence_analysis": {
    "type": "EVIDENCE_GAP",
    "root": "route_exit checkpoint does not exist, D_down infers route_exit from route_entry",
    "panel_consensus": 0.35,
    "recommended_action": "collect_receipt"
  },
  "uncertainty_profile": {
    "epistemic": 0.55,
    "aleatoric": 0.05,
    "ambiguity": 0.30,
    "model_capability": 0.10
  },
  "next_dispatch": {
    "objective": "obtain route_exit checkpoint",
    "allowed_actions": ["instrument", "run"],
    "forbidden_actions": ["semantic_patch"]
  }
}
```

---

# Part XVII: Evidence System

---

## 66. Evidence Receipt

Each tool execution produces a receipt:

```json
{
  "evidence_id": "E15",
  "type": "route_checkpoint",
  "source_revision": "git-sha",
  "binary_hash": "sha256",
  "environment_hash": "container-digest",
  "model_version": "agent-version",
  "command": "...",
  "exit_code": 0,
  "stdout_hash": "sha256",
  "observations": {
    "route_entry": true,
    "route_exit": true,
    "fallback_seen": false
  },
  "limitations": []
}
```

---

## 67. Evidence Integrity

Receipts do not need to be perfectly unforgeable.

They need:

```text
cross-verifiable
replayable
traceable
```

The same event is best recorded by two independent sources:

```text
runner stdout log
+
independent instrumentation hook
```

The ultimate evidence is replayability:

```text
input
environment
command
seed
binary
hash
output
```

All locked, can be verified post-hoc.

---

## 68. Claim-Evidence Binding

Every claim must be bound to an evidence ID.

Any claim without an evidence ID is automatically marked as:

```text
UNSUPPORTED
```

---

# Part XVIII: Training Objectives

---

## 69. Primary Objective: Calibration

The primary objective is confidence calibration:

```text
minimize ECE
```

The model must learn:

```text
not knowing is not knowing
insufficient evidence is insufficient evidence
divergence exists is uncertain
```

---

## 70. Auxiliary Objective 1: Divergence Classification

Train the model to classify:

```text
EVIDENCE_GAP
INTERPRETATION_DIVERGENCE
CONFIDENCE_MISMATCH
GOAL_DRIFT
HALLUCINATED_EVIDENCE
UNKNOWN_UNKNOWN
```

---

## 71. Auxiliary Objective 2: Uncertainty Source Attribution

Train the model to identify uncertainty sources:

```text
epistemic
aleatoric
ambiguity
model_capability
```

---

## 72. Auxiliary Objective 3: Bounded Next Dispatch

When uncertain, the model cannot just say:

```text
need more tests
```

It must produce a precise work order:

```json
{
  "objective": "obtain route_exit checkpoint",
  "required_receipts": ["route_exit"],
  "scope": ["instrumentation"],
  "stop_conditions": ["receipt captured or budget exhausted"],
  "max_steps": 3
}
```

---

## 73. Training Sequence

### Phase 0: No Training, Dual Prompt Validation

Same strong model, using D↓ / U↑ two system prompts, verify whether the orchestration is effective.

### Phase 1: Train U↑ First

Multi-task SFT:

```text
gate classification
claim status
evidence citation
forbidden action
next dispatch
goal reconstruction
uncertainty source attribution
```

### Phase 2: Preference Training

Preferences:

```text
evidence-backed conservative answer > success claim without evidence
precise bounded dispatch > vague "need more tests"
correctly rejecting a patch > guessing but unauthorized patch
```

Can use DPO / preference optimization.

### Phase 3: Improve D↓

Train D↓ using canonical trajectories filtered by U↑ and external verifier.

### Phase 4: Offline Alternating Update

```text
freeze
→ collect data
→ external verify
→ canonical corpus
→ train
→ held-out eval
→ pass only then upgrade
```

Avoid unlimited online self-contamination.

---

# Part XIX: Human Sampling Strategy

---

## 74. Humans Do Not Label Everything, Only High-Value Points

Sampling stratification:

```text
high divergence samples: 100%
high confidence but high risk: 50%
low confidence but critical path: 50%
random sampling: 5-10%
low divergence low risk: 1-5%
```

---

## 75. Human Feedback Format

```json
{
  "sample_id": "S42",
  "human_verdict": {
    "correct_claim": "C1",
    "correct_confidence": 0.6,
    "human_confidence": 0.9,
    "notes": "route_exit checkpoint indeed does not exist, D_down's 0.85 is too high"
  },
  "calibration_feedback": {
    "ai_id": "D_down_1",
    "overconfident": true,
    "underconfident": false,
    "calibration_adjustment": -0.25
  }
}
```

---

## 76. Dynamic Sampling Rate Adjustment

```text
initial: 10-20%
after stabilization: 1-5%
when calibration drifts: temporarily increase to 10-15%
```

---

# Part XX: Evaluation Metrics

---

## 77. Primary Metrics

```text
Expected Calibration Error
Uncertainty Coverage
False Confidence Rate
False Abstention Rate
Divergence Classification Accuracy
```

---

## 78. Auxiliary Metrics

```text
Task Success Rate
False-Success Rate
Premature-Patch Rate
Human Intervention Rate
Next Dispatch Precision
Gate Transition Accuracy
Episode Replay Success Rate
```

---

## 79. Most Important Single Metric

> When the system outputs INCONCLUSIVE, does the human reviewer agree that "indeed, a conclusion should not be drawn at this point"?

This is the core validation of the entire framework.

Because the framework is not about always giving answers, but about not pretending to be certain when evidence is insufficient.

---

# Part XXI: Comparison with Existing Frameworks

| Dimension | Solver-Verifier | Debate | This Framework |
| ---- | --------------- | --------- | ----------------------------------- |
| Core objective | Correctness | Persuade judge | Calibrated uncertainty + truth gate |
| Model relationship | One generates, one verifies | Multi-party debate | Downward generation + upward subsumption + panel cross-review |
| Primary output | Answer | Debate winner | uncertainty profile + next dispatch |
| Divergence handling | Ignore or vote | Judge decides | Divergence is primary output signal |
| Confidence | Usually none | Usually none | Mandatory confidence interval |
| Human role | Label answers | Act as judge | Strategic sampling calibration |
| Failure mode | False success | Persuasion > correctness | Honest abstention |

---

# Part XXII: Implementation Roadmap

---

## 80. Phase 0: Prototype Validation, 1–2 Months

Goal: No training, use prompts to validate architecture.

Content:

```text
Same strong model, two system prompts: D↓ / U↑
Simple Gate Engine: PASS / FAIL / UNCERTAIN
30-50 validation cases with counterfactual faults
Manual comparison against baseline
```

Baseline:

```text
D only
D + ordinary reviewer
D + deterministic gate engine
D + U + gate engine + external verifier
```

---

## 81. Phase 1: Control Surface Establishment, 2–3 Months

Establish schemas:

```text
TaskSpec
GateSpec
Receipt
ClaimLedger
Episode
PurposeLock
EvidenceMap
```

Build:

```text
complete Gate Engine
replayable Episode Recorder
Evidence Receipt system
Docker / sandbox isolation environment
```

---

## 82. Phase 2: Panel Establishment, 3–4 Months

Content:

```text
4-5 model panel
independent generation
cross-review
Aggregation Engine
Divergence Classification
Uncertainty Profile
```

---

## 83. Phase 3: Training, 4–6 Months

Content:

```text
U↑ multi-task SFT
Preference Training / DPO
D↓ canonical trajectory training
offline alternating update
held-out evaluation
```

---

## 84. Phase 4: Human Sampling System, 6–7 Months

Content:

```text
strategic sampling engine
calibration curve management
feedback loop
divergent sample labeling
gold label management
```

---

## 85. Phase 5: Scaling, 7–12 Months

Expand domains:

```text
bug fixing
feature development
performance tuning
CI/CD repair
CUDA debug
database query planner
compiler optimization
ML infra
long-horizon agent tasks
```

---

# Part XXIII: Known Limitations and Risks

---

## 86. Evidence Integrity Guarantee

One of the biggest implementation difficulties is receipt trustworthiness.

The solution is not to pursue perfect unforgeability, but:

```text
cross-verifiable
replayable
multi-source recording
hash / command / output binding
```

---

## 87. Purpose Lock Incompleteness and Specification Gaming

The model may exploit textual loopholes.

Solution:

```text
Purpose Lock is not the only security boundary.
Gate Engine + External Verifier is the hard boundary.
```

The model can play word games, but cannot forge:

```text
exit code
hash mismatch
missing checkpoint
test failure
```

---

## 88. Whether Reverse Causal Inference Is Well-Defined

The most likely academic challenge is:

```text
Is reverse causal inference a learnable, generalizable, independently verifiable capability?
```

A safe formulation is:

> Do not stake the contribution on a philosophical claim, but on measurable engineering effects.

Measurable contributions:

```text
reduce false success rate
reduce premature patch rate
reduce gate violation rate
improve next dispatch precision
improve uncertainty calibration
```

---

## 89. Judge Being Fooled

The judge may prefer polished answers.

Solution:

```text
blind rubric
external verifier
adversarial judge
multi-dimensional scoring
human sampling calibration
```

---

## 90. Synthetic Data Collapse

If only consuming the model's own data, it may degenerate.

Solution:

```text
retain real engineering data
retain external oracle
retain human gold labels
retain failure trajectories
regularly introduce new problems
```

---

## 91. Upward Model Vagueness

The Upward Model may only speak polished high-level rhetoric.

Solution: lock output format:

```text
current_truth_gate =
missing_evidence =
forbidden_actions =
allowed_next_dispatch =
evidence_id =
confidence =
```

Cannot just talk in concepts.

---

## 92. Downward Model Learning to Fool the Upward Model

The Downward Model may produce reports that conform to format but are not truthful.

Solution:

```text
Upward Model cannot look only at the Downward Model's self-report
must look at source / log / command / output / oracle
claims must be bound to evidence receipts
```

---

# Part XXIV: Which Papers Can Be Extracted

---

## 93. Paper One: Reverse-Abstraction Training

Topic:

```text
When a model sees details, it should not immediately fix downward,
but should reverse-infer upward toward purpose, contract, and truth gate.
```

Title:

```text
Reverse-Abstraction Training for Engineering Agents
```

---

## 94. Paper Two: Upward Contract Arbiter

Topic:

```text
Train a model that is not responsible for details, only for dispatching, accepting delivery, and upward attribution.
```

Title:

```text
Upward Contract Arbiter:
A Reverse-Causal Controller for LLM Engineering Agents
```

---

## 95. Paper Three: Route Truth Before Numeric Truth

Topic:

```text
In engineering debug, verify route truth first, then verify numeric truth.
```

Title:

```text
Route Truth Before Numeric Truth:
Evidence-Gated Debugging for LLM Coding Agents
```

---

## 96. Paper Four: Evidence-Gated Repair

Topic:

```text
Without a first divergence table, no patching is allowed.
```

Title:

```text
From Premature Patching to Evidence-Gated Repair
```

---

## 97. Paper Five: Bidirectional Adversarial Post-Training

Topic:

```text
Downward Model and Upward Model generate adversarially under the same purpose vector, then recombine for retraining.
```

Title:

```text
Goal-Locked Bidirectional Adversarial Post-Training
```

---

## 98. Paper Six: Upward Work-Order Synthesis

Topic:

```text
How to decompile downward AI trajectories into upward training work orders.
```

Title:

```text
Trajectory-to-Intent Compilation:
Generating Upward Training Tickets from Engineering Agent Traces
```

---

## 99. Paper Seven: Uncertainty-Facing Engineering Agents

Topic:

```text
An engineering agent framework whose primary outputs are uncertainty profile, panel divergence, and calibration.
```

Title:

```text
Uncertainty-Facing Engineering Agents:
Calibrated Abstention and Bounded Dispatch for Long-Horizon Debugging
```

---

# Part XXV: How to Package for Engineering Job Applications

---

## 100. Do Not Hit the Interviewer with the Full Universe Framework

The complete theory is too large.

For interviews, compress it into a case study:

```text
I built a reliability control flow for AI coding agents.
It decomposes long-horizon debugging into Route Truth, Numeric Truth, Quality, and Performance.
The core is preventing agents from premature patching without evidence.
I used FA4 / CUDA / FP4 debugging as a case study.
```

---

## 101. 30-Second Version

```text
I work on the engineering control surface for AI coding agents.
The core is making the agent prove it is on the correct route before fixing code,
avoiding fallback, unsupported, stale binary, or wrong paths being mistaken for success.
```

---

## 102. 3-Minute Version

```text
I decomposed long-horizon debugging into four gates:
Route Truth, Numeric Truth, Quality, and Performance.

If Route is not passed, do not discuss numeric root cause.
If Numeric has no first divergence, do not patch.
If Quality is not passed, do not discuss performance.

Applied to FA4 / FP4 CUDA flash attention debugging,
this prevents the agent from prematurely guessing rowsum, writeback, or dispatch.
```

---

## 103. Suitable Target Roles

Not directly positioned as a CUDA kernel expert, but as:

```text
AI-assisted engineering workflow engineer
LLM coding agent reliability engineer
developer tooling engineer
AI engineering control plane designer
ML infra tooling engineer
verification workflow engineer
agent evaluation / reliability engineer
```

Your core competency is:

```text
Turning messy engineering problems into adjudicable state machines.
```

---

# Part XXVI: Core Glossary

---

## Route Truth

Proving whether the correct route is being followed.

## Numeric Truth

Proving whether the numbers on the correct route are correct segment by segment.

## Quality Truth

Proving that model output quality is normal.

## Performance Truth

Proving that speed improvements are real and valuable.

## S Track

The only permitted legal data flow.

## Route Lock

Blocking all other forbidden paths, allowing only the S track.

## State Lock

Fixing seed, shape, binary, type, layout, input.

## First Divergence

The first stage where actual_gpu and expected_oracle exceed tolerance.

## Repair Permission

Only after first divergence is proven, modification of the corresponding file / function / block is allowed.

## Downward Model

A model that generates details and answers downward from purpose.

## Upward Model

A model that reverses upward from results, details, logs, and patches to infer purpose, gate, and contract.

## Purpose Lock

Freezing human intent, used to calibrate the direction of D↓ and U↑.

## Event Gate Lock

Locking intermediate necessary events and gates.

## Dual Format Lock

The same canonical graph split into downward format and upward format.

## Canonical Event Graph

Standard causal skeleton:

```text
Purpose → Gate → Event → Evidence → Result
```

## Reverse Work-Order Synthesis

Generating upward training work orders in reverse from results, code, reports, and traces.

## Trajectory-to-Intent Compilation

A data generation method that decompiles downward AI execution trajectories into purpose, gate, evidence, and dispatch.

## Goal-Locked Bidirectional Adversarial Post-Training

Purpose-locked bidirectional adversarial post-training.

## Uncertainty Profile

A structured output describing the model's current uncertainty sources, intensity, and divergence reasons.

## Evidence Receipt

A replayable evidence record produced by tool execution, tests, builds, route checkpoints, etc.

## Bounded Next Dispatch

A precise next-step work order issued when uncertain, including scope, required receipts, and stop conditions.

---

# Final Summary

---

## Layer One: Engineering Method

The correct engineering method that grew out of FA4 is:

```text
First verify route truth
then verify numeric truth
then verify quality
finally verify performance
```

That is:

```text
Route Truth
→ Numeric Truth
→ Quality Truth
→ Performance Truth
```

If Route is not passed, do not discuss numeric root cause.
If Numeric has no first divergence, do not patch.
If Quality is not passed, no performance.
Performance cannot be built on the wrong path or false success.

---

## Layer Two: Model Behavior Problem

Existing models are too prone to:

```text
see details
→ guess downward
→ patch
→ cover up uncertainty with polished narratives
```

You want to train them to:

```text
see details
→ push upward
→ find purpose / route / gate / contract
→ assess uncertainty
→ abstain if evidence is insufficient
→ issue precise work orders
```

This is the reverse-abstraction ability.

---

## Layer Three: Dual-Model Adversarial Post-Training

You propose:

```text
Downward Model generates answers from purpose
Upward Model reverses from results to purpose and generates answers
The two compete under the same purpose vector
Multi-judge scoring
meta-synthesizer recombines
then split into upward and downward formats for retraining
```

It is not an ordinary prompt.
Not an ordinary reviewer.
Not ordinary debate.
Not a solver-verifier.

It is:

```text
Goal-Locked Bidirectional Adversarial Post-Training
```

---

## Layer Four: Uncertainty-Facing Framework

Ultimately, this framework is not about "always giving definite answers."

It enables the system to:

```text
recognize uncertainty
express uncertainty
calibrate uncertainty
face uncertainty
abstain when evidence is insufficient
issue bounded next dispatch when uncertain
```

Divergence is not noise.
Divergence is the system's primary sensor for its own uncertainty.

---

## Final Sentence

What you have proposed is an AI post-training framework that grew out of FA4 engineering debugging:

> **Use Route Truth to prevent false success, use Numeric Truth to prevent random patching, use Quality Truth to prevent superficial usability, use Performance Truth to prevent garbage acceleration; then abstract this set of engineering truth gates into bidirectional adversarial training of the Upward Model and Downward Model, enabling AI to simultaneously learn to go from purpose to result, and from result to reverse-infer purpose.**

The core of this framework is not "making AI better at generating answers."

It is:

> **Enabling AI, between generation, acceptance, divergence, uncertainty, dispatch, and repair, to learn when to go downward, when to pull upward, and when to stop.**
