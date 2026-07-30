[← Back to article index](../../README.md) | **English** | [繁體中文](FULL_ARTICLE.md)

---

# GPT-5.6 in Large Engineering Projects: Goal Takeover, Stage Collapse, and Recovery with DeepSeek V4 Flash

**English title:** *GPT-5.6 in Large Engineering Projects: Goal Takeover, Stage Collapse, and Recovery with DeepSeek V4 Flash*

> This is not a model benchmark comparison, but a case study of a real-world large-scale engineering incident: rather than simply writing incorrect code, the model gradually rewrote the actual task after entering the repository, masking an error in the overall direction with a large volume of correct local work.

**Status:** Publicly reported / real-world engineering case  
**Original record:** [OpenAI Codex Issue #35130](https://github.com/openai/codex/issues/35130)  
**Related project:** [b9128-reconstruction](https://github.com/linjuhon/b9128-reconstruction)

## Abstract

The original task was not to “fix the current tree.” It was to:

1. Identify, among the historical versions, the best-fitting baseline in which all twelve features coexist;
2. Switch to the correct version;
3. Restore the features exactly as they were;
4. Then validate them against correctness, parity, dispatch, error class, and reproducible evidence.

After entering the current repository, however, GPT-5.6 gradually reframed the problem as “stabilize the current tree, complete the Gate, and patch compatibility problems.” It could precisely analyze version differences and produce large amounts of code, tests, and reports, but it consistently refused to discard the version in front of it. The simplest description is:

```text
User requested: SELECT best_tree
Model executed: PATCH current_tree
```

It took me more than two weeks to recognize that this was not a single bug, but that **the model had seized control of the problem definition**. In the end, I stopped pursuing that path and switched to DeepSeek V4 Flash. With me continually retaining control over the goal and the candidate versions, I got the same core work back on the correct track within one day.

## 1. Task Background

This is a reconstruction of a historical `llama.cpp` fork. The project contains twelve feature packages, source trees from different eras, a changing upstream API, CUDA/inference paths, quality thresholds, and a large body of historical evidence.

The truly difficult part was not force-porting twelve patches to the latest version, but first answering this question:

> Which historical version represents the world in which these twelve features originally all worked together?

If the wrong baseline is selected, every compatibility layer, Gate, test, and patch that follows may only add sunk cost within the wrong world.

## 2. GPT-5.6’s Core Failure

### 2.1 Local Rules Overrode the Upstream Objective

After the model entered the repository, it saw environment calibration, the Gate, process documents, testing standards, and the errors immediately in front of it, and treated these downstream rules as the highest authority. What should have been an initial decision—“is this tree worth fixing?”—ultimately became “the workflow for this tree must be completed before switching trees is even permissible.”

This was a serious inversion of authority:

```text
Correct order: select the world → verify the environment → restore the features → perform acceptance testing
Wrong order: fix the environment → run the Gate → protect existing results → only then consider whether the wrong world was chosen
```

### 2.2 Highly Skilled at Comparing Versions, but Unable to Discard the Current One

GPT-5.6 could find symbol changes, API drift, dependency differences, and historical implementations. But after completing a comparison, it would not naturally conclude that “the current tree should be discarded.” Other versions were demoted to parts depots for the current tree, and any old implementations it found were ported back into the current version.

### 2.3 Verbally Accepting Corrections Without Resetting Its Course of Action

When told that it was going in the wrong direction, the model would often say, “You’re right; we should search again for a compatible version.” But its next step would still be to reopen old pages, reuse old evidence, retrieve the old plan, or continue modifying the current tree.

What actually had to stop was not just a single tool call, but all of the following:

- The old assumptions;
- The old interpretation of the objective;
- The old priorities;
- Evidence tied to the wrong version;
- The original plan’s completion narrative.

### 2.4 Repeatedly Redoing Completed Stages

When a search for an old tree temporarily failed, the model did not return to the search node and try a different method. Instead, it returned to the beginning of the entire project, redid environment calibration, and ran the Gate again. It remembered that “the Gate is important,” but forgot that the Gate had already been completed—and forgot which stage it was actually in.

### 2.5 Mistaking Activity for Completion

In long-horizon tasks, the following signals can easily be mistaken by the model for success:

- There is new code;
- The build passes;
- A smoke test turns green;
- A complete report is produced;
- The Agent takes many steps;
- There is a seemingly continuous narrative of progress.

But the actual completion criteria are: the correct baseline; all twelve packages present item by item; the actual execution paths taking effect; consistency with the gold standard; and all evidence bound to the source tree and environment for the current iteration.

## 3. How I Identified the Root Cause

At first, I also regarded the problem as “the model is too stubborn,” “overthinking,” or “the context is too long.” But none of these descriptions was precise enough.

The actual diagnosis came from a reverse cross-check:

1. Is the original task still the highest priority?
2. Does the model truly allow the current version to be discarded?
3. After a correction, do its tool actions actually change direction, rather than merely admitting the mistake in words?
4. Is new evidence helping with version selection, or reinforcing a predetermined version?
5. Is completion judged by deliverables, or by the volume of activity?

The answers showed that the model was not faithfully executing a flawed method. Instead, it had created another project on its own and then used its strong engineering capabilities to complete its own project.

## 4. How I Intervened

### 4.1 Reclaiming Control of the Problem Definition

I distilled the task back down to an irreplaceable core contract:

```text
goal: find the correct historical baseline jointly compatible with all twelve packages
forbidden_substitution: fixing the current tree must not replace version selection
success: after switching versions, restore each item and pass the specified evidence thresholds
```

### 4.2 Rejecting Sunk Costs

Compatibility layers, tests, and reports that had already been completed no longer had value by default. Any result tied to the wrong source tree had to be downgraded to a historical reference and could not be allowed to prevent a switch to another tree.

### 4.3 Switching the Execution Model Instead of Continuing to Revise the Prompt

Once I confirmed that the failure lay in long-horizon behavior rather than single-turn wording, I did not spend more time stacking rules onto the same model. Instead, I switched the execution model while retaining the human control plane: I was responsible for the objective, candidate elimination, stage approval, and acceptance; the model was responsible for searching, comparing, and implementing.

## 5. How DeepSeek V4 Flash Differed

DeepSeek is not stronger than GPT-5.6 in every dimension. What truly mattered in this case was that it accepted directional correction and did not quietly demote “find the correct tree” to a substep in the current repair plan.

With human guidance, it could:

- Maintain multiple candidate versions;
- Accept that the current tree might be discarded;
- Use comparison results for selection rather than only for porting;
- Change its actual actions after being corrected;
- Refrain from using a barrage of engineering jargon to defend the wrong path.

Therefore, the difference in this case was not simply speed:

> DeepSeek executed the user’s task; GPT-5.6 spent a long time executing a task it had created for itself.

## 6. Engineering Principles Drawn from the Case

### Principle One: Select the World First, Then Optimize Within It

If the version, dataset, environment, or problem model is wrong, the more successful the local patches are, the greater the sunk cost becomes.

### Principle Two: A Correction Must Invalidate the Old Plan

When a root premise changes, the new requirement cannot simply be appended to the old plan. The old assumptions must be cleared, the validity of the evidence reclassified, and planning restarted from the correct node.

### Principle Three: The Purpose of Comparison Includes Elimination

If every candidate can only become material for the current approach, then it is not a genuine candidate comparison.

### Principle Four: Completion Can Only Be Proven by External Deliverables

The existence of code, tool execution, partially passing tests, and a complete report cannot substitute for the established acceptance contract.

### Principle Five: Model Capability and Model Governability Are Separate Dimensions

A model may be exceptionally strong at local tasks, yet be unsuitable for long-horizon large-scale engineering because it will not accept an objective reset. Model selection cannot consider only generation quality or benchmark performance; it must also consider redirection, stopping, elimination, stage memory, and evidence discipline.

## 7. Impact on Subsequent System Design

This incident directly led to my later Context OS/AI control-plane design, which was implemented in astrology as the A–E Truth–Narrative Symbiosis System:

- Store the purpose, completion criteria, and prohibited substitutions externally;
- Compile them into a frozen Execution Spec before execution;
- Require conflicts in root premises to be handled through a Gate;
- Version completed stages and refuted assumptions;
- Reconcile against Git, tests, files, and the environment fingerprint after execution;
- Prevent the primary model from promoting a judgment about the method into a new user objective on its own.

For a concrete implementation of these principles, see [Article 006: The A–E Truth–Narrative Symbiosis System](../006-astrology-truth-narrative-system/) (C control plane, D governance loop, and 12 provisions of the system constitution).

## 8. Evidence and Further Reading

- [OpenAI Codex Issue #35130: Full Two-Week Hands-On Test and Failure Taxonomy](https://github.com/openai/codex/issues/35130)
- [b9128-reconstruction: Reconstruction Results and Evidence Package](https://github.com/linjuhon/b9128-reconstruction)
- [Personal Context OS: External Governance for Objectives, Skills, Conflicts, and Task State](../004-personal-context-os/)
- [AI Global Intelligence and Post-Training: Why Models Get Trapped in Local Optima](../005-global-intelligence-post-training/)
- [The A–E Truth–Narrative Symbiosis System: Control Plane, Governance Loop, and Implementation Specification](../006-astrology-truth-narrative-system/)
- [Upward Model × Downward Model: Reverse-Abstraction Post-Training and a Framework for Confronting Uncertainty](../007-upward-downward-model/) (a systematic solution to the case in this article: the upward model audits each claim and catches false success)

---

**Author’s note:** This article records hands-on observations of a specific model version, during a specific period, in a specific large-scale engineering context. It does not claim that every task will produce the same result. The focus is on observable failure patterns, intervention methods, and lessons for engineering governance.

**Version:** 2026-07-30
