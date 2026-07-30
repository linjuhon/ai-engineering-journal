[← 回到文章入口](README.md) | [English](TECHNICAL_INDEX.en.md) | **繁體中文**

---

# A–E 真理—敘事共生系統：施工規格

> **文章類型：** Normative Implementation Specification
> **成熟度：** 混合（各章節獨立標註）
> **版本：** 2026-07-30
> **對應 Article：** 002（產品架構總覽）、005（全局智能理論框架）

---

## 問題定義

占星解盤面臨一個根本矛盾：**真理需要精確，但人類需要故事。**

傳統解法讓一個模型同時學真理與敘事，導致模型在兩者衝突時選擇妥協。A–E 系統將真理、敘事、測量、治理、語義橋接五種能力物理隔離，避免任何單一元件同時掌握定義、創作、評分與修改規則的全部權力。

---

## 一句話核心架構

> **A 是骨骼，B 是血肉，C 是兩者之間的動態邊界；A 與 B 不應直接對話，而是在原型向量空間交會。**

---

## A–E 元件表

| 元件 | 名稱 | 核心責任 | 模型規模建議 | 成熟度 |
|------|------|---------|-------------|--------|
| **A** | Truth Engine | 真理推演與結構化輸出 | 13B–31B | SETTLED |
| **B** | Narrative Engine | 自由敘事與具象化 | 7B–13B | SETTLED |
| **C** | Control Plane | A–B 距離測量、100 維控制 | 7B–13B | PROVISIONAL |
| **D** | Governance Assistant | 讀全文、提修正案 | 31B–70B | SETTLED |
| **E** | Semantic Bridge | 語義壓縮與橋接（研究階段） | 待定 | RESEARCH_HYPOTHESIS |
| **Human** | — | 憲法與最終裁決 | — | SETTLED |
| **Safety** | — | 獨立底線檢查 | — | SETTLED |

---

## 閱讀順序

```
第一次閱讀（建立整體理解）：
  README.md → 01 → 02 → 06 → 04

第二次閱讀（深入治理與訓練）：
  03 → 05 → 07 → 08 → 09

附錄（參考用）：
  附錄 A–E 按需查閱
```

---

## 與其他 Articles 的關係

| Article | 關係 | 說明 |
|---------|------|------|
| **002** | 產品架構總覽 | 002 回答「整個占星網站要建成什麼」；本文回答「核心智能怎麼訓練、執行、治理」 |
| **005** | 理論框架 | 005 定義全局智能通用框架；本文是該理論在占星領域的具體實作案例 |

若 002 與本文在實作細節上衝突，以本文為準。

---

## 狀態摘要

| 章節 | 成熟度 | 關鍵不確定性 |
|------|--------|-------------|
| 01 憲法 | SETTLED | — |
| 02 元件邊界 | SETTLED（核心契約）；PROVISIONAL（模型規模） | 模型規模需實驗 A1 |
| 03 資料工程 | PROVISIONAL | 具體 schema 與門檻需驗證 |
| 04 管線 | PROVISIONAL | 非同步模式需產品需求決定 |
| 05 冷啟動 | PROVISIONAL | 五階段門檻需校準 |
| 06 100 維控制面 | PROVISIONAL | 維度分組與門檻需實驗 |
| 07 治理 | SETTLED（流程）；PROVISIONAL（門檻） | 具體門檻需校準 |
| 08 語義橋接 | RESEARCH_HYPOTHESIS | 注入方法與效果未驗證 |
| 09 實驗路線 | PENDING_EXPERIMENT | 硬體決策需實驗結果 |

---

## 章節目錄

| 章節 | 內容 |
|------|------|
| [01 — 論點與系統憲法](01-thesis-and-constitution.md) | 核心矛盾、12 條憲法、逃逸定義、Safety 底線 |
| [02 — 元件邊界](02-component-boundaries.md) | A/B/C/D/E/人類/Safety 完整契約 |
| [03 — 資料工程](03-data-engineering.md) | 六層資料模型、20+ 流派索引、OOD 留出 |
| [04 — 線上推理管線](04-runtime-pipeline.md) | 同步路徑、情緒鉤、去過標記、失敗降級 |
| [05 — 冷啟動與訓練](05-cold-start-and-training.md) | 五階段、前 200 篇影子、自蒸餾門檻 |
| [06 — 100 維控制面](06-control-plane-100d.md) | 50 個初始維度、交通燈邏輯、不確定性機制 |
| [07 — 治理與進化](07-governance-and-evolution.md) | C→D 觸發、D 提案、人類裁決、回測/Canary/回滾 |
| [08 — 1024 維語義橋接](08-semantic-bridge-1024d.md) | E_truth/E_text 分離、注入假設、終局研究 |
| [09 — 實驗與硬體路線](09-experiment-and-hardware-roadmap.md) | 實驗 A1/A2/A3、硬體決策鏈、20 步對照 |

### 附錄

| 附錄 | 內容 |
|------|------|
| [A — 元件契約與 Schema](appendices/A-contracts-and-schemas.md) | A/B/C/D/E 完整 JSON schema |
| [B — 風險登記](appendices/B-risk-register.md) | 風險矩陣與緩解措施 |
| [C — 決策簿](appendices/C-decision-ledger.md) | 已定案/暫定/已淘汰/研究假設 |
| [D — 20 步對照表](appendices/D-twenty-step-crosswalk.md) | 原始 0–20 步驟 → 正式章節對照 |
| [E — 測試案例](appendices/E-test-cases.md) | 各章節驗收測試 |

### 來源

| 文件 | 說明 |
|------|------|
| [sources/README.md](sources/README.md) | 來源清單與 superseded sections |
| [sources/original-complete-spec.docx](sources/original-complete-spec.docx) | 原始整合規格（證據保留） |
| [sources/original-complete-spec.en.md](sources/original-complete-spec.en.md) | 原始整合規格的非正式英文衍生版 |
