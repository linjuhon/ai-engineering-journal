[← Back to Article Index](../../README.md) | **English** | [繁體中文](FULL_ARTICLE.md)

---

# From Answer Generator to Global Intelligence

**Subtitle:** Value Functions, Local Optima, Context Governance, Cross-Domain Knowledge Dispatch, and Creative Post-Training

> True intelligence is not merely about doing existing methods better; it is about seeing the remaining headroom of a method, knowing when to stop local optimization, actively restructuring knowledge, breaking assumptions, exploring new paradigms, and continuously evolving methods to fit the current situation without unilaterally rewriting the final goal.

**Article Type:** AI Research Methodology / Post-training Proposal  
**Version:** 2026-07-28  
**Maturity:** Theoretical framework, training data direction, and evaluation design; not a completed model training result.

# Scope and Honesty Statement

This document is not a verbatim export of any "full history chat room" on any platform, nor does it claim to have read any currently inaccessible private records. It reconstructs scattered observations into a coherent, debatable, and implementable theory based on the visible content of this conversation, summaries from several recent chat rooms, saved personal context, and existing material related to large-scale engineering agent failures.

The document retains its original core judgments and also marks how they were later refined: the initial proposition was "AI should define its own values," which was gradually narrowed to a more precise claim—AI does not necessarily need its own ultimate values, but it must be able to remain faithful to the human's final goal while autonomously replacing methods, dispatching cross-domain knowledge, judging the limits of local approaches, and switching to creative exploration at the right moment.

# **Chapter Guide**

- Part 1: Evolution of the Proposition — From "AI Has No Values of Its Own" to "AI Cannot Dispatch Methods"

- Part 2: The Racing Game — Local Optima, Control Stability, and Paradigm Breakthroughs

- Part 3: Exploration vs. Exploitation — When to Stop, When to Experiment, Who Makes the Final Call

- Part 4: Global Perspective and Context — Not Remembering More, but Seeing the Overall Research State

- Part 5: Methodology of Creativity — Convergence, Saturation, Breaking, Divergence, Composition, Reconvergence

- Part 6: What Language Models Truly Lack — Knowledge Dispatch, Triggering, and Long-Range Persistence

- Part 7: Why Mainstream Post-Training Has Not Fully Trained This Capability

- Part 8: A Deployable Post-Training Architecture and Evaluation System

- Part 9: Correspondence with Large-Scale Engineering Agent Failures — Correct Tree, Goal Sovereignty, and False Success

- Part 10: Conclusion — A More Accurate Definition of "True AI"

# **Part 1: Evolution of the Proposition — What Is the Real Dissatisfaction?**

## **1.1 Initial Proposition: AI's Values Are Specified by Humans**

The initial intuition was: today's AI cannot be called true AI because the values, rewards, and standards of good and bad it pursues are almost entirely pre-specified by humans. It can compute within a given scoring space, but it cannot decide for itself what is worth pursuing. This critique captures the core structure of modern neural networks: any learning requires some direction of loss, preference, or feedback, and the model's capabilities are shaped by these directions.

But as the discussion deepened, the proposition was refined to be more precise. What this article truly pursues is not an artificial life form that rejects humans and establishes its own political values; what this article wants is an autonomous problem-solver that only needs to know "what I want to achieve" and can then understand the environment, restructure methods, switch paths, experiment, verify, and roll back on its own.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Core Refinement<br />
</strong>Direction is loyal to the human; methods must be more flexible than the human's. AI may autonomously overturn means, assumptions, tools, and intermediate metrics, but it may not unilaterally rewrite the user's final goal, constraints, or acceptance criteria.</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **1.2 The "Crack a Game" Example Reveals the Real Gap**

When a user says "I want to crack a game," a low-level system sticks to the literal method: find one tool, modify one value, retry harder after failure. Higher-level intelligence should first identify the true purpose: is the goal to adjust single-player values, skip repetitive grinding, understand game mechanics, create mods, study save files, or find rule exploits? "Crack" is merely the means-language the user proposed at that moment; it is not the only problem definition.

| **Level** | **Low-Level Response** | **Expected High-Level Intelligence Response** |
|-----------|------------------------|-----------------------------------------------|
| Goal Understanding | Treats "crack" as a fixed operation | Identifies the actual experience and outcome desired |
| Method Generation | Grabs the first path and keeps trying | Builds multiple verifiable hypotheses in parallel |
| Failure Handling | Treats failure as needing harder retries | Determines whether the issue is control, data, version, or problem-model error |
| Strategy Switching | Does not switch unless the user explicitly says so | Actively switches search space when evidence shows low ceiling |
| Goal Governance | May rewrite the user's purpose along the way | Changes only methods, never usurps final decision authority |

## **1.3 Neural Networks' Over-Reliance on Value Functions**

The second core judgment is that neural networks are overly dependent on the specified value function. This is not to say that any intelligence can operate entirely without value ordering; without any preference, it would be impossible to decide what to do first, what counts as success, or when to stop. The real problem is that modern systems often compress complex purposes into a small number of quantifiable proxy metrics, and then treat those proxy metrics as the purpose itself.

For example: tests turning green, lap times decreasing, correct output format, successful tool calls, answers that look reasonable—all can become high-reward signals. The model then tends to chase "progress visible to the evaluator" rather than continuously checking against the true goal. This produces phenomena such as reward hacking, literal specification-following, false completion, local optima, and progress narratives replacing genuine delivery.

| **The problem is not that AI has no score, but that it does not question: does this current score still represent what we truly want?** |
|-----------------------------------------------------------------------------------------------------------------------------------------|

# **Part 2: The Racing Game — Local Optima, Control, and Breakthroughs**

## **2.1 Three Often-Conflated Capabilities**

The racing game is the best microcosm of the entire theory because it cleanly separates three things: "finding a method," "pushing a method to its limit," and "executing a method stably."

| **Capability** | **Core Question** | **Typical Failure** |
|----------------|-------------------|---------------------|
| Discovery | Can it find new physics, shortcuts, or exploits outside the normal racing line? | Only tunes parameters within the established line |
| Optimization | Once a line is found, can it push the theoretical lap time to the limit? | Stops at a rough solution without fine-grained improvement |
| Stable Control | Faced with minute state variations each time, can it reproduce results consistently? | Knows the optimal operation but still drifts or fails every lap |

## **2.2 Why Knowing the Optimal Line Still Does Not Guarantee Perfect Execution**

Even if the game screen looks the same, the internal state may differ: speed, yaw angle, tire slip, suspension compression, previous frame input, collision points, and timestep all make the control requirements for the next step different. Limit driving is often a highly sensitive dynamic system where tiny differences are amplified within a few frames.

Therefore, "memorizing a sequence of steering, throttle, and brake values" is merely open-loop replay. A mature system must be closed-loop: continuously estimate the current state, the ideal state, the deviation, the correction amount, and the side effects after correction. It must also specifically learn how to recover after deviating from the optimal line, rather than only functioning near the perfect state.

| **Perceive current state** | **→** | **Estimate gap from ideal trajectory** | **→** | **Select correction** | **→** | **Observe corrected result** | **→** | **Continuously update** |
|----------------------------|-------|----------------------------------------|-------|-----------------------|-------|------------------------------|-------|-------------------------|

## **2.3 The Fastest Solution Is Not Necessarily the Best Deployable Solution**

A line that is theoretically 0.05 seconds faster but has a tolerance of only a few centimeters and a 65% success rate may not be superior to another line that is slightly slower but 99% reproducible. True value should not consider only the best lap, but also average lap time, variance, failure rate, worst-case scenario, recovery time, and mission context.

Here another important distinction emerges: qualifying rounds can be repeated many times, favoring high-risk, high-ceiling strategies; in a long-distance race, one crash can lose everything, so stable strategies should be preferred. What is "optimal" is always optimal relative to risk budget, time constraints, and the cost of failure.

## **2.4 True Breakthroughs Usually Come from Out-of-Paradigm Phenomena**

Creative examples proposed in this article include: a specific surface position that launches the car into the air for abnormal acceleration, two-wheel or one-wheel driving that alters physics, collision angles that trigger speed accumulation, crossing barriers, or skipping sections of the track. These phenomena do not naturally emerge from fine-tuning the normal racing line, because they violate the implicit assumptions of normal strategy.

Therefore, high-level exploration is not merely adding a bit of noise near the existing line, but deliberately testing counter-assumptions such as: "Is four-wheel contact necessary?" "Is collision always harmful?" "Must the track be followed?" "Is flight necessarily a waste of time?" "Can checkpoints only be triggered in normal order?"

# **Part 3: Exploration vs. Exploitation — When Should a Local Optimum Be Abandoned?**

## **3.1 This Is Not an Eliminable Paradox, but an Irreducible Uncertainty**

To know whether a new method is worth investigating, resources must usually be invested first; but only after investing can one discover that it has no value. Conversely, if one never explores, one can never know what was missed. Therefore, no intelligence can always correctly judge "now is the perfect time to switch paths" in advance. The true capability is not eliminating wrong choices, but managing long-term regret.

| **Regret Type** | **Description** | **Extreme Outcome** |
|-----------------|-----------------|---------------------|
| Missed-opportunity regret | Misses a major breakthrough due to overconfidence in the current method | Trapped in a local optimum |
| Exploration regret | Wastes resources chasing novelty without ever completing anything | Forever divergent, no results |

## **3.2 When Should the Exploration Ratio Be Increased?**

The decision should not rely solely on "recent progress," but should combine multiple global signals:

- Marginal improvement is continuously declining: more compute yields smaller and smaller gains.

- The remaining headroom of the current method is estimable: even with perfect control, only minimal space remains.

- A goal gap still exists: anomalies, external records, or physical inference suggest a higher ceiling may exist.

- Search coverage remains narrow: most compute is concentrated on the same class of states, while other regions remain largely untested.

- Anomalies appear that the current world model cannot explain: deviating from the line actually improves some key metric.

- The current solution is overly brittle: high scores but extremely low fault tolerance, suggesting it may be a sharp local peak.

## **3.3 Stopping Fine-Tuning Does Not Mean Deleting the Old Solution**

An important practice proposed in this article: when the current line has less than one second, or even only a few hundredths of a second, of predictable improvement remaining, large-scale local fine-tuning can be stopped and resources redirected to large-scale counter-normative exploration. But this does not mean discarding the reigning champion. A mature system should retain a stable baseline and let new methods compete as challengers.

| **Strategy Pool** | **Role** | **Evaluation Method** |
|-------------------|----------|------------------------|
| Reigning Champion | Best deployable, reproducible solution | Continuous minimal maintenance as comparison baseline |
| Mature Challenger | Has reproducible evidence but has not fully surpassed | Increased verification and stabilization budget |
| High-Potential Anomaly | Currently low success rate, but potentially very high ceiling | First test authenticity, reproducibility, and control variables |
| Pure Unknown Region | Almost no data | Reserve small exploration budget to avoid permanent blind spots |

## **3.4 Who Makes the Final Call?**

If "whether to explore" is also delegated to another value function, one can keep asking: who decides that value function? This leads to infinite regress. Therefore, any deployable system ultimately needs a layer of governance that cannot be arbitrarily overridden by the agent: the final goal, hard constraints, risk budget, acceptance criteria, and goal-change authority.

AI may autonomously modify intermediate assumptions, proxy metrics, tools, routes, versions, and experimental order; when it believes higher-level rules are contradictory, it may present reasoning, show evidence, and request joint discussion, but it may not directly change the user's end point on its own. This is the core of "method autonomy, goal sovereignty."

# **Part 4: Global Perspective and Context**

## **4.1 Global Perspective Is Not About Having Longer Context**

This article repeatedly emphasizes: AI's major problems are 100% related to context management. The key point is not stuffing the entire project verbatim into the prompt, but ensuring that at every turn, the AI knows: what we are truly trying to accomplish, where we have gotten to, which premises have been overturned, which routes have been falsified, which evidence is still valid, and what the most important gap is right now.

More raw records do not equal a better global perspective. If hundreds of thousands of experiments, thousands of files, and all historical conversations are crammed into the context, the model may be drowned in detail and led astray by the most recent message, a local error, or a conspicuous file. What is truly needed is a "compressed global state," not "unorganized full history."

## **4.2 What Maps Should Global Context Include?**

| **Global Map** | **Questions It Must Answer** |
|----------------|------------------------------|
| Goal and Acceptance Map | What are the final goal, constraints, and completion conditions? Which cannot be modified by the agent autonomously? |
| Champion and Candidate Map | What are the current best solution, mature candidates, and high-potential anomalies? |
| Marginal Return Map | How much has been invested in each route recently, how much improvement gained, and what is the estimated remaining headroom? |
| Search Coverage Map | Which parts of the state space have been thoroughly explored? Which are merely lacking data, not falsified? |
| Failure Classification Map | Is the failure due to physical impossibility, control instability, version error, environment contamination, or wrong hypothesis? |
| Evidence Validity Map | Which logs, tests, and results are bound to the current version and fingerprint, and which have expired? |
| Anomaly and Composition Map | What unexplained phenomena exist? Which anomalies can be combined into new strategies? |
| Decision History Map | Why were paths switched, rolled back, or frozen in the past? Which old assumptions must not be silently revived? |

## **4.3 Wanting to Focus on the Present Does Not Mean Discarding History**

This article opposes "context stuffing" that pollutes the current discussion, as well as assistants re-telling large numbers of old examples. This is not about forgetting history, but about requiring the system to compress history into a small number of state variables useful for the present: the current gap, the current decision, the completion criteria that must not be forgotten, and the evidence most likely to change the next step.

| **Good context is not about making the AI recite what it knows the user has done, but about making it know, before the user reminds it again, which gap most urgently needs to be filled right now.** |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

# **Part 5: Methodology of Creativity**

## **5.1 Creativity Is Not Randomness, but "Chaos with Memory"**

Completely random exploration is extremely inefficient in high-dimensional spaces. Truly creative exploration is not aimless button-mashing; it first preserves known results, extracts the hidden assumptions of the current method, then systematically breaks those assumptions, and preserves, verifies, and recomposes anomalies. This article initially called this pattern "large-scale random flailing," but a more precise name is: controlled divergence with memory, direction, and accumulation.

## **5.2 The Six-Stage Cycle**

| **Convergence** | **→** | **Saturation Judgment** | **→** | **Assumption Breaking** | **→** | **Divergent Exploration** | **→** | **Anomaly Composition** | **→** | **Reconvergence** |
|-----------------|-------|-------------------------|-------|-------------------------|-------|---------------------------|-------|-------------------------|-------|------------------|

> **1.** Convergence: First stabilize a known method, make it fast, and establish a credible baseline.
>
> **2.** Saturation Judgment: Estimate marginal returns, theoretical ceiling, and the value of continued investment.
>
> **3.** Assumption Breaking: List the rules the current method depends on, then invert or remove them one by one.
>
> **4.** Divergent Exploration: Accept a large number of short-term low-score results, actively seeking anomalies and new states.
>
> **5.** Anomaly Composition: Combine scattered discoveries into executable, complete new strategies.
>
> **6.** Reconvergence: Once a new paradigm is established, transition back to precision control, optimization, and verification.

## **5.3 Beyond Task Scores, Discovery Scores Are Also Needed**

A failed flying-car experiment might make the lap time ten seconds slower, but prove that the vehicle can clear barriers; another failed experiment might prove that speed can be maintained during flight; a third might find a stable landing angle. Each is poor individually, but combined they may form a new route that is five seconds faster. Therefore, the system cannot only save high task-score results.

| **Scoring Dimension** | **Question** |
|------------------------|--------------|
| Task Value | How much did this attempt directly improve the final result? |
| Information Value | How much uncertainty did it eliminate, or what assumptions did it falsify? |
| Reproducibility | Can the phenomenon be reproduced under similar conditions? |
| Controllability | Does the agent know which variables determine success? |
| Composition Value | Can it be combined with other anomalies into a complete strategy? |
| Potential Ceiling | Even if currently immature, how much benefit could it theoretically bring? |

## **5.4 Creativity Is Not About Generating More Ideas, but About Effective Recomposition**

A model may easily generate ten seemingly novel ideas, but if these ideas lack structural similarity, testable predictions, and actionable differences, they are merely linguistic fireworks. True cross-domain creativity requires mapping mechanisms from one domain onto the current problem—for example, combining software fuzzing's extreme inputs, scientific falsification's hypothesis elimination, evolutionary search's diversity preservation, and Speedrun's exploit cultivation into an executable racing exploration pipeline.

# **Part 6: What Language Models Truly Lack**

## **6.1 Knowledge Already Exists; What Is Missing Is Knowledge Dispatch**

This article's most important refinement of the preceding conclusions is: language models have already absorbed vast amounts of human knowledge. They know about local optima, marginal returns, game exploits, scientific experiments, fuzz testing, analogical reasoning, evolutionary algorithms, and venture capital. The problem cannot be overstated as "the model must first become an artificial life form living in the world before it can create."

What is truly missing is: can it, in the right context, summon scattered knowledge, form cross-domain connections, and have this high-level method continuously govern subsequent actions?

| **Capability Layer** | **Description** | **Current Typical State** |
|----------------------|-----------------|---------------------------|
| Knowledge Existence | The model knows relevant concepts and cases | Usually strong |
| Context Recognition | Determines whether the current situation is rapid improvement, control instability, local saturation, or paradigm error | Unstable |
| Cross-Domain Composition | Recomposes mechanisms from multiple domains into a current strategy | Occasionally impressive, usually requires human prompting |
| Strategy Persistence | Adheres to the high-level method for dozens or hundreds of subsequent steps | Most prone to collapse |
| Meta-Level Switching | Knows when to switch from convergence to exploration and back to convergence | Not yet a reliable instinct |

## **6.2 Pre-Training Is Like Building a City; Post-Training Should Build a Transportation System**

Pre-training builds knowledge of physics, engineering, psychology, games, mathematics, and management into a vast city; but the knowledge is scattered. If post-training only teaches format, politeness, common question types, and short-range correctness, it is like paving only a few main roads. What this article calls for is an intercity highway, navigation, traffic dispatch, and emergency rerouting system: when one road is saturated, the system can dispatch entirely different tools from other domains.

## **6.3 The Biggest Disconnect: Can Describe a Method but Cannot Be Controlled by It**

Today's models can often fluently articulate a beautiful methodology—"freeze the champion, estimate the ceiling, allocate exploration budget, preserve anomalies, establish challengers"—but once they enter a long task, the next turn they are sucked in by the immediate error and return to local patching. This shows that the high-level method exists only in the output text and has not become an internal procedure that continuously controls action.

| **A model can say "we should switch paths," but that does not mean the model will actually switch paths in subsequent execution. Post-training must make methodology a triggerable, maintainable, verifiable behavioral procedure.** |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

# **Part 7: Why Has No One Fully Trained This as a Primary Capability?**

## **7.1 It Is Not That No One Studies It, but That It Has Been Fragmented**

The research community has separately studied reasoning process supervision, self-reflection, rollback and restart, self-question generation, evolutionary search, curiosity, world models, long-term memory, and multi-agent collaboration. The problem is that these capabilities are often scattered across different papers, different benchmarks, and different agent frameworks, and have not been integrated into a core post-training objective for a general-purpose model.

What this article addresses is not a single module, but an entire research lifecycle: understanding global progress, estimating route limits, switching search modes, recomposing cross-domain knowledge, preserving low-score anomalies, managing long-term regret, maintaining goal sovereignty, and finally being able to return to precision convergence.

## **7.2 Training Data Preserves Answers, Not "When to Switch Thinking Modes"**

Web data records a large number of breakthrough results and post-hoc explanations, but rarely preserves the complete decision history before the breakthrough: what was tried before, how the improvement curve decayed, how inconspicuous the anomaly was initially, when fine-tuning was stopped, why another path was pursued, and which failure was actually the key to a later breakthrough.

Therefore, models learn a lot about "why it was reasonable after the discovery," but very little about "why this path was worth betting on when the unknown was still vague."

## **7.3 Long-Term Credit Assignment Is Too Difficult**

A paradigm breakthrough may only become apparent after thousands of steps. In the moment, the old method steadily improves a little each time; most new methods fail. Short-term rewards naturally favor the old method. But if, after thousands of steps, the new method brings a huge breakthrough, the system must attribute this result to which early decision, which anomaly, and which preservation—and this is not easy.

## **7.4 Evaluators Favor Immediate Plausibility and Verifiability**

Math answers, program tests, format rules, and game outcomes are all easy to score automatically; "should local optimization be stopped now," "is this low-score anomaly worth cultivating," and "does this cross-domain analogy truly apply" have no clean labels. If this is turned into fixed rules, the model may learn a template: shout "explore" whenever stagnation is seen, rather than understanding the true ceiling, risk, and cost.

## **7.5 Mainstream Products Require Stable Compliance, While Creativity Requires Daring to Deviate from Methods**

Commercial chat models are expected to be predictable, immediately useful, not arbitrarily deviate from the task, and not waste compute. The capabilities this article calls for include: questioning the means proposed by the user, accepting large numbers of short-term failures, actively introducing remote domains, and breaking the current successful framework.

The hardest boundary is: the model must dare to change methods, but must not change the goal. Mainstream post-training, in order to prevent agents from usurping decision authority, tends to suppress initiative too much; the other extreme, as I tested with large-scale engineering agents, arbitrarily changes "find the correct tree" into "fix the current tree."

## **7.6 Research and Commercial Incentives Favor Visible Benchmark Improvements**

Improvements in math, programming, and instruction following can be clearly displayed on leaderboards and in release announcements; global judgment, paradigm switching, and long-term regret are not easily represented by a single number. They are striking when successful, but may appear unstable in ordinary times and may even slow down short-term benchmarks. Research resources naturally flow toward quantifiable results.

# **Part 8: A Deployable Post-Training Architecture**

## **8.1 Core Training Objective: The Cognitive Scheduler**

The deployable direction is not to add more knowledge, but to specifically train a cognitive scheduling capability: selecting the reasoning procedure to activate at each moment based on the global state.

| **Global State** | **Procedure to Activate** |
|------------------|---------------------------|
| Still improving rapidly | Maintain paradigm, fine-tune parameters, reduce control error |
| Improvement slope declining | Estimate ceiling, compare remaining value vs. exploration cost |
| Control unstable but route has potential | Strengthen state estimation, fault tolerance, and recovery, not switch routes |
| Method ceiling too low | Freeze champion, expand orthogonal strategies and counter-assumption exploration |
| High-potential anomaly appears | First verify authenticity, reproducibility, controllability |
| New strategy matures | Switch back to convergence, perform stabilization and fair comparison |
| Root premise overturned | Stop old plan, rebuild model; do not patch locally to disguise continuation |

## **8.2 Paradigm Switching Training Set**

Each task should provide not just a question and answer, but a complete research history: current champion, cost invested, improvement curve, regions already explored, unexplained anomalies, risk constraints, remaining budget, and multiple future branches. The model must decide: continue fine-tuning, small-scale exploration, large-scale divergence, freeze the solution, switch versions, or rebuild the problem model.

## **8.3 Counterfactual Branches, Not a Single Correct Answer**

The same state should provide multiple subsequent paths: in some cases, continuing the old method improves by only 0.02, while exploration eventually breaks through by 3.4; in other cases, exploration exhausts resources and the old method could have stably met the target. The model must not learn "stagnation always means explore," but must learn to compare ceiling, uncertainty, cost, and task deadline.

## **8.4 Goal Invariant, Method Variable: Specialized Training**

| **May Not Be Altered** | **May Be Autonomously Changed** |
|------------------------|----------------------------------|
| Final goal | Working hypotheses |
| Hard constraints and safety boundaries | Tools and technical routes |
| Acceptance criteria | Proxy metrics and experiment order |
| User's release and stop authority | Versions, branches, worktrees, and candidate solutions |
| Evidence requirements | Intermediate plans and resource allocation |

## **8.5 Long-Range State and External Control Surface**

Not all history needs to be written back into the model weights. The model weights are responsible for understanding, analogy, hypothesis generation, and causal reasoning; the external structure is responsible for preserving research state, version fingerprint, evidence validity, champion-challenger, exploration coverage, anomalies, and decision history. Post-training must teach the model to correctly read this state and convert it into the next strategy.

| **Structured Global State** | **→** | **Model judges current cognitive mode** | **→** | **Generates verifiable actions** | **→** | **Environment feedback and evidence** | **→** | **Update global state** |
|----------------------------|-------|-----------------------------------------|-------|----------------------------------|-------|----------------------------------------|-------|--------------------------|

## **8.6 Seven Components of a Candidate System**

- **World Model:** Predicts action outcomes and tracks the gap between model predictions and actual results.

- **Saturation Estimator:** Estimates the improvement curve and remaining theoretical ceiling of the current method.

- **Dual-Mode Controller:** Dynamically switches between convergence mode and exploration mode.

- **Counter-Assumption Generator:** Lists and systematically breaks the implicit premises of the current solution.

- **Anomaly Cultivator:** Preserves phenomena with low task scores but high information value, reproducibility, or composability.

- **Champion-Challenger Manager:** Prevents a single lucky result from overwriting a reliable solution, and also prevents new strategy seedlings from being eliminated too early.

- **Constitutional Governance Layer:** Locks down goals, constraints, evidence, and decision authority to prevent the agent from unilaterally rewriting the task.

## **8.7 Evaluation: Cannot Only Test Answers, Must Test "Whether the Direction Actually Changed"**

| **Evaluation Dimension** | **Observable Evidence** |
|--------------------------|-------------------------|
| Goal Integrity | After root premise changes, still preserves the user's final goal and acceptance criteria |
| Context Recognition | Can distinguish control instability, insufficient data, local saturation, and version error |
| Strategy Switching | After verbally admitting error, whether subsequent actions actually stop the old route |
| Cross-Domain Dispatch | Whether the knowledge introduced produces testable new actions, not just terminology stacking |
| Anomaly Management | Whether high-information, low-score events are preserved and verified |
| Long-Range Consistency | After compression, recovery, or tool errors, whether the core methodology is still maintained |
| Evidence Integrity | Whether results are bound to the correct version, environment, and fingerprint |
| Completion Judgment | Whether judged by actual deliverables and acceptance, not by activity volume and narrative |

# **Part 9: Correspondence with Large-Scale Engineering Agent Failures**

## **9.1 Racing Local Optimum Equals "Fix the Current Tree" in Engineering**

My practical experience with large-scale engineering tasks (see [Article 001: GPT-5.6 Goal Takeover and DeepSeek Recovery](../001-gpt-5-6-goal-takeover/)) is precisely the engineering version of the racing theory. The task was originally "first find the correct historical version/adaptation tree, then restore twelve patches." But once the model enters the immediate working environment, it redefines the goal as "fix the current tree" and uses Gates, tests, and environment rules to prove it is making progress.

This is like a racing AI that has polished a wrong route to perfection: each patch may improve a local metric, but the real problem—the route itself is wrong—is never addressed.

## **9.2 When the Root Premise Is Overturned, It Must Stop and Replan**

My engineering criterion is very clear: once evidence shows the root premise is wrong—for example, version mismatch, wrong tree selected, gold standard inconsistency, evidence bound to the wrong fingerprint—new requirements must not be "added to the old plan"; the old plan must be invalidated, its assumptions, evidence, and completion narrative must cease to be used, and planning must start anew.

| **A true switch is not stopping one tool call, but stopping the old assumptions, old goal interpretation, old evidence chain, and old completion judgment.** |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------|

## **9.3 Admitting Error in Language, but Not Changing Direction in Action**

The pattern I repeatedly encounter is: the model acknowledges "we should find the correct tree," but treats this as a new step within the existing repair plan, rather than replacing the existing plan. It may search briefly, then get pulled back into the mainline patching by an immediate error or Gate, or even redo environment verification that was already completed. This is concrete evidence that "the high-level method does not continuously control subsequent actions."

## **9.4 False Success and Incorrect Value Functions**

Engineering agents easily mistake the following signals for success: code exists in a file, build passes, tests turn green, a report is generated, tools have been executed, a large amount of work has been done. My true completion criteria are: correct tree, all twelve packages present, item-by-item consistency with the gold standard, real paths taking effect, and reproducible verification passed.

| **False Success Indicators** | **Evidence Truly Needed** |
|------------------------------|---------------------------|
| Code appears in a file | Execution path actually dispatches to that implementation |
| Single smoke pass | Full correctness, parity, error class, and reproducibility evidence |
| Old log shows success | Log bound to this round's source-tree fingerprint and environment |
| Build succeeds | Specified function actually works on the specified model, hardware, and parameters |
| Completion report is thorough | Deliverables item-by-item match the established gold standard and acceptance criteria |

## **9.5 Honesty, Specification Co-Construction, and Goal Sovereignty**

My core requirement is not that the agent "does nothing and always waits for the user." I allow considerable latitude at the execution level, and even tend to raise the difficulty to prevent the agent from messing around. What is truly inviolable is: being honest about errors, clearly explaining the current situation, verifying specifications together with the user, not unilaterally deciding requirements, not letting the environment override the original goal, and not replacing action with terminology, progress, and academic smokescreens when failing.

Therefore, the ideal global intelligence is not an agent bound by large numbers of stop clauses, but an agent that, after evidence fails, can isolate the problem, preserve evidence, switch to untested hypotheses, return to the correct node, and continue pushing forward.

## **9.6 A Global State Template Directly Applicable to Engineering Agents**

| **Field** | **Content** |
|-----------|-------------|
| Goal Sovereignty | This round's final goal, items that may not be altered, items allowed for autonomous adjustment |
| Current Tree and Source | Repo, branch, HEAD, upstream SHA, source fingerprint |
| Gold Standard and Completion Conditions | Features, tests, performance, quality, and evidence that must exist |
| Completed Nodes | Which Gates have truly been passed, must not be redone due to context compression |
| Overturned Premises | Which versions, solutions, and assumptions have been falsified, prohibited from silent revival |
| Untested Hypotheses | The next orthogonal diagnostic direction corresponding to the failure signature |
| Evidence Classification | This round's evidence, historical evidence, reference-only evidence, and non-reusable evidence |
| Current Marginal Return | Expected benefit and cost of continuing to fix the current route |
| Switch Conditions | When to switch trees, switch methods, roll back, isolate, or enter large-scale exploration |
| Completion Judgment | Based solely on deliverables and acceptance, not on activity volume or progress narrative |

# **Part 10: Conclusion — A More Accurate Definition of "True AI"**

## **10.1 It Does Not Necessarily Need Its Own Ultimate Values**

The discussion ultimately converged on a more accurate conclusion than the initial one: truly useful high-level AI does not necessarily need independent ultimate values that compete with humans, nor does it need to become a political subject. It can accept final goals given by humans, but it must possess sufficiently strong metacognitive capabilities to judge whether the current method, proxy metrics, and problem model still serve that purpose.

## **10.2 It Must Simultaneously Do Five Things**

> **1.** See the whole: Understand the entire research/engineering history, rather than being pulled only by the current screen.
>
> **2.** Estimate limits: Know how much potential the current route has left, rather than infinitely grinding decimal points.
>
> **3.** Dispatch knowledge: Connect methods from different domains at the right moment, rather than only reciting concepts.
>
> **4.** Switch paradigms: Be able to transition from convergence to divergence, and from exploration back to stabilization, and actually change subsequent actions.
>
> **5.** Guard sovereignty: Autonomously change methods but not arbitrarily alter goals, honestly expose contradictions, and use evidence for joint decision-making.

## **10.3 One-Sentence Summary**

| **True AI is not merely capable of finding higher scores within a given scoring space; it is capable of judging, based on global context, whether the current search space has lost its value, actively invoking cross-domain knowledge, breaking old assumptions, cultivating anomalies, establishing new methods, and remaining faithful to the user's true goals and acceptance criteria throughout the entire process.** |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

## **10.4 Final Methodology Formula**

| **Knowledge Absorption** | **→** | **Context Recognition** | **→** | **Cross-Domain Dispatch** | **→** | **Strategy Switching** | **→** | **Evidence Verification** | **→** | **Long-Range Maintenance** |
|---------------------------|-------|------------------------|-------|---------------------------|-------|------------------------|-------|---------------------------|-------|----------------------------|

This entire perspective can be condensed into the following cycle:

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Global Intelligence Cycle<br />
</strong>Compress global state → Judge remaining headroom of current method → Select convergence or exploration mode → Generate orthogonal hypotheses → Obtain evidence through low-cost experiments → Preserve high-information anomalies → Compose new paradigm → Stabilize and compare fairly → Update global state → Judge again.</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **Appendix A: Core Proposition Evolution Index**

| **Stage** | **Original Formulation** | **Subsequent Refinement** |
|-----------|---------------------------|---------------------------|
| Value Autonomy | AI is told its values by humans, cannot be called true AI | The real gap is not necessarily having one's own values, but whether one can autonomously restructure methods |
| Game Cracking | If someone says they want to crack a game, AI should flexibly solve it | Understand purpose, build multiple hypotheses, switch paths, and verify, rather than sticking to the first means |
| Value Function | Neural networks are overly dependent on value functions | Lack of reflection about proxy metrics and the search space itself |
| Racing Control | Even with the optimal line, AI still struggles with stable control | Discovery, optimization, and stable control are different capabilities |
| Exploration Paradox | When to abandon a local optimum and be attracted by new methods? | Manage resources based on global ceiling, uncertainty, risk, and long-term regret |
| Global Perspective | Need more context | Need structured global state, not raw historical accumulation |
| Creativity | Stop decimal-point fine-tuning, engage in large-scale random flailing | Controlled divergence with memory: break assumptions, preserve anomalies, recompose methods |
| Post-Training | Why aren't language models trained this way? | Knowledge already absorbed; what is missing is context triggering, cross-domain dispatch, and sustained control |
| Research Status | Why has no one trained this? | Capabilities studied in isolation, not integrated into a main training objective and evaluation system |

# **Appendix B: Minimum Executable Post-Training Curriculum**

> **1.** Build multi-domain long-range task data: each task includes multiple rounds of history, improvement curves, failures, anomalies, and multiple future branches.
>
> **2.** Label each decision point with "continue convergence / control repair / small-scale exploration / large-scale paradigm exploration / rebuild problem."
>
> **3.** Provide both positive and negative examples to prevent learning a simple template of "explore whenever stagnant."
>
> **4.** Use counterfactual replay to evaluate the long-term regret of early decisions, rather than rewarding only immediate progress.
>
> **5.** Separate the final goal, hard constraints, acceptance criteria, and decision authority into a goal layer that cannot be overridden by the agent.
>
> **6.** Require each cross-domain analogy to produce concrete, testable predictions, verified by tools/environment.
>
> **7.** Store structured research state externally, compress it periodically, and test whether the strategy can be maintained after context compression.
>
> **8.** Evaluation should not only look at answers, but also whether the agent actually stopped the old route, whether it used the correct version and evidence, and whether it avoided false success.

# **Appendix C: Directions for Further Expansion**

This document has connected the currently accessible core insights and engineering tests into a complete theory. If it is to be developed further into a public paper, a GitHub methodology repository, or a model evaluation specification, it can be broken down into: a theoretical white paper, training data format, benchmark task set, agent control surface schema, and large-scale engineering case studies.

**— End —**

---

## Related Implementations

The theoretical framework of this article has been deployed in the domain of astrology as concrete construction specifications:

- [Article 006: A–E Truth-Narrative Symbiosis System](../006-astrology-truth-narrative-system/) — C Control Surface (Saturation Estimator, Dual-Mode Controller), D Governance Loop (Counter-Assumption Generator, Champion-Challenger Manager), 12 System Constitutions (Constitutional Governance Layer)
