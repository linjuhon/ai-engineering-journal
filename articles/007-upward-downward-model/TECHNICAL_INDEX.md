[← 回到文章入口](README.md) | [English](TECHNICAL_INDEX.en.md) | **繁體中文**

---

# 上行模型 × 下行模型：反向抽象後訓練與不確定性直面框架

> **文章類型：** AI Training Architecture / Bidirectional Adversarial Post-Training
> **成熟度：** PROVISIONAL（工程 truth gates 已驗證；雙向對抗訓練框架尚未實作）
> **版本：** 2026-07-30
> **對應 Articles：** 001（工程案例）、005（全局智能理論）、006（A–E 施工規格）

---

## 問題定義

現有 AI 系統有一個根本的行為缺陷：**模型太容易從細節直接跳到 patch，跳過 route verification、跳過因果診斷、跳過不確定性評估。**

典型行為鏈：看到可疑程式碼 → 往下猜 root cause → patch → 用漂亮敘事覆蓋不確定性 → 宣稱完成。

這在工程場景中尤其危險：修錯路線比不修更糟，假成功比明顯失敗更難偵測。

---

## 一句話核心架構

> **一個模型負責從目的往下生成細節（下行模型 D↓）；另一個模型負責從結果、細節、報告、軌跡往上反推目的、契約、gate 與因果鏈（上行模型 U↑）。兩者都產生答案，並在同一個目的向量下競爭、互補、重組、回訓。**

---

## 四層架構

| 層 | 內容 | 成熟度 |
|----|------|--------|
| **工程方法** | FA4 四層 Truth Gate：Route → Numeric → Quality → Performance | SETTLED |
| **模型行為** | 下行模型 D↓ vs 上行模型 U↑ | PROVISIONAL |
| **訓練框架** | 目的鎖定雙向對抗後訓練 | PROVISIONAL |
| **不確定性** | 不確定性直面框架：辨識、表達、校準、管理 | PROVISIONAL |

---

## 與現有 Articles 的關係

| Article | 關係 |
|---------|------|
| **001** | 007 的「上行模型審計 claim、抓假成功」正是 001 案例（GPT-5.6 目標接管）的系統化解法 |
| **005** | 005 提出「全局智能」理論框架；007 是更具體的雙向對抗後訓練架構，兩者互補 |
| **006** | 006 的 A–E 系統（C 控制面、D 治理閉環、truth gates）與 007 的工程 truth gates 共享相同 DNA，但 007 抽象成通用框架 |

---

## 章節目錄

| 章節 | 內容 | 成熟度 |
|------|------|--------|
| [01 — 核心論點](01-core-thesis.md) | 一句話總綱、核心矛盾、四層解法 | SETTLED |
| [02 — 工程起源](02-engineering-origin.md) | FA4 四層 Truth Gate 的完整定義 | SETTLED |
| [03 — Agent 失效分析](03-agent-failure-analysis.md) | 為什麼 agent 失控、premature patch 模式 | SETTLED |
| [04 — S 賽道與 Route Lock](04-s-track-and-route-lock.md) | S 賽道、Route Lock、State Lock、Reference Contract | SETTLED |
| [05 — 下行模型與上行模型](05-upward-downward-model.md) | D↓ 與 U↑ 的定義、行為特徵、與 planner/executor 的差異 | PROVISIONAL |
| [06 — 真正對抗式雙模型](06-adversarial-training.md) | 不是 solver-verifier，是雙向對抗 | PROVISIONAL |
| [07 — 目的向量與三層鎖](07-purpose-vector-and-scoring.md) | 20 維 purpose vector、Purpose/Event Gate/Dual Format Lock | PROVISIONAL |
| [08 — 反向題目設計](08-problem-design.md) | 工程上行題型、工單生成、反向資料庫、軌跡反編譯 | PROVISIONAL |
| [09 — 不確定性直面框架](09-uncertainty-framework.md) | 信心校準、不確定性來源分類、校準獎懲 | PROVISIONAL |
| [10 — Gate Engine](10-gate-engine.md) | Gate 狀態、分歧系統、證據系統、Claim-Evidence 綁定 | PROVISIONAL |
| [11 — 訓練目標](11-training-objectives.md) | 校準、分歧分類、不確定性歸因、訓練順序、人類抽樣 | PROVISIONAL |
| [12 — 與現有框架的對比](12-comparison-with-existing.md) | GAN/AlphaZero/RLHF/Debate/Solver-Verifier 差異分析 | SETTLED |
| [13 — 實作路線圖與限制](13-roadmap-and-limitations.md) | 6 階段路線圖、永動機問題、已知風險 | PENDING_EXPERIMENT |

### 附錄

| 附錄 | 內容 |
|------|------|
| [A — Gate Specs](appendices/A-gate-specs.md) | 四層 Truth Gate 的完整 GateSpec |
| [B — Evidence Schema](appendices/B-evidence-schema.md) | Evidence Receipt、Claim、綁定規則 |
| [C — Divergence Types](appendices/C-divergence-types.md) | 分歧類型定義、程度、處理流程 |
| [D — Training Curriculum](appendices/D-training-curriculum.md) | 5 階段訓練課程 |
| [E — 核心詞彙表](appendices/E-glossary.md) | 21 個核心詞彙定義 |

### 來源

| 文件 | 說明 |
|------|------|
| [sources/README.md](sources/README.md) | 來源清單 |
| [sources/original-spec.txt](sources/original-spec.txt) | 原始整合規格（證據保留） |
| [sources/original-spec.en.md](sources/original-spec.en.md) | 原始整合規格的非正式英文衍生版 |
