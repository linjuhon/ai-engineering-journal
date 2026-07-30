[← 回到文章總覽](../README.md)

---

# 個人上下文作業系統（Personal Context OS）

**English title:** *Personal Context OS*

> **一句話定位：** Not longer chat history — multiple independent Skills, a Clerk model, conflict gates, and execution specs that keep your AI assistant focused on what actually matters. / 不是更長的聊天歷史——而是多個可獨立維護的 Skills、一個紀事員模型、衝突處理機制、執行前凍結的規格書，讓你的 AI 助理永遠記得什麼才是真正重要的。

---

## 初衷 / Why

**English:**

This article exists because current AI assistants have a fundamental memory problem. They forget your goals. They get distracted by old conversations. They silently change your task. They repeat what you already know. And there is no good way to fix this — because the problem is not "the chat history is too short." The problem is "the chat history is the wrong data structure."

I wrote this article to define a better way: instead of saving longer conversations, save structured, updateable pieces of context that are automatically injected when needed.

**中文：**

這篇文章存在，是因為現在的 AI 助理有一個根本的記憶問題。它們會忘記你的目標、被舊對話干擾、偷偷換掉你的任務、重複你已經知道的事。而且沒有好的方法可以解決——因為問題不是「聊天歷史太短」，問題是「聊天歷史本身就是錯誤的資料結構」。

我寫這篇文章，是為了定義一個更好的方式：與其保存更長的對話，不如保存結構化、可更新、需要時自動注入的上下文片段。

---

## 初衷的由來 / Origin

**English:**

Article 001 (the GPT-5.6 goal takeover case) exposed a painful truth: when a model enters a codebase, it gets overwhelmed by the current environment. It sees error messages, test failures, configuration files — and it forgets the original goal. The environment rules override the user's goal.

I realized that the solution is not to give the model a better memory. The solution is to change the architecture: separate the goal-keeper from the task-doer. Give the goal-keeper its own model (the Clerk) and its own data structure (Skills). Make the goal-keeper responsible for maintaining purpose, standards, and boundaries — not the main chat model.

**中文：**

第 1 篇文章（GPT-5.6 目標接管案例）暴露了一個痛苦的事實：當模型進入一個程式碼倉庫時，它會被當前的環境淹沒。它看到錯誤訊息、測試失敗、設定檔——然後它就忘了原來的目標。環境規則覆蓋了使用者的目標。

我意識到，解決方案不是給模型更好的記憶。解決方案是改變架構：把「負責記目標的人」和「負責做事的人」分開。給記目標的人一個專屬的模型（紀事員）和專屬的資料結構（Skills）。讓紀事員負責維護目的、標準和底線——而不是讓主要聊天模型來做這件事。

---

## 實戰成績 / Results

**English:**

- Complete product specification: 10 types of Skills, Clerk model design, Context Packet format, Execution Spec format, conflict detection, limited questioning rules
- 4 appendices with full process examples, data contracts, question bank, and glossary
- A 1-month MVP roadmap
- The design is model-agnostic: the chat frontend, main model, and executor are all replaceable

**中文：**

- 完整的產品規格：10 種 Skills、紀事員模型設計、Context Packet 格式、Execution Spec 格式、衝突偵測、有限提問規則
- 4 個附錄，包含完整流程範例、資料契約、問題庫、詞彙表
- 一個月的 MVP 路線圖
- 這個設計與模型無關：聊天前端、主要模型、執行程式都可以更換

---

## 可造成的結果 / Impact

**English:**

If fully implemented, this system changes the fundamental unit of AI interaction from "chat history" to "continuously updated shared state." The AI no longer needs to remember everything. It just needs to see the right context at the right time. And when something goes wrong, there is a structured record of what was agreed, what was done, and what changed.

**中文：**

如果完全實作，這個系統會把 AI 互動的基本單位從「聊天歷史」改成「持續更新的共同狀態」。AI 不再需要記得所有事情。它只需要在對的時間看到對的資訊。而且當出錯時，有結構化的紀錄可以追溯：當初同意了什麼、做了什麼、什麼改變了。

---

## 理想與抱負 / Vision

**English:**

I do not need the model to remember everything forever. I need it to see the right information at the right time, not get distracted by the environment, agree on a plan before executing, and leave a record after execution that I can check. This article represents that vision.

**中文：**

我不需要模型永遠記得所有事情。我只需要它在對的時間看到對的資訊、不被環境干擾、執行前大家有共識、執行後有紀錄可以檢查。這篇文章代表這個願景。

---

**版本：** 2026-07-30
