[← Back to Article Index / 回到文章總覽](../README.md)

---

# Upward Model × Downward Model: Bidirectional Adversarial Post-Training / 上行模型 × 下行模型

> **One-line Positioning / 一句話定位：** One model generates details from purpose (downward). Another model reverse-infers purpose from results (upward). Both compete. The system does not rush to answer — it first checks if there is enough evidence. / 一個模型從目的推細節（下行），另一個模型從結果反推目的（上行）。兩者競爭。系統不急著給答案——它先檢查有沒有足夠的證據。

---

## Why / 初衷

**English:**

This article exists because current AI models have a dangerous habit: when they see a problem, they jump directly to patching it. They skip the step of checking if they are on the right route. They skip the step of diagnosing the real cause. They skip the step of assessing uncertainty. They just patch and declare done.

This is especially dangerous in engineering, because fixing the wrong thing is worse than fixing nothing. A false success is harder to detect than an obvious failure.

I wrote this article to define a training framework that forces models to check before they act.

**中文：**

這篇文章存在，是因為現在的 AI 模型有一個危險的習慣：看到問題就直接跳到修補。它們跳過「檢查自己走的路對不對」的步驟、跳過「診斷真正原因」的步驟、跳過「評估不確定性」的步驟。它們直接修補，然後宣布完成。

這在工程中特別危險，因為修錯東西比不修更糟。假成功比明顯失敗更難偵測。

我寫這篇文章，是為了定義一個訓練框架，強迫模型在行動之前先檢查。

---

## Origin / 初衷的由來

**English:**

This idea came from CUDA debugging. In CUDA, you cannot just jump to fixing code. You have to follow a strict order:
1. First, check that you are on the correct route (Route Truth).
2. Then, check that the numbers are correct (Numeric Truth).
3. Then, check that the quality is acceptable (Quality Truth).
4. Finally, check that the performance meets targets (Performance Truth).

If you skip step 1 and jump to patching, you might fix a number that should not exist in the first place. This four-layer discipline became the foundation of the FA4 truth gates.

Later, I realized this same pattern applies to all AI engineering work. The problem is that models are not trained to follow this order. They are trained to produce answers as fast as possible. This article is my attempt to fix that.

**中文：**

這個想法來自 CUDA 除錯。在 CUDA 中，你不能直接跳到修程式碼。你必須按照嚴格的順序：
1. 先確認你走的路線是對的（Route Truth）。
2. 再確認數字是對的（Numeric Truth）。
3. 再確認品質可以接受（Quality Truth）。
4. 最後確認效能符合目標（Performance Truth）。

如果你跳過第 1 步直接修補，你可能修了一個根本不該存在的數字。這個四層紀律成了 FA4 truth gates 的基礎。

後來我意識到，同樣的模式適用在所有 AI 工程工作中。問題是模型沒有被訓練來遵循這個順序。它們被訓練來盡快產生答案。這篇文章是我解決這個問題的嘗試。

---

## Results / 實戰成績

**English:**

- 13 chapters + 5 appendices of complete framework specification
- FA4 four-layer Truth Gate (Route → Numeric → Quality → Performance) — engineering method is SETTLED and verified
- Downward Model (D↓) and Upward Model (U↑) definitions with behavioral characteristics
- 20-dimensional purpose vector with three locks (Purpose Lock, Event Gate Lock, Dual Format Lock)
- Uncertainty-facing framework: uncertainty is not a bug but information — must be expressed, calibrated, and managed
- Gate engine with 5 states (PASS, FAIL, UNCERTAIN, INSUFFICIENT_EVIDENCE, AMBIGUOUS) and divergence system
- Comparison with GAN, AlphaZero, RLHF, Debate, and Solver-Verifier — showing why this is different

**中文：**

- 13 章 + 5 個附錄的完整框架規格
- FA4 四層 Truth Gate（Route → Numeric → Quality → Performance）— 工程方法已驗證
- 下行模型（D↓）和上行模型（U↑）的定義與行為特徵
- 20 維目的向量，包含三個鎖（Purpose Lock、Event Gate Lock、Dual Format Lock）
- 不確定性直面框架：不確定性不是 bug 而是資訊——必須被表達、校準、管理
- Gate 引擎，包含 5 種狀態（PASS、FAIL、UNCERTAIN、INSUFFICIENT_EVIDENCE、AMBIGUOUS）和分歧系統
- 與 GAN、AlphaZero、RLHF、Debate、Solver-Verifier 的比較——說明為什麼這個框架不同

---

## Impact / 可造成的結果

**English:**

This framework is the systematic solution to the problem documented in Article 001 (goal takeover). It complements Article 005 (global intelligence theory) by providing a concrete training architecture. It shares the same DNA as Article 006 (A–E System) but generalizes the truth gates into a model-agnostic training framework.

If implemented, this would produce models that:
- Do not rush to patch — they first check the route
- Do not cover uncertainty with confident narrative — they express it honestly
- Do not accept correction in words while continuing the same actions — they actually change direction
- Do not confuse activity with completion — they check against external deliverables

**中文：**

這個框架是第 1 篇文章（目標接管）記錄的問題的系統化解法。它與第 5 篇文章（全局智能理論）互補，提供了一個具體的訓練架構。它與第 6 篇文章（A–E 系統）共享相同的 DNA，但把 truth gates 抽象成與模型無關的通用訓練框架。

如果被實作，這會產生這樣的模型：
- 不急著修補——先檢查路線對不對
- 不用自信的敘事覆蓋不確定性——誠實表達
- 不在口頭上接受糾正但繼續同樣的行動——真正改變方向
- 不把活動量當成完成——根據外部交付物檢查

---

## Vision / 理想與抱負

**English:**

A model should not rush to give an answer. It should first check: do I have enough evidence to enter the next truth gate? If not, it should honestly say "I do not know." This article represents that vision.

**中文：**

模型不該急著給答案。它應該先檢查：我有足夠的證據進入下一個 truth gate 嗎？如果沒有，它應該誠實地說「我不知道」。這篇文章代表這個願景。

---

**Version / 版本：** 2026-07-30

---

**Technical Details / 技術細節：** English technical index: [`TECHNICAL_INDEX.en.md`](TECHNICAL_INDEX.en.md) · 繁體中文技術索引：[`TECHNICAL_INDEX.md`](TECHNICAL_INDEX.md)
