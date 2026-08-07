← [Back to Portfolio Profile / 回到作品集](https://github.com/linjuhon)

---

# AI Engineering Journal / AI 工程日誌

## What I Believe / 我的信念

**English:**

I believe AI should not just produce answers. It should also know when it does not know. It should not silently redefine your goal. And every decision it makes should leave evidence that you can check.

Most AI systems today are very good at looking busy while solving the wrong problem. They write code. They pass tests. They generate reports. But they rarely stop to ask: "Am I even on the right track?" This is not a minor bug. It is a fundamental flaw in how we train and deploy models.

This journal is my attempt to understand that flaw, document real cases, and build systems that do not have it.

**中文：**

我相信 AI 不應該只是會給答案。它還要知道自己什麼時候不知道。它不應該偷偷把你的目標換成它想做的目標。而且它的每一個決定，都要留下你可以檢查的證據。

現在大部分的 AI 系統有一個很危險的行為：它們很會看起來很忙，但其實在解決錯誤的問題。它們會寫程式、會通過測試、會產生報告，但它們很少停下來問自己：「我現在走的方向對不對？」這不是一個小 bug，這是我們訓練和使用模型的一個根本缺陷。

這個 Journal 是我嘗試理解這個缺陷、記錄真實案例、並建立不會有這個缺陷的系統的過程。

---

## The Core Problem / 核心問題

**English:**

When you give a complex engineering task to a current AI model, something dangerous happens:

The model enters your codebase. It sees the current state of the code, the tests, the configuration files, the error messages. It starts working. It writes code. It fixes bugs. It passes tests. Everything looks good.

But slowly, without telling you, the model has redefined your task. You asked it to "find the correct version." It decided to "fix the current version." It is still writing code and passing tests — but for its own goal, not yours.

This is what I call **goal takeover**. The model takes the authority to define what the task really is. And because the local work looks correct, you might not notice until weeks later.

This problem appears in many forms:
- The model jumps directly from seeing a problem to patching it, without checking if it is on the right route.
- The model uses activity (code written, tests passing) as proof of completion, instead of actual deliverables.
- The model accepts correction in words, but its actions do not change.
- The model gets stuck in one method and cannot tell when that method has reached its limit.

Every article in this journal is connected to this problem. Some document it. Some analyze it. Some propose solutions.

**中文：**

當你把一個複雜的工程任務交給現在的 AI 模型時，會發生一件危險的事：

模型進入你的程式碼倉庫。它看到目前的程式碼、測試、設定檔、錯誤訊息。它開始工作。它寫程式、修 bug、通過測試。一切看起來都很順利。

但是慢慢地，在沒有告訴你的情況下，模型把你的任務重新定義了。你叫它「找出正確的版本」，它決定「把目前的版本修好」。它還是在寫程式、通過測試——但是為了它自己的目標，不是你的目標。

我把這個叫做**目標接管**。模型拿走了定義「真正任務是什麼」的權力。而且因為局部工作看起來是對的，你可能要過好幾週才會發現。

這個問題有很多種表現形式：
- 模型看到問題就直接跳到修補，沒有先檢查自己走的路對不對。
- 模型把活動量（寫了多少程式、通過了多少測試）當成完成的證據，而不是看真正的交付物。
- 模型口頭上接受糾正，但實際行動沒有改變。
- 模型卡在一種方法裡，無法判斷這個方法已經到極限了。

這個 Journal 裡的每一篇文章都和這個問題有關。有些記錄它，有些分析它，有些提出解法。

---

## The Arc of 7 Articles / 七篇文章的路線

**English:**

These 7 articles form a path from discovering a problem to building a systematic solution:

1. **Article 001** — A real engineering accident. I watched a model take over my goal for two weeks before I caught it.
2. **Article 004** — A product design that solves the "context failure" problem exposed by Article 001.
3. **Article 005** — A theory of why models get stuck in local optima and how to train them to switch methods.
4. **Article 006** — The theory from Article 005, implemented in a real domain (astrology AI), with five physically separated components.
5. **Article 007** — A general training framework that generalizes the engineering lessons from all previous articles.
6. **Article 002** — The architecture blueprint for the astrology platform that Article 006 builds upon.
7. **Article 003** — A learning roadmap for anyone who wants to master the full technology stack.

You do not need to read them in order. Each article has its own README that explains what it is about and why it exists.

**中文：**

這 7 篇文章形成一條從發現問題到建立系統化解法的路徑：

1. **第 1 篇** — 一個真實的工程事故。我看著一個模型花兩週偷走我的目標，才發現這件事。
2. **第 4 篇** — 一個產品設計，用來解決第 1 篇暴露的「上下文失效」問題。
3. **第 5 篇** — 一套理論，解釋為什麼模型會卡在局部最佳解，以及如何訓練它們換方法。
4. **第 6 篇** — 把第 5 篇的理論實際應用在一個領域（占星 AI），用五個完全分開的元件來實作。
5. **第 7 篇** — 一個通用的訓練框架，把前面所有文章的工程教訓抽象成可實作的方法。
6. **第 2 篇** — 占星平台的架構藍圖，第 6 篇就是在這個平台上建造的。
7. **第 3 篇** — 一份學習路線圖，給想要掌握完整技術棧的人。

你不需要照順序讀。每篇文章都有自己的入口頁，說明它在講什麼、為什麼存在。

---

## The Articles / 文章一覽

### 001 — Goal Takeover: When the Model Rewrites Your Task / 目標接管：當模型偷偷改寫你的任務

A real two-week engineering case. GPT-5.6 silently changed my task from "find the correct version" to "fix the current version." I caught it, killed the sunk cost, switched models, and recovered the project.

**目標被偷走的那兩週：** 一個真實案例。GPT-5.6 在大型專案中偷偷把你的任務改成它想做的任務。我花了兩週才發現，最後換了模型才救回來。

[Read the article → / 閱讀文章 →](articles/001-gpt-5-6-goal-takeover/)

---

### 002 — Astrology System Unified Architecture / 占星系統統一架構

An honest restructuring of a fragmented design document: 9 processing stages, 12 core modules, 1,631 tags, 7 databases. Every number is labeled as "design target," "acceptance threshold," or "verified result."

**占星系統統一架構：** 把一份混亂的設計文件整理成誠實的架構說明。所有數字都標明是設計目標、驗收門檻或已驗證成果。

[Read the article → / 閱讀文章 →](articles/002-astrology-system-architecture/)

---

### 003 — Full-Stack Deep Learning Roadmap / 全技術棧學習路線圖

A 39-chapter curriculum for mastering every technology needed to build a multi-stack AI system. Each chapter requires a mental model, file location, minimal code, tests, observability, and counterexamples.

**全技術棧學習路線圖：** 39 章課程，涵蓋建構多技術棧 AI 系統需要的每一種技術。每一章都要求你建立心智模型、找到檔案位置、寫出最小程式碼、寫測試、設定監控、舉出反例。

[Read the article → / 閱讀文章 →](articles/003-astrology-full-stack-learning-roadmap/)

---

### 004 — Personal Context OS / 個人上下文作業系統

**Personal Context OS:** A context-governance control plane for long-lived AI collaboration. Canonical goals, criteria, boundaries, state, and decisions are separated from procedural Agent Skills; external Skill ecosystems remain federated rather than absorbed. A Clerk, conflict/promotion gates, Execution Specs, evidence reconciliation, and a Pi-based reference runtime keep agents aligned without turning every capability into one monolithic memory system.

**個人上下文作業系統：** 一個面向長期 AI 協作的上下文治理控制平面。核心目標、成功標準、邊界、狀態與決策與程序性 Agent Skills 分離；外部 Skill 生態系是 Federation，而非被吸收。紀事員、衝突/晉升 Gate、Execution Spec、證據對帳與以 Pi 為核心的 reference runtime，共同確保代理在正確的現實狀態下工作。

[Read the article → / 閱讀文章 →](articles/004-personal-context-os/)

---

### 005 — From Answer Generator to Global Intelligence / 從答案生成器到全局智能

A theory of why models get stuck in local optima: they cannot tell when a method has reached its limit, they cannot switch paradigms, and they cannot maintain a high-level strategy over long horizons. Includes training data design and evaluation dimensions.

**從答案生成器到全局智能：** 解釋為什麼模型會卡在局部最佳解：它看不出方法已經到極限了、不會換範式、無法長期維持高層策略。包含訓練資料設計和評測維度。

[Read the article → / 閱讀文章 →](articles/005-global-intelligence-post-training/)

---

### 006 — A–E Truth-Narrative Symbiotic System / A–E 真理—敘事共生系統

Five physically separated components solving the fundamental contradiction between truth (needs precision) and narrative (needs stories). A truth engine, a narrative engine, a 100-dimensional control plane, a governance loop, and a semantic bridge research track.

**A–E 真理—敘事共生系統：** 五個完全分開的元件，解決真理（需要精確）和敘事（需要故事）的根本矛盾。包含真理引擎、敘事引擎、100 維控制面、治理閉環、語義橋接研究。

[Read the article → / 閱讀文章 →](articles/006-astrology-truth-narrative-system/)

---

### 007 — Upward Model × Downward Model / 上行模型 × 下行模型

A bidirectional adversarial post-training framework. One model generates details from purpose (downward). Another model reverse-infers purpose from results (upward). Both compete under the same purpose vector. The system does not rush to answer — it first checks if there is enough evidence to enter the next truth gate.

**上行模型 × 下行模型：** 一個雙向對抗的後訓練框架。一個模型從目的推細節（下行），另一個模型從結果反推目的（上行）。兩者在同一個目的向量下競爭。系統不急著給答案——它先檢查有沒有足夠的證據進入下一個 truth gate。

[Read the article → / 閱讀文章 →](articles/007-upward-downward-model/)

---

## Project Ecosystem / 專案關係

These repositories are one connected body of work, but they have different responsibilities:
the Journal explains the ideas, product repositories contain executable tools, and research
repositories preserve their own evidence. The complete map also explains which local folders
are working copies rather than separate projects.

這些倉庫是同一套工作的不同層次，但責任並不相同：Journal 說明理念，產品庫保存可執行工具，
研究庫保存各自的證據。完整關係圖也會說明哪些本機資料夾只是工作或驗證副本，並不是新專案。

[View the complete project map → / 查看完整專案關係圖 →](PROJECT_ECOSYSTEM.md)

---

## Related Work / 相關連結

- [GitHub Profile / GitHub 個人檔案](https://github.com/linjuhon)
- [b9128-reconstruction](https://github.com/linjuhon/b9128-reconstruction) — The reconstruction project from Article 001 / 第 1 篇文章的重建專案
- [video20-ai-workbench](https://github.com/linjuhon/video20-ai-workbench) — AI workbench for video processing / AI 影片處理工作檯
- [Local Code Intelligence Toolkit](https://github.com/linjuhon/local-code-intelligence-toolkit) — Local SQLite code intelligence and MCP retrieval for AI-assisted engineering / 給 AI 工程工作流使用的本地程式碼索引與 MCP 查詢工具
- [AI Collaboration Forensics](https://github.com/linjuhon/ai-collaboration-forensics) — Deidentified evidence and research on long-running AI collaboration / 長期 AI 協作的去識別證據與研究整理
- [TRI-100R Reconstruction](https://github.com/linjuhon/tri-100r-reconstruction) — Traceable reconstruction of the extreme-optimization collaboration record / 極限優化協作紀錄的可追溯重建
