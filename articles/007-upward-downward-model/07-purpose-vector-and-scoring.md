# 07｜目的向量與三層鎖

> **成熟度：** PROVISIONAL（概念已定案；維度需實驗校準）
> **對應原始章節：** Part VII（目的向量與二十維評分）

---

## 7.1 目的不能只是一句自然語言

自然語言描述的目的有根本問題：

- 模糊（「修好這個 bug」→ 哪個 bug？什麼叫修好？）
- 可被重新解釋（模型會把目的改寫成自己方便執行的版本）
- 無法量化校準（無法判斷「是否偏離目的」）

因此，目的必須被編碼成**結構化的 purpose vector**。

---

## 7.2 二十維目的向量（初始提案）

| 維度 | 定義 | 範圍 |
|------|------|------|
| V01 | 任務類型 | debug / implement / analyze / optimize |
| V02 | 正確路線 ID | 指定 S 賽道 |
| V03 | 允許的 route lock 條件 | binary/source/hash/checkpoint |
| V04 | 不允許的 route | fallback / vec / stale |
| V05 | 數值精度要求 | FP4 / FP8 / FP16 / FP32 |
| V06 | 數值容忍度 | max abs_error / rel_error |
| V07 | 品質指標 | PPL / downstream task |
| V08 | 品質門檻 | 最低可接受值 |
| V09 | 效能目標 | latency / throughput |
| V10 | 效能門檻 | 最低可接受值 |
| V11 | 證據要求 | 必須綁定的證據類型 |
| V12 | 不確定性容忍度 | 允許的最大不確定性 |
| V13 | abstain 條件 | 何時可以 abstain |
| V14 | dispatch 範圍 | 允許發包到哪些子任務 |
| V15 | 禁止動作 | 不可執行的操作 |
| V16 | 時間預算 | 最大執行時間 |
| V17 | 資源預算 | 最大運算資源 |
| V18 | 回滾條件 | 何時必須回滾 |
| V19 | 完成標準 | 什麼叫「完成」 |
| V20 | 驗收標準 | 什麼叫「通過」 |

---

## 7.3 Purpose Lock

Purpose Lock 是**目的鎖定機制**：一旦 purpose vector 被鎖定，任何元件不得擅自修改。

- 鎖定後，下行模型只能在 purpose vector 範圍內生成
- 上行模型檢查結果是否偏離 purpose vector
- 任何偏離必須經由分歧系統處理，不能默默修正

---

## 7.4 Event Gate Lock

Event Gate Lock 是**事件閘門鎖定機制**：每個 truth gate 的通過是一個事件，後續 gate 依賴於前一個 gate 的事件。

- Gate 1 PASS → 解鎖 Gate 2
- Gate 2 PASS → 解鎖 Gate 3
- Gate 3 PASS → 解鎖 Gate 4
- 任何 gate FAIL → 鎖定後續所有 gate

---

## 7.5 Dual Format Lock

Dual Format Lock 是**雙格式鎖定機制**：下行和上行模型的輸出必須使用同一套格式，才能被 judge 公平比較。

- 下行模型輸出：答案 + 目的對齊宣告
- 上行模型輸出：答案 + 目的對齊宣告
- 兩者使用相同的 schema
- Judge 比較的是同一格式下的品質與一致性
