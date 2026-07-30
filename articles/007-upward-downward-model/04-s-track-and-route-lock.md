[← 回到技術索引](TECHNICAL_INDEX.md) | [English](04-s-track-and-route-lock.en.md) | **繁體中文**

---

# 04｜S Track、Route Lock 與 State Lock

> **成熟度：** SETTLED（工程概念已驗證）
> **對應原始章節：** Part III（S Track 概念）

---

## 4.1 不是自由插針，而是先封路

傳統 debug 思維是「自由插針」：到處加 print、到處測、到處猜。但 FA4 經驗證明，自由插針在複雜系統中會：

- 汙染執行狀態（probe 副作用）
- 產生假線索（probe 本身的 bug）
- 分散注意力（太多候選 root cause）

正確做法是**先封路**：先證明哪些路線是正確的、哪些是錯誤的，然後只在正確路線上插針。

---

## 4.2 S Track

S Track 是**唯一被允許的正確執行路徑**。它由以下條件定義：

- 明確的 entry checkpoint（進入條件）
- 明確的 exit checkpoint（退出條件）
- 明確的中間站點（可觀測點）
- 明確的 fallback 排除規則
- 明確的假路排除規則

在 S Track 被證明之前，所有數值分析都是 premature。

---

## 4.3 Route Lock

Route Lock 是**封路機制**：鎖定 S Track，排除所有其他路徑。

Route Lock 的條件：

1. binary/source/hash 對齊
2. clean build 存在
3. 目標 route 被證明正在執行
4. 非目標 route 被證明沒有執行
5. fallback 被排除
6. stale binary 被排除

Route Lock 一旦建立，所有後續分析都在這個鎖定的路徑上進行。

---

## 4.4 State Lock

State Lock 是**鎖狀態機制**：在分析過程中，確保系統狀態不被意外改變。

State Lock 的條件：

1. 輸入資料固定
2. 模型權重固定
3. 環境參數固定
4. 硬體配置固定
5. 隨機種子固定

State Lock 確保每次執行的可重現性。沒有 State Lock，就無法區分「修復有效」和「隨機波動」。

---

## 4.5 Reference Contract

Reference Contract 是**正確跑法契約**：明確定義什麼叫「正確執行」。

- 正確的輸入格式
- 正確的執行順序
- 正確的中間結果範圍
- 正確的輸出格式
- 正確的 oracle 比較基準

Reference Contract 是上行模型判斷「是否偏離目的」的依據。

---

## 4.6 封路之後，插針問題被降級

一旦 S Track 被鎖定、狀態被鎖定、契約被定義，插針問題就從「到處找 root cause」降級為「在已知路徑上找 first divergence」。

這正是四層 Truth Gate 的工程價值：**它不是限制 debug，而是把 debug 從盲目搜尋變成精確定位。**
