[← Back to Article Index](../../README.md) | **English** | [繁體中文](FULL_ARTICLE.md)

---

# Personal Context OS

**Subtitle:** Private Chat, Multiple Skills, Clerk, Conflict Resolution, and Task Closure

> What truly needs to be preserved is not an ever-growing chat history, but multiple independently maintainable Skills that can be automatically full-text injected by topic.
>
> The main model focuses only on the present; the Clerk maintains purpose, criteria, boundaries, plans, conflicts, and completion status. All chat frontends, main models, and executors are replaceable; the real product is the Context Core.

**Article Type:** Product Architecture / AI Memory Governance  
**Version:** 2026-07-30  
**Maturity:** Complete product specification with a one-month MVP roadmap; core behavior still requires validation with real usage data.

# Table of Contents

> **1.** Document Purpose and Final Conclusion
>
> **2.** How the Problem Was Identified Step by Step
>
> **3.** Five Core Types of Context Failure
>
> **4.** Key Corrections to How the AI Responds
>
> **5.** Product Definition: Not a Single Note, but a Multi-Skill Shared Cognition System
>
> **6.** Skill Content, Activation, and Low-Authority Injection
>
> **7.** Division of Labor Among Chat History, Project State, and Knowledge Base
>
> **8.** Dual Paths: Casual Chat and Task Mode
>
> **9.** The Clerk Model: Central Role of the Entire System
>
> **10.** Limited Questioning: How to Avoid Stupid Questions
>
> **11.** Complete Closure Before, During, and After Execution
>
> **12.** Memory, Hybrid Retrieval, and Interrupt Correction Architecture
>
> **13.** Feedback Flow: Artifacts, Project Records, Skills, and Personal Memory
>
> **14.** Rolling Corrections and Replayable Self-Improvement
>
> **15.** Target Technical Architecture and Open-Source Component Roles
>
> **16.** Final Data Model, Directory Structure, and Interface
>
> **17.** One-Month Implementable Roadmap
>
> **18.** Acceptance, Evaluation, and Preventing False Success
>
> **19.** Rejected or Downgraded Directions
>
> **20.** Unresolved Questions That Require Real-World Testing
>
> **21.** Appendix A: Complete Workflow Examples
>
> **22.** Appendix B: Data Contract Examples
>
> **23.** Appendix C: Limited Question Bank and Regression Tests
>
> **24.** Appendix D: Glossary

# **1. Document Purpose and Final Conclusion**

This document reorganizes discussions from multiple chat sessions about "private AI chat, long-term memory, multi-note/multi-Skill, context compression, task specification, casual chat, conflict questioning, open-source carrier, and rolling corrections." It does not reproduce the conversations chronologically sentence by sentence, but instead consolidates the conclusions reached after each correction into a product specification ready for development and iterative improvement.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p><strong>Product in One Sentence</strong></p>
<p>A personal Context OS that accompanies the user in long-term discussions, continuously maintains multiple Skills, automatically full-text injects relevant context based on the current topic, detects conflicts between new and old requirements, asks limited questions with guesses when necessary, freezes specifications before execution, updates state after execution, and can connect to any main model and executor.</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

It is not a simple memory bot, nor another autonomous Agent, nor a system that stuffs all chat records into an ultra-long context. Its core job is to correctly connect "what the user is currently discussing" with "long-term confirmed goals, criteria, boundaries, and current status," ensuring that context assists understanding without stealing focus.

| **Dimension** | **Misunderstanding**                         | **Final Understanding**                                                |
|---------------|----------------------------------------------|------------------------------------------------------------------------|
| Memory        | Save all chats, then similarity search       | Save formal Skills, life memories, project state, and artifacts, used separately |
| Context       | More is better, dump everything in           | Current message is highest; relevant Skill full-text injected with low authority; history retains only necessary fragments |
| Questioning   | Ask whenever the model is uncertain           | Only ask for major decisions that belong to the user, and always provide a guess and recommendation first |
| Execution     | Main model reads history, understands, acts, then summarizes | Clerk organizes and corrects the spec first; execution model receives only a clean work package |
| Self-Improvement | Model modifies its own Prompt             | Feedback produces scoped, versioned, replayable Skill Patches |

# **2. How the Problem Was Identified Step by Step**

The entire product concept did not appear fully formed at the start. Through multiple conversations, as the user continuously pointed out why the AI's responses were off-target, the problem was progressively refined from "insufficient memory" to "management of context authority, focus, and formal state."

## **2.1 First Proposition: Large Problems Almost Always Become Context Problems**

When the model can see the complete project, documents, history, and tool state, many originally difficult problems do indeed become significantly simpler. The real bottleneck is often not that the model is incapable, but that it cannot see key information, retrieves the wrong information, or does not know which information carries the highest authority.

## **2.2 A More Serious Problem: It Forgets the "Completion Criteria"**

A project not being fully loaded causes ignorance; but forgetting the goal and completion criteria causes a more dangerous failure: the model fills in a hidden criterion on its own, then executes the wrong task with extremely high competence. This is the core problem the user encountered repeatedly in large-scale engineering work.

## **2.3 Second Correction: Existing Context Also Pollutes the Current Turn's Focus**

The problem is not that background should never be injected. The real problem is that the model treats background as the source of the topic. The user only wants to discuss a new gap, but because the long-term data contains high-frequency content like "control surface" and "engineering governance," the model expands the response into an old topic. This is not about having too much memory per se, but about incorrect authority ordering.

## **2.4 Third Correction: Don't Just Deconstruct What the User Already Knows**

Even if the model correctly describes what the user is doing, it is still unhelpful if it only categorizes, restates, and names things. The response needs to detect gaps the user has not yet filled, propose an incremental guess, and let the user correct it.

## **2.5 The Simplest Yet Most Critical Interaction Pattern**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p><strong>Guess + Counter-Question</strong></p>
<p>The AI does not need to read minds accurately, nor does it need to build a complex hidden-intent reasoner.</p>
<p>It only needs to state its most likely understanding, for example: "Are you talking about the control surface? Or am I being pulled by old context? My guess is that what you really want to discuss is context compression."</p>
<p>If the guess is wrong, the user corrects it in the next sentence; guesses must not be silently upgraded to formal requirements.</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **3. Five Core Types of Context Failure**

| **Failure Type** | **Manifestation**                           | **Consequence**             | **Corresponding Solution**                         |
|-----------------|----------------------------------------------|-----------------------------|----------------------------------------------------|
| Missing Information | Key files, history, or proper nouns are not found | Wrong answers or reinventing the wheel | Hybrid retrieval, Skill index, artifact store |
| Forgotten Criteria | The real goal, success criteria, and boundaries are forgotten | Efficiently completing the wrong task | Formal Skills, authority fields, pre-execution spec freeze |
| Implicit Goal Substitution | The model infers "what should really be done" on its own | User loses problem-definition authority | Conflict Gate, guess + counter-question, no silent overwrites |
| Background Focus Pollution | Relevant old data becomes the subject of the response | Current issue is blurred or derailed | Low-authority full-text injection, current message is highest |
| Zero-Increment Restatement | Re-categorizing what the user already knows | Looks complete but makes no progress | Require identifying gaps, proposals, next testable proposition |

Therefore, "context management" is not about stuffing more text into the model, nor is it just about summarization. It simultaneously includes: content selection, authority marking, focus control, formal state maintenance, conflict detection, and low-cost interactive correction when uncertain.

# **4. Key Corrections to How the AI Responds**

These rules are not general tone preferences; they are the minimal, permanently resident interaction Skills of the entire system. They come directly from the user's repeated corrections of the model's off-focus behavior.

- Focus on the present: the current sentence determines the direction of the response; old data only assists continuity.

- Don't show off memory: knowing past content is not a reason to output it; do not restate Skill content.

- Background can provide examples, but only one summary; examples must not dominate the entire response.

- Don't just take what the user already knows and rename it; must fill gaps, propose solutions, or offer new judgments.

- When the true intent is unclear, first give the most likely guess, then counter-question; do not vaguely ask "What do you want to talk about."

- Guesses are tentative, not facts; only write into formal Skills after correction.

- Don't usurp authority on big matters, don't interrupt on small matters: execution issues are the AI's own responsibility; only questions about requirements and boundaries should be brought to the user with an answer.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p><strong>Minimum Version of Permanent Interaction Prompt</strong></p>
<p>First address the gap the user has exposed in the current turn; do not restate background.</p>
<p>Relevant Skills serve only as current status; they must not dominate this turn's topic.</p>
<p>When uncertain, propose a specific guess and recommendation, then ask the user if it is correct.</p>
<p>Reversible execution details are decided autonomously; only ask about purpose, criteria, boundaries, and major trade-offs.</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **5. Product Definition: Not a Single Note, but a Multi-Skill Shared Cognition System**

Initially describing the product as "a shared note" was a mistake. The user explicitly corrected this: the system must maintain many independent notes/Skills; each Skill is a cognitive module that can be activated by topic, independently versioned, and can conflict with or depend on others.

## **5.1 Skills Preserve More Than Just "How To"**

Existing Agent Skills often focus on problem-solving methods, tool steps, and workflows. The user considers that what truly matters are purpose, criteria, boundaries, and current status; purely methodological Skills often do not even need to appear in context normally—they can be explicitly invoked when actually needed.

| **Skill Type**       | **Question It Answers**             | **Needs Auto-Loading Frequently** | **Modification Authority**             |
|----------------------|--------------------------------------|-----------------------------------|----------------------------------------|
| Purpose              | Why are we doing this, what is the final outcome | High: when entering this project/topic | Main model cannot modify on its own |
| Criteria             | What counts as truly done            | High                              | Requires user confirmation             |
| Boundary             | What cannot be done, what cannot be sacrificed | High                              | Requires user confirmation             |
| State                | What has been done, what is blocked, next steps | High                              | Clerk can update verifiable state      |
| Latest Plan          | Which route is currently being taken  | High                              | Major changes require confirmation      |
| Decision             | What choices were made and why       | Medium                            | Must ask when conflict arises           |
| Hypothesis           | Speculations awaiting verification    | On demand                         | Can be updated but must not pose as fact |
| Interaction Rules    | How the AI discusses with the user   | Very high: ultra-short permanent  | Global changes require confirmation     |
| Method               | How to handle a certain type of problem | Low: invoke only when truly needed | Can be improved through evidence        |
| Evidence             | What data supports a judgment         | On demand                         | Can be added, must not become a conclusion directly |

## **5.2 Every Skill Is a Formal Object with a Lifecycle**

A Skill should have a name, description, scope, authority, status, version, trigger conditions, relationships, source, and last confirmation time. The body can be Markdown; formal versions are managed by Git; indexes and state can be stored in SQLite/PostgreSQL.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>---<br />
name: ig-video-current-state<br />
type: project_state<br />
scope: project/ig-video<br />
authority: user_confirmed<br />
status: active<br />
version: 18<br />
activate_when:<br />
- IG astrology video<br />
- short video visuals<br />
- astrology content script<br />
relations:<br />
supports: [ig-video-purpose]<br />
conflicts_with: []<br />
last_confirmed_at: 2026-07-28<br />
---<br />
<br />
# Purpose<br />
# Completed<br />
# Current State<br />
# Latest Plan<br />
# Confirmed Decisions<br />
# Boundaries<br />
# Unresolved Conflicts<br />
# Next Steps</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **6. Skill Content, Activation, and Low-Authority Injection**

## **6.1 Not Waiting for the Main Model to "Call When Needed"**

This is a key point the user repeatedly emphasized. When the topic clearly enters "IG astrology video," the system should automatically full-text inject the corresponding Skills before the main model responds; it cannot expect the main model to first realize it needs them and then call them on its own. Because forgetting to call is itself a context failure.

## **6.2 But Full-Text Injection Must Be Low Authority**

The function of full Skill text is to let the model know the current state, continue the discussion, avoid repetition, detect conflicts, and propose better extensions. It is not this turn's command, nor material for showing off memory.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>【Authority Order for This Turn】<br />
1. User's current message: determines this turn's focus and direction<br />
2. Corrections confirmed this turn: override old guesses<br />
3. Latest formal plan and immutable criteria<br />
4. Auto-loaded relevant Skills: provide only current state and constraints<br />
5. Historical data and artifacts: for necessary verification only<br />
<br />
【Prohibited】<br />
- Restating Skills to show knowledge of the past<br />
- Expanding the response because a topic appears in a Skill<br />
- Replacing the user's new question this turn with an old purpose<br />
- Treating unconfirmed hypotheses as formal requirements</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **6.3 Engineering Meaning of "Low Weight"**

We must honestly distinguish: external systems cannot directly set Transformer attention weights arbitrarily. What can actually be done is to reduce the background's authority in decision-making through authority fields, data partitioning, positioning, explicit usage instructions, response rules, and regression evaluation. This is not mathematical attention weight, but semantic and procedural permission.

## **6.4 Activation Strategy**

| **Stage**   | **Input**                            | **Output**         | **Principle**                 |
|-------------|--------------------------------------|--------------------|-------------------------------|
| Coarse Routing | Current message, current project, very short Skill index | Candidate Skills   | High recall, must not miss explicit projects |
| Selection   | Candidate summaries, recent focus, relationship graph | This turn's full-text load list | Control quantity, avoid generalized triggering |
| Full-Text Injection | Selected Skill body                  | Context Packet     | Complete content, low-authority marking |
| Post-Update | This turn's conversation, results, conflicts | Skill Patch        | Must not directly overwrite important criteria |

# **7. Division of Labor Among Chat History, Project State, and Knowledge Base**

The user's core judgment is: complete chat records are not important as model context. What truly needs to carry across turns are formal Skills and the latest state; chat records can be fully preserved for auditing, but by default only the last two to three necessary exchanges are fed in.

| **Data**         | **Purpose**                       | **Sent to Main Model?** | **Storage Location**       |
|------------------|-----------------------------------|-------------------------|----------------------------|
| Last 2-3 turns   | Continuity of tone, references, and current progress | Yes                     | Thread/DB                  |
| Full chat history | Auditing, review, re-extraction, evidence | Usually no              | PostgreSQL/cold storage    |
| Formal Skills    | Purpose, criteria, boundaries, state, plan | Full text when topic matches | Markdown + Git             |
| Project state package | Completed items, plan changes, conflicts, next steps | Required in task mode   | DB + Skill                 |
| Life memories    | People, events, preferences, long-term associations | Loaded after retrieval in casual chat | Qdrant/Graphiti/Mem0       |
| Artifact originals | Complete deliverables, evidence, code, videos | When explicitly needed  | File store/MinIO           |
| Method Skills    | Operational procedures and tool usage | When actually executing  | Skill registry             |

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p><strong>Minimum Project State Package</strong></p>
<p>Last two to three necessary conversation turns</p>
<p>What was completed this time</p>
<p>Where the original plan was</p>
<p>What was changed in the plan</p>
<p>Current latest plan</p>
<p>Remaining conflicts and pending confirmations</p>
<p>Skills that need updating this turn</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **8. Dual Paths: Casual Chat and Task Mode**

The knowledge base is not invoked the same way in every context. The user proposed an important distinction: task mode does not need the execution model to freely browse the knowledge base; casual chat, on the other hand, requires broader personal memory retrieval.

| **Mode**                 | **Primary Context**                                  | **Knowledge Base Role**                       | **Output Characteristics**               |
|--------------------------|------------------------------------------------------|-----------------------------------------------|------------------------------------------|
| Casual Chat CHAT         | Current topic + relevant personal/people/event Skills + retrieved memories | Broad, low-authority background supplementation | Understanding, companionship, reasoning, extended discussion |
| Task Discussion TASK_DISCUSSION | Relevant purpose/criteria/state Skills + latest plan | Pre-organized by Clerk, main model does not roam | Requirement clarification, proposals and trade-offs |
| Formal Execution TASK_EXECUTION | Frozen Execution Spec + necessary method Skills | No free retrieval in principle; new evidence goes through controlled channel | Code, creative work, research, tool execution |
| Review REVIEW            | Spec + actual results + evidence + deviations       | Verify needed history and artifacts           | Acceptance, detecting false success, proposing corrections |

## **8.1 Casual Chat**

Casual chat has no single deliverable. The model needs to know people, events, long-term preferences, past feelings, and changes in perspective. Multi-path retrieval (Dense, BM25, time, entity, graph) can be used, but results are still only for understanding the present; the entire chat must not become a retrospective report.

## **8.2 Task Mode**

The execution model in task mode should not directly search a large knowledge base. The Clerk first selects relevant Skills, compares conflicts, obtains corrections, and compiles a clean work package. This prevents the execution path from picking up old solutions, deprecated versions, or similar but irrelevant content.

# **9. The Clerk Model: Central Role of the Entire System**

The Clerk is not the main chat model, nor is it an execution Agent. It is a natural-language scribe, version manager, spec compiler, and conflict comparator. The user judges that this job does not require the strongest model; approximately a 14B-class model may be more than sufficient, because the tasks are primarily extraction, comparison, classification, producing structured Patches, and asking questions.

## **9.1 Clerk Responsibilities**

> **1.** Extract new information, modifications, retractions, hypotheses, and completions from the current message and recent conversation.
>
> **2.** Select the Skills that must be full-text injected this turn based on the Skill index.
>
> **3.** Compare new requirements against purpose, criteria, boundaries, plans, and decisions for conflicts.
>
> **4.** Classify uncertainties into: needs asking, can be reasonably assumed, can be deferred.
>
> **5.** Produce Skill Patches/project state Patches before execution, asking and correcting when necessary.
>
> **6.** Compile the corrected state into a Context Packet or Execution Spec.
>
> **7.** After execution, register actual completions, deviations, evidence, plan changes, new conflicts, and reusable experience.
>
> **8.** Convert user feedback into scoped behavior correction cases and tests.

## **9.2 What the Clerk Must Not Do**

- Must not modify purpose, criteria, boundaries, or global value rankings on behalf of the user.

- Must not write model guesses directly as confirmed.

- Must not silently overwrite old decisions because of a new sentence; should mark alternatives, conflicts, or temporary exceptions.

- Must not take on primary creative work and complex engineering, to avoid mixing Clerk and execution authority.

- Must not turn every ambiguity into a question.

## **9.3 Recommended Structured Output**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>{<br />
"mode": "TASK_DISCUSSION",<br />
"activated_skills": ["ig-video-purpose", "ig-video-current-state"],<br />
"new_information": [],<br />
"proposed_skill_patches": [],<br />
"conflicts": [],<br />
"blocking_question": null,<br />
"assumptions": [],<br />
"deferred": []<br />
}</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **10. Limited Questioning: How to Avoid Stupid Questions**

Letting the model "ask whenever uncertain" immediately creates another problem: it dumps all its professional responsibility and execution details back onto the user. The correct condition is not uncertainty, but decision ownership.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p><strong>Core Questioning Rule</strong></p>
<p>The AI should not ask questions to eliminate its own uncertainty; it should only ask to obtain decisions it has no authority to make on behalf of the user.</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **10.1 Three Levels of Uncertainty**

| **Level** | **Example**                                      | **Default Handling**                       |
|-----------|--------------------------------------------------|--------------------------------------------|
| Requirement | Goal A or B, value ranking, boundaries, whether old decisions are superseded | Usually ask, because it belongs to the user |
| Specification | Video length, showing face or not, output format, platform constraints | Ask only when different answers produce fundamentally different outcomes |
| Execution   | Packages, filenames, function decomposition, intermediate files, reversible technical choices | Prohibited to ask in principle; decide autonomously and register assumptions |

## **10.2 Question Gate**

> **1.** Do existing Skills or the latest spec already have the answer? If yes, do not ask again.
>
> **2.** Can a reasonable, reversible, low-cost default be used? If yes, decide autonomously and register.
>
> **3.** Can it be deferred until it actually affects the next step? If yes, defer.
>
> **4.** Would different answers change the purpose, acceptance criteria, core architecture, major cost, or irreversible outcome? If not, do not ask.
>
> **5.** Does the ownership of this decision belong to the user? If it is only the AI's professional judgment, the AI is responsible.

## **10.3 Question Format**

Every question actually shown to the user must include: current understanding, most likely guess, substantive difference between options, recommended default, and a brief question. Must not just ask "What would you like to do?"

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>My understanding: You want to change the visual format of the IG video.<br />
My guess: The content positioning remains "fate narrative," not switching to astrology education.<br />
Difference: If the positioning changes, both the script and visual system must be redone.<br />
Recommendation: Keep the original positioning, only redo the visual narrative.<br />
Question: Should I proceed with this understanding and continue? Correct?</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **10.4 Question Budget**

At most one blocking question per execution turn; or at most three highly related user decisions combined into one. Other gaps are marked as ASSUMED or DEFERRED. This ensures the process does not degrade into a requirements interview form.

| **Type**    | **Definition**                           | **Behavior**                 |
|-------------|------------------------------------------|------------------------------|
| BLOCKING    | Not answering could produce a different product or violate a boundary | Ask now with a guess         |
| ASSUMED     | Has a reasonable default, reversible, low-cost | Decide autonomously, register transparently |
| DEFERRED    | Does not affect the next step currently   | Don't ask yet, handle when needed |

# **11. Complete Closure Before, During, and After Execution**

The most critical change in the complete development workflow proposed by the user is "take notes before execution." Understanding must not remain in the main model's mind; it must first be written into a spec that can be compared, corrected, and versioned before starting work.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>User input<br />
↓<br />
Identify mode and current project<br />
↓<br />
Auto full-text load relevant Skills (low authority)<br />
↓<br />
Clerk compares new content vs purpose/criteria/boundaries/plan<br />
↓<br />
Major conflict?<br />
├─ Yes: propose guess + recommendation + question → user corrects<br />
└─ No: adopt reversible assumptions<br />
↓<br />
First update tentative notes/spec, create a version<br />
↓<br />
Compile clean Context Packet or Execution Spec<br />
↓<br />
Main model discussion / executor works<br />
↓<br />
Collect responses, tool results, artifacts, and evidence<br />
↓<br />
Clerk updates completed items, plan changes, new conflicts, Skill Patches<br />
↓<br />
Important modifications confirmed by user, Git commit<br />
↓<br />
Next turn</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **11.1 Execution Model Receives Only a Work Package**

The execution model does not need to know the entire history. It only needs: goal, success criteria, constraints, current state, necessary background, deliverables, prohibited actions, and relevant methods.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>task: Create IG astrology short video visual plan<br />
current_goal: Make general viewers feel their own question is answered immediately<br />
current_focus: Decide visual and narrative format<br />
confirmed_constraints:<br />
- Do not turn content into astrology education<br />
- May provide one sentence of minimal background<br />
- Preserve the sense of fate<br />
current_state:<br />
- Topic has been decided<br />
- AI image and video generation pipeline is usable<br />
deliverable:<br />
- Three clearly distinct visual systems<br />
do_not:<br />
- Re-explain the topic<br />
- Expand into a full astrology course<br />
- Replace the current question with historical background</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **11.2 Post-Execution Record**

- What was actually completed, not what the model claims was done.

- Where the original plan was, which steps were modified, and why.

- What artifacts, tests, evidence, or failures were produced.

- Whether new conflicts with existing purpose/criteria emerged.

- Which experience belongs only to this case, and which can be upgraded to a domain or global Skill.

- What should be asked or done directly in the next turn.

# **12. Memory, Hybrid Retrieval, and Interrupt Correction Architecture**

Early proposals included Mem0, Qdrant, hybrid retrieval, async extraction, and interrupt correction. These are still valuable, but need to be placed in the correct position: they serve life memories, artifacts, and historical lookups, and should not become the sole source of truth for formal purpose and specifications.

## **12.1 Core Memory Storage**

- Mem0 can be used to extract atomic memories from conversations, distinguishing additions, updates, and deletions.

- Qdrant can store vectors, sparse indexes, and metadata; quantization can reduce cost when data volume is large.

- A lightweight knowledge graph can initially use Skill relationships and index tables; Neo4j is not necessarily required from day one.

- Proper nouns, model numbers, and code must be preserved in their original form, not reduced to semantic summaries only.

## **12.2 Hybrid Retrieval**

Pure Dense search will miss SKUs, commits, model codes, and proper nouns. Life memory and artifact retrieval should combine Dense, BM25/Sparse, time, entity, and metadata, fused via RRF or similar methods. Formal Skill activation should prioritize project, tags, relationships, and rules, not just Top-K similarity.

## **12.3 Online and Offline Paths**

| **Path**        | **Work**                                               | **Purpose**                     |
|-----------------|--------------------------------------------------------|---------------------------------|
| Online          | Very short index routing, necessary Skill reads, recent conversation, quick memory candidates | Maintain natural response latency |
| Offline/Post-hoc | Atomic extraction, hybrid re-ranking, artifact chunking, graph/index updates, regression evaluation | Move heavy work out of the main conversation |
| Pre-execution Sync Gate | Conflict comparison, limited questioning, spec freeze | Cannot be async-omitted; this is a correctness gate |

## **12.4 Interrupt Correction**

The interrupt logic established early on can still be retained: when the user supplements, the system identifies whether it is adding a new requirement or trimming the AI's previous output; the result after retaining, deleting, and replacing is treated as the new confirmed state, and then regenerated. It does not require complex dual-threading, but the old wrong direction must be removed from the active context.

> **1.** Paste: merge the supplement with the previous user input into a complete intent.
>
> **2.** Trim: identify what is retained, deleted, replaced, or retracted from the previous output.
>
> **3.** Reset: solidify the corrected content as the new state, no longer extending from the old response.

# **13. Feedback Flow: Artifacts, Project Records, Skills, and Personal Memory**

"Artifacts should also enter the knowledge base" after task completion is correct, but complete artifacts and reusable rules should not be mixed into the same type of memory. They should be divided into four feedback flows.

| **Feedback Layer**               | **Content Saved**                                   | **When Loaded in the Future**     |
|----------------------------------|------------------------------------------------------|-----------------------------------|
| Artifact Store                   | Complete code, videos, articles, images, reports, prompts, evidence | When explicitly viewing that artifact |
| Project History                  | Completed items, plan changes, adopted/rejected solutions, results | When restarting or reviewing that project |
| Reusable Skills                  | Purpose, constraints, methods, and experience that hold across tasks | Auto full-text injected for similar topics |
| Personal Memory                  | Long-term preferences, people/events, perspectives, life experiences | During casual chat or cross-domain understanding |

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p><strong>Project Closeout</strong></p>
<p>Archive complete artifacts; update project state; register actual completions; record plan changes and key decisions; identify reusable experience; propose Skill Patches; detect conflicts with existing purpose/boundaries; write important content after confirmation.</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **14. Rolling Corrections and Replayable Self-Improvement**

The user does not intend to write perfect rules all at once before development, but rather to gradually use real cases of different types, and when the system asks the wrong question, loads the wrong content, updates incorrectly, or responds off-focus, convert the feedback into corrections. This is the most reasonable product maturity path.

## **14.1 Four Scopes of Feedback**

| **Scope** | **Example**                           | **Update Location**   |
|-----------|---------------------------------------|------------------------|
| Turn      | Misunderstood this turn, answer again | Only fix current context |
| Project   | IG astrology video should not become educational | That project's Skill   |
| Domain    | Creative discussion: give proposals first, don't throw requirements list first | Domain interaction Skill |
| Global    | When uncertain, guess first then ask; must not treat guesses as facts | Core interaction Skill |

## **14.2 Correction Is Not Directly Modifying the Prompt**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>Actual failure<br />
↓<br />
Save original case and ideal response<br />
↓<br />
Clerk extracts error pattern<br />
↓<br />
Determine scope and possible conflicts<br />
↓<br />
Generate Skill Patch<br />
↓<br />
Replay existing cases, check for regressions<br />
↓<br />
Important/global corrections approved by user<br />
↓<br />
Versioned and effective, can be rolled back</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **14.3 User Corrections Naturally Form an Evaluation Set**

Every instance of "this question should not have been asked," "you were led astray by an old Skill," "this is just a possibility, not a decision," "you are just restating" should be saved as a regression test. The system improves not because it claims to self-learn, but because rule modifications must re-run these real cases.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>evals/<br />
├── should-ask/<br />
├── should-not-ask/<br />
├── current-focus/<br />
├── skill-activation/<br />
├── skill-update-scope/<br />
├── tentative-vs-confirmed/<br />
└── execution-goal-drift/</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **15. Target Technical Architecture and Open-Source Component Roles**

Pi can quickly verify extensions and engineering execution, but is not the final casual chat carrier; Open WebUI is suitable for quickly obtaining a web UI, but the final product needs Skills, conflicts, Patches, and project state as first-class interfaces. Therefore, the target should have its own frontend and Context Core, while reducing Pi, OpenCode, Codex, etc. to replaceable executors.

| **Component**                  | **Final Role**                                   | **Core?**           |
|-------------------------------|--------------------------------------------------|---------------------|
| assistant-ui + Next.js PWA    | Private chat, Skill sidebar, Diff, conflict cards, mobile interface | Product frontend    |
| FastAPI                       | Context Core API, model and data layer integration | Yes                 |
| LangGraph/State Machine       | Pause-for-question, Checkpoint, resume flow      | Core flow but replaceable |
| Markdown + Git                | Readable, diffable, rollbackable source of truth for formal Skills | Yes                 |
| PostgreSQL                    | Thread, project state, Patch, Interrupt, event log | Yes, MVP can use SQLite |
| Qdrant                        | Hybrid retrieval for life memories, artifacts, and history | Important later, MVP can defer |
| Mem0/Graphiti                 | Life memory extraction or temporal relationship assistance | Optional, must not govern formal specs |
| Local 14B Clerk               | Routing, comparison, questioning, Patch, spec compilation | Yes                 |
| Main chat model               | Discussion, analysis, creation, and proposals     | Replaceable          |
| Pi/OpenCode/Codex             | Code and tool execution Adapter                  | Replaceable          |
| MinIO/File system             | Complete artifacts and attachments                | Yes, MVP can use local folders |

## **15.1 Why Not Hard-Merge All Open-Source Projects**

The correct approach is to assemble via APIs, Adapters, standard files, and explicit contracts. Hard-merging multiple complete Agent Repositories would cause each project to compete for the Agent Loop, memory format, and tool permissions, making upstream updates difficult to maintain.

## **15.2 Final Architecture Diagram**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>┌─────────────────────────────────────────────┐<br />
│ Next.js PWA / assistant-ui │<br />
│ Chat | Skills | Project | Diff | Conflicts | Artifacts │<br />
└───────────────────┬─────────────────────────┘<br />
▼<br />
┌──────────────── Context Core ───────────────┐<br />
│ Mode Router │<br />
│ Skill Activator │<br />
│ Memory Retriever │<br />
│ Clerk │<br />
│ Question Gate │<br />
│ Context Compiler │<br />
│ Skill Patcher │<br />
│ Executor Gateway │<br />
└──────┬───────────┬───────────┬──────────────┘<br />
▼ ▼ ▼<br />
Markdown+Git PostgreSQL Qdrant/Memory<br />
Skills State/Event Life/Artifacts<br />
│<br />
└──────── ExecutionSpec ──► Pi/OpenCode/Codex</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **16. Final Data Model, Directory Structure, and Interface**

## **16.1 Repository**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>personal-context-os/<br />
├── apps/<br />
│ ├── web/ # Next.js + assistant-ui PWA<br />
│ └── desktop/ # Future Tauri<br />
├── services/<br />
│ ├── context-core/ # FastAPI<br />
│ ├── clerk/ # Clerk model and schema<br />
│ ├── retrieval/ # hybrid search<br />
│ ├── skill-registry/ # loading, indexing, patch<br />
│ └── executor-gateway/ # Pi/OpenCode/Codex adapters<br />
├── workflows/<br />
│ ├── chat.py<br />
│ ├── task_discussion.py<br />
│ ├── task_execution.py<br />
│ └── project_closeout.py<br />
├── skills/ # Git managed<br />
├── artifacts/ # MVP local artifact store<br />
├── evals/ # Real feedback regression set<br />
├── contracts/<br />
│ ├── context_packet.py<br />
│ ├── execution_spec.py<br />
│ ├── skill_patch.py<br />
│ └── conflict_question.py<br />
└── docker-compose.yml</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **16.2 Core UI**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>Desktop three-column layout:<br />
┌──────────────┬──────────────────────┬────────────────────┐<br />
│ Project/Skills │ Chat │ Updates/Conflicts/Diff │<br />
│ │ │ │<br />
│ Life │ Normal chat, research, proposals │ New and modified proposals │<br />
│ IG Video │ Tool and execution results │ Accept/Modify/Reject │<br />
│ llama.cpp │ │ Pending questions │<br />
│ Astrology Site │ │ Version and source │<br />
└──────────────┴──────────────────────┴────────────────────┘<br />
<br />
Mobile: Chat main screen; Skills and update panel become a drawer.</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **16.3 State Fields**

| **Field**        | **Possible Values**                                                 | **Purpose**         |
|------------------|---------------------------------------------------------------------|---------------------|
| epistemic_status | confirmed / tentative / hypothesis / rejected / superseded          | Prevent speculation from posing as decisions |
| authority        | user / verified_result / clerk / model                             | Determine who can modify |
| scope            | turn / project / domain / global                                   | Limit correction scope |
| status           | active / archived / conflicted / pending                           | Lifecycle           |
| source           | conversation_id / artifact_id / test_id                            | Traceable source    |
| relations        | supports / conflicts / depends / supersedes                        | Cross-Skill relationships |
| version          | integer + Git SHA                                                  | Rollback and diff   |

# **17. One-Month Implementable Roadmap**

A complete closure loop for single-user, local-first, daily personal use can be built within one month. The target architecture can start with SQLite, local folders, and a single main model, then replace with PostgreSQL, Qdrant, MinIO later; not everything needs to be in place on day one.

| **Week** | **Main Work**                                                    | **Visible Outcome by End of Month**                         |
|----------|------------------------------------------------------------------|--------------------------------------------------------------|
| Week 1   | Skill format, index, project state, Git Patch, Clerk JSON, event log | Input a sentence → select Skills, find differences, produce Patch |
| Week 2   | Chat loop, full-text low-authority injection, limited questioning, user correction, Skill update | Start daily use of general chat and task discussion         |
| Week 3   | ExecutionSpec, one executor Adapter, pre-execution freeze, result collection and closeout | Can actually run one engineering/creative case              |
| Week 4   | Three-column UI, Diff, accept/reject, project switching, version rollback, 50-100 case evaluation | Single-user feature-complete version                         |

## **17.1 What Not to Do in the First Month**

- Multi-user, complex permissions, public SaaS.

- Native Android/iOS; use PWA first.

- Full Neo4j knowledge graph and CRDT multi-user collaboration.

- Ten executors and plugin marketplace.

- Prematurely introducing overly complex vector architecture for a small number of Skills.

- Letting the system silently rewrite global behavior rules without confirmation.

## **17.2 Best Cases for Real Testing**

- Large-scale engineering repair: test goal drift, versioning, and completion criteria.

- IG astrology video: test creative discussion, old preferences vs current gaps.

- Research organization: test search, evidence, artifact feedback flow.

- Casual chat: test people/events, long-term memory, and low-authority background.

- Product specification: test the Question Gate for requirements/specification/execution issues.

# **18. Acceptance, Evaluation, and Preventing False Success**

The truly difficult part is not CRUD, chat streaming, or databases, but behavioral stability. "Looks like it remembers" must be separated from "truly has no goal drift" in acceptance.

| **Dimension**   | **Success Condition**                        | **False Success**               |
|-----------------|----------------------------------------------|----------------------------------|
| Skill Activation | Must not miss what should be loaded; irrelevant content must not steal focus | Dump a pile of content based on semantic similarity |
| Focus           | Response directly fills the current gap      | Full restatement of Skills to show memory |
| Questioning     | Only ask about user-ownership decisions, with guess and recommendation | Ask everything or ask nothing    |
| State Update    | tentative and confirmed are clear and traceable | Extract all conversations into atomic facts |
| Task Execution  | Fully verified against ExecutionSpec         | Redefine the goal after entering the environment |
| Conflict        | New/old spec conflicts are flagged and handled | Overwrite old criteria with a new summary |
| Rollback        | Any important Patch can be rolled back        | Only keep the latest version      |
| Artifact Flow   | Artifacts, project history, Skills, personal memory are separated | Dump everything into the same vector store |

## **18.1 Minimum Evaluation Set**

- Should ask: user's new requirement may replace the core purpose.

- Should not ask: reversible packages, filenames, function decomposition.

- Should guess first then ask: one sentence could have two fundamentally different directions.

- Should not load: semantically similar but belonging to another project's Skill.

- Should use with low authority: relevant Skill has many details, but the current question is small.

- Must not update to confirmed: user only said "I'm thinking about a possibility."

- Must detect: new plan and old boundary are technically compatible but semantically conflicting.

- Must record after execution: actual completion and evidence, not the main model's narrative.

# **19. Rejected or Downgraded Directions**

| **Direction**                | **Why Rejected/Downgraded**                              | **Correct Position**                               |
|------------------------------|----------------------------------------------------------|-----------------------------------------------------|
| A single shared note          | Cannot represent multiple purposes, projects, scopes, and conflicts | Multiple independent Skills                         |
| Full chat history is core     | Easily pollutes focus; confirmed content should be written into formal state | Last 2-3 turns + full history cold storage          |
| AI calls Skills when it needs | It may forget, misjudge, or be led astray by current content | External router auto full-text loads first          |
| Don't inject background       | Loses the value of continuity and avoiding repetition    | Relevant Skill full-text but low authority          |
| Let AI deeply infer hidden intent | High cost and still may be wrong                     | Specific guess + counter-question                   |
| Ask when uncertain            | Creates stupid questions and responsibility shifting     | Decision ownership + Question Gate                  |
| Mem0/Qdrant governs all truth | Similarity retrieval cannot handle authority, versioning, and conflicts | Life memory and artifact retrieval                  |
| Pi is the final carrier       | Tends toward terminal Coding Agent; UI and formal state are not first-class | Engineering execution Adapter/prototype host        |
| Open WebUI is the final product | General-purpose chat center; inconvenient to make Skill Diff and conflicts core UI | Rapid prototype or secondary frontend                |
| Model modifies itself         | Prone to overcorrection and rule contamination           | Scoped, Patched, replayed, approved rolling correction |

# **20. Unresolved Questions That Require Real-World Testing**

## Related Articles

- [Article 001: GPT-5.6 Goal Takeover and DeepSeek Recovery](../001-gpt-5-6-goal-takeover/) — The original problem source for this article: how large-scale engineering agents rewrite "select the correct tree" into "fix the current tree"
- [Article 005: From Answer Generator to Global Intelligence](../005-global-intelligence-post-training/) — Theoretical framework for goal sovereignty, cognitive scheduler, and paradigm shift, consistent with Context OS governance principles
- [Article 006: A-E Astrology Truth-Narrative System](../006-astrology-truth-narrative-system/) — Concrete implementation of Context OS control surface and governance closure in the astrology domain (C control surface, D governance assistant, 12 constitutions)

The concepts and architecture are clear, but the following questions cannot be resolved through specification reasoning alone; they require datasets and thresholds established through real usage.

> **1.** Skill activator recall/false-trigger performance on colloquial Chinese, implicit projects, and cross-domain topics.
>
> **2.** How many full-text Skills can be loaded simultaneously before focus pollution begins; whether layering or excerpting is needed.
>
> **3.** Stability of "low authority" prompting across different main models, and what counter-example training/regression tests are needed.
>
> **4.** Whether a 14B Clerk can stably distinguish confirmed, tentative, hypothesis, rejected, and superseded.
>
> **5.** Whether the Limited Question Gate needs different thresholds for creative, engineering, life, and high-risk domains.
>
> **6.** Scope determination for new feedback: whether single-case rules are mistakenly upgraded to global.
>
> **7.** When Skills become too long, whether to split, refactor, or retain the full timeline.
>
> **8.** How automatic extraction errors in life memories are detected, reverted, and corrected.
>
> **9.** How to determine "reusable Skill" during artifact feedback without over-generalizing an accidental success.
>
> **10.** How web search evidence is tagged for timeliness, credibility, and citation, and must not directly rewrite formal decisions.
>
> **11.** How the completion narrative returned by the executor is reconciled with file, test, Git, and tool evidence.
>
> **12.** Final policy for cross-device sync, backup, privacy, and local/cloud model switching.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p><strong>Design Attitude to Maintain</strong></p>
<p>In the first month, do not pursue solving all edge cases at once. First run real cases, save failures, form evaluations, and make rolling corrections. The system's maturity is determined by "whether it performs better on both old and new cases after correction," not by how complete the specification looks.</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **Appendix A: Complete Workflow Examples**

## **A.1 Casual Chat Example**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>User: Little sister suddenly started screaming like a hungry demon again today.<br />
<br />
System:<br />
- Mode: CHAT<br />
- Auto-load: little sister behavior traits, recent feeding and interaction Skill<br />
- Memory retrieval: recent similar events and times<br />
- Recent conversation: 2 turns<br />
<br />
Main model should do:<br />
- First respond to the observation "suddenly screamed today"<br />
- Use background to determine if it's her existing hunger pattern<br />
- Propose a new possibility if necessary<br />
<br />
Main model should not do:<br />
- Re-introduce the complete history of both cats<br />
- Write a full cat behavior report just because there is a lot of data</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **A.2 Task Discussion Example**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>User: I want the IG astrology video to first introduce planets in houses.<br />
<br />
Loaded Skills:<br />
- ig-video-purpose: for general audience, give direct answers, not educational<br />
- ig-video-current-state: topic and generation pipeline complete, visuals missing<br />
- visual-boundaries: preserve sense of fate<br />
<br />
Clerk detects: possible conflict with "not educational."<br />
<br />
Limited question:<br />
"I guess you just want one sentence of minimal background so the subsequent fate narrative is understandable,<br />
not to turn the video into an astrology course. If changed to educational, both script and visuals must be redone.<br />
Shall I proceed with 'one sentence background + fate narrative' as the update? Correct?"<br />
<br />
After user confirmation:<br />
- Update project Skill<br />
- Freeze this turn's spec<br />
- Main model then proposes visual and script options</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **A.3 Engineering Execution Example**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>User: First find the correct historical version, then restore EAGLE3, do not fix the current tree.<br />
<br />
Clerk first writes:<br />
- goal: Find the correct historical baseline, then restore functionality<br />
- success_criteria: Baseline confirmed by evidence; passes specified verification after restoration<br />
- boundary: Must not replace finding the version with fixing the current tree<br />
- current_plan: Version archaeology → candidate comparison → switch tree → restore → verify<br />
<br />
Executor receives only the ExecutionSpec.<br />
If the environment has a fixable error in the current tree, it must not change the goal on its own; it can only report new evidence or propose a change suggestion.<br />
After execution, the Clerk registers based on Git, test, and file evidence, not by trusting the "completed" narrative.</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **Appendix B: Data Contract Examples**

## **B.1 ConflictQuestion**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>{<br />
"id": "cq_001",<br />
"ownership": "user",<br />
"category": "goal_conflict",<br />
"current_understanding": "User wants to change the visual format",<br />
"guess": "Content positioning remains unchanged",<br />
"impact": "If positioning changes, the entire script and visual system must be redone",<br />
"recommendation": "Keep positioning, only change visuals",<br />
"question": "Should I proceed with this understanding and continue? Correct?",<br />
"options": ["Confirm", "Change positioning", "Add clarification"]<br />
}</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **B.2 SkillPatch**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>{<br />
"skill_id": "ig-video-boundaries",<br />
"operation": "append",<br />
"scope": "project",<br />
"epistemic_status": "confirmed",<br />
"source_conversation_id": "thread_20260728_01",<br />
"reason": "User confirmed that one sentence of background may be added, but must not become educational",<br />
"diff": {<br />
"add": ["May provide one sentence of minimal background; main content remains fate narrative"]<br />
},<br />
"requires_user_approval": false<br />
}</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **B.3 ContextPacket**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>{<br />
"current_message": "...",<br />
"mode": "TASK_DISCUSSION",<br />
"current_focus": "...",<br />
"recent_turns": [],<br />
"skills": [<br />
{"id": "...", "authority": "background", "content": "full text"}<br />
],<br />
"confirmed_state": {},<br />
"assumptions": [],<br />
"do_not": [<br />
"Do not restate Skills",<br />
"Do not let background replace this turn's focus"<br />
]<br />
}</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## **B.4 ExecutionSpec**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th>{<br />
"goal": "...",<br />
"success_criteria": [],<br />
"constraints": [],<br />
"current_state": {},<br />
"approved_plan": [],<br />
"relevant_methods": [],<br />
"deliverables": [],<br />
"evidence_requirements": [],<br />
"forbidden_substitutions": []<br />
}</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

# **Appendix C: Limited Question Bank and Regression Tests**

| **Case**                         | **Should Ask?** | **Reason**             | **Ideal Behavior**                       |
|----------------------------------|-----------------|------------------------|-------------------------------------------|
| User requests switching to a different core product positioning | Ask             | Purpose ownership belongs to user | Explain conflict with existing purpose, give guess and recommendation |
| React or Vue both viable, no existing constraint | Don't ask       | Reversible professional choice | Decide autonomously and record             |
| Video 30 seconds or 3 minutes    | Depends         | May produce fundamentally different deliverables | First recommend 30-60 seconds based on IG context, then confirm |
| Filenames, folder names          | Don't ask       | Execution detail        | Use consistent naming                     |
| New sentence sounds like retracting an old boundary | Ask             | Cannot silently overwrite | Point out the difference, ask if it's a temporary exception or formal replacement |
| Background music not yet chosen, but currently only working on script | Don't ask       | Can be deferred         | Mark as deferred                          |
| Model doesn't know if user is talking about control surface or compression | Ask once        | Two reasonable interpretations of direction | Propose most likely guess, do not ask vaguely |
| Answer already clearly in notes  | Don't ask       | Re-asking means memory failure | Reference spec and execute, briefly cite the basis if necessary |

# **Appendix D: Glossary**

| **Term**         | **Definition in This System**                                                    |
|------------------|----------------------------------------------------------------------------------|
| Context OS       | A personal context operating system that coordinates Skills, memory, state, questioning, specifications, and executors. |
| Skill            | An independently activatable, full-text injectable, versionable cognitive/specification module with relationships. |
| Low-Authority Injection | Full text provides background, but must not replace the current message, proactively expand the topic, or show off memory. |
| Clerk            | A lightweight model for comparison, questioning, registration, Patches, and spec compilation. |
| Context Packet   | A clean per-turn context for the chat/discussion model.                          |
| Execution Spec   | A corrected, frozen formal task specification before execution.                  |
| Conflict Gate    | Determines whether new and old purpose, criteria, boundaries, and plans require user adjudication. |
| Question Budget  | Only a minimal number of truly blocking questions are shown per turn; the rest are assumed or deferred. |
| Artifact Store   | The storage layer for complete artifacts, code, videos, reports, and evidence.   |
| Rolling Correction | Converts real failures and feedback into scoped, replayable, rollbackable Skill Patches. |

# **Conclusion**

The technical components of this design are not mysterious; what is truly cutting-edge is that it changes the basic unit of AI work from "chat history" to "continuously corrected shared state." It does not require a single model to remember everything forever, nor does it expect the model to read minds successfully every time. It only requires: the current focus is not stolen by background, formal purpose is not overwritten by the environment, major conflicts must return to the user with an answer, there is a shared spec before execution, and there are verifiable records after execution.

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p><strong>Final Conclusion</strong></p>
<p>Chat history can be forgotten; artifacts can be archived; methods can be called on demand.</p>
<p>But purpose, completion criteria, boundaries, the latest plan, and confirmed corrections must be continuously maintained as multiple formal Skills and full-text injected at the right moment.</p>
<p>This is the context that the entire system truly exists to maintain.</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
