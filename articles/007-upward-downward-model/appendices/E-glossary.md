[← 回到技術索引](../TECHNICAL_INDEX.md) | [English](E-glossary.en.md) | **繁體中文**

---

# 附錄 E：核心詞彙表

> **成熟度：** SETTLED
> **對應原始章節：** Part XXVI（核心詞彙表）

---

| 詞彙 | 定義 |
|------|------|
| **Route Truth** | 第一層 truth gate：確認執行是否走正確路線 |
| **Numeric Truth** | 第二層 truth gate：在正確路線上找 first divergence |
| **Quality Truth** | 第三層 truth gate：確認修復後品質未受影響 |
| **Performance Truth** | 第四層 truth gate：確認修復後效能達標 |
| **S Track** | 唯一被允許的正確執行路徑，有明確的進入／退出檢查點 |
| **Route Lock** | 封路機制：鎖定 S 賽道，排除所有其他路徑 |
| **State Lock** | 鎖狀態機制：確保分析過程中系統狀態不被改變 |
| **First Divergence** | 第一個實際值與預期值之差超過容許誤差的位置 |
| **Repair Permission** | 修復許可：只有通過 Numeric Truth 後才能修補 |
| **Downward Model (D↓)** | 從目的往下生成細節的模型 |
| **Upward Model (U↑)** | 從結果往上反推目的的模型 |
| **Purpose Lock** | 目的鎖定：目的向量鎖定後不可擅自修改 |
| **Event Gate Lock** | 事件閘門鎖定：閘門通過事件解鎖下一個閘門 |
| **Dual Format Lock** | 雙格式鎖定：D↓ 和 U↑ 使用同一輸出格式 |
| **Canonical Event Graph** | 標準事件圖：truth gate 的通過事件序列 |
| **Reverse Work-Order Synthesis** | 反向工單生成：從結果反推任務描述 |
| **Trajectory-to-Intent Compilation** | 軌跡反編譯：從執行軌跡還原意圖 |
| **Goal-Locked Bidirectional Adversarial Post-Training** | 目的鎖定雙向對抗後訓練：本框架的核心訓練方法 |
| **Uncertainty Profile** | 不確定性輪廓：系統對自身不確定性的結構化表達 |
| **Evidence Receipt** | 證據收據：每個證據的標準化記錄格式 |
| **Bounded Next Dispatch** | 有界下一步發包：在不確定時發出精確的下一步行動 |
