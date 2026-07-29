← [回到個人作品集](https://github.com/linjuhon)

# AI Engineering Journal

**作者：** [linjuhon](https://github.com/linjuhon)

這是一個以真實工程問題為基礎的技術文章庫，收錄：

- 大型 AI 輔助工程的事故分析與恢復紀錄；
- 可落地的產品與系統架構；
- 長期記憶、上下文治理與 Agent 控制面；
- 占星計算、知識工程與 AI 解讀平台；
- 全局智能、創造性探索與後訓練方法論。

這裡不把「設計目標」包裝成「已完成成果」。每篇文章會盡量標示它屬於真實案例、架構藍圖、研究總綱或待驗證理論，並連回程式碼、Issue、測試與證據。

## Featured Case Study

### 001 — GPT-5.6 目標接管與 DeepSeek 恢復

**這是最能代表我工程判斷方式的真實案例。**

兩週大型工程實測：GPT-5.6 如何把「選出正確歷史樹」改寫成「修好目前樹」，以及我如何辨認假進展、否決沉沒成本並改用 DeepSeek V4 Flash，把工作拉回原始目標。

[閱讀文章 →](articles/001-gpt-5-6-goal-takeover/)

## Architecture Blueprints

### 002 — 占星系統統一架構與端到端數據流

九大處理階段、12 個核心模塊、1,631 個標籤、七種資料庫、性能與錯誤治理，以及可重現的自動文檔工作流。

[閱讀文章 →](articles/002-astrology-system-architecture/)

### 004 — 個人上下文作業系統（Context OS）

不是保存無限聊天歷史，而是用多 Skills、紀事員、衝突 Gate、Context Packet 與 Execution Spec 維護長期共同狀態。

[閱讀文章 →](articles/004-personal-context-os/)

### 006 — A–E 真理—敘事共生系統（施工規格）

A–E 五元件物理隔離架構：100 維顯式控制面、六層資料工程、冷啟動五階段、D 治理閉環與 1024 維語義橋接研究。是 Article 002 的深度施工規格，也是 Article 005 理論的具體實作案例。

[閱讀文章 →](articles/006-astrology-truth-narrative-system/)

## Research & Learning

### 003 — 占星系統全技術棧深度學習總綱

從軟體工程、Monorepo、TypeScript、Python、Swiss Ephemeris、AI、七種資料層，一路到 Docker、Kubernetes、觀測與 CI/CD 的長程研究課程。

[閱讀總綱 →](articles/003-astrology-full-stack-learning-roadmap/)

### 005 — 從答案生成器到全局智能

討論局部最優、探索與利用、跨知識調度、目標主權，以及如何把「何時真正換路」變成可後訓練、可評測的長程能力。

[閱讀文章 →](articles/005-global-intelligence-post-training/)

### 007 — 上行模型 × 下行模型：反向抽象後訓練

從 FA4 CUDA debug 長出來的雙向對抗後訓練框架：四層 Truth Gate、下行/上行模型、目的鎖定、不確定性直面框架。是 Article 001 案例的系統化解法，與 Article 005/006 互補。

[閱讀文章 →](articles/007-upward-downward-model/)

## 文章狀態

| 編號 | 類型 | 狀態 |
|---|---|---|
| 001 | 真實工程案例 | 已公開回報，附原始 Issue |
| 002 | 架構藍圖 | 完整設計，部分能力待實作驗證 |
| 003 | 研究／課程總綱 | 章節化長程路線 |
| 004 | 產品架構 | 完整規格，待 MVP 與真實評測 |
| 005 | 研究方法論 | 理論、訓練與 benchmark 提案 |
| 006 | 施工規格 | 混合（各章節獨立標註成熟度） |
| 007 | 訓練架構 | PROVISIONAL（工程 gates 已驗證；訓練框架尚未實作） |

## 發文格式

後續文章統一採用：背景 → 目標 → 實際發生 → 根因 → 我的介入 → 結果 → 證據 → 可重用原則。架構文章則明確分開設計目標、驗收門檻與已驗證成果。

## Related Work

- [Portfolio Profile](https://github.com/linjuhon)
- [b9128 Reconstruction](https://github.com/linjuhon/b9128-reconstruction)
- [Video20 AI Workbench](https://github.com/linjuhon/video20-ai-workbench)
