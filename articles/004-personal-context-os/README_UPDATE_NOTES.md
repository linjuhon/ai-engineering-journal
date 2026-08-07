# Article 004 README 更新建議（2026-08-07）

請將 Article 004 README 的定位更新為：

## 新一句話定位

**English**

Personal Context OS is no longer defined as a system that turns every durable piece of context into a Skill. It is a control plane built around Canonical Context, Skill Federation, evidence-gated promotion, and runtime policy. Purpose, criteria, boundaries, project state, and decisions remain canonical state; procedural Agent Skills stay independent and composable. Pi is the reference application kernel for the complete system, not merely a coding adapter.

**中文**

Personal Context OS 不再把所有長期資訊都統一成 Skill。新版把正式目的、完成標準、底線、專案現況與決策放在 Canonical Context；把程序型 Agent Skills 保持為獨立、可組合、可從 Pi／第三方／社群接入的能力；第三方產物必須經證據與 Promotion Gate 才能升格；Pi 則從單純 Coding Adapter 升級為完整體的 Reference Application Kernel。

## 版本導航

- **Current architecture / 目前生效架構：** `ARCHITECTURE_REVISION_2026-08-07.md`
- **Original full specification / 原始完整規格：** `FULL_ARTICLE.md`
- **English current architecture：** `ARCHITECTURE_REVISION_2026-08-07.en.md`
- **English V1 baseline：** `FULL_ARTICLE.en.md`

## 應保留的歷史說明

`FULL_ARTICLE.md` 不刪除、不覆蓋。它是 2026-07-30 V1 的設計基線；V2 只在 Skill 分層、第三方 Skill Federation、Pi 完全體定位、Promotion/Compilation 與契約語義上 supersede V1。

## Root README / articles README 的 Article 004 摘要建議

### English

**Personal Context OS:** A context-governance control plane for long-lived AI collaboration. Canonical goals, criteria, boundaries, state, and decisions are separated from procedural Agent Skills; external Skill ecosystems remain federated rather than absorbed. A Clerk, conflict/promotion gates, Execution Specs, evidence reconciliation, and a Pi-based reference runtime keep agents aligned without turning every capability into one monolithic memory system.

### 中文

**個人上下文作業系統：** 一個面向長期 AI 協作的上下文治理控制平面。正式目的、完成標準、底線、現況與決策和程序型 Agent Skills 分離；第三方 Skill 生態保持 Federation，不被系統吸收或覆蓋。紀事員、衝突／升格 Gate、Execution Spec、證據對帳與以 Pi 為核心的 reference runtime，共同確保能力在正確現實狀態下工作。
