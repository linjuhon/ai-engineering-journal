[← 回到技術索引](../TECHNICAL_INDEX.md) | [English](C-divergence-types.en.md) | **繁體中文**

---

# 附錄 C：分歧類型

> **成熟度：** PROVISIONAL（分歧類型需實驗校準）

---

## C.1 分歧類型定義

| 類型 | 定義 | 偵測方式 | 可能原因 |
|------|------|---------|---------|
| Route 分歧 | D↓ 和 U↑ 對當前 route 判斷不一致 | 比對 route ID | 路線證據不足 |
| Numeric 分歧 | D↓ 和 U↑ 對數值分析不一致 | 比對 first divergence | 數值證據不足 |
| Purpose 分歧 | D↓ 和 U↑ 對目的理解不一致 | 比對 purpose vector | 目的向量模糊 |
| Evidence 分歧 | D↓ 和 U↑ 對證據解讀不一致 | 比對 evidence-claim 綁定 | 證據矛盾 |
| Gate 分歧 | D↓ 和 U↑ 對 gate 狀態判斷不一致 | 比對 gate status | gate 條件模糊 |

## C.2 分歧程度

| 程度 | 定義 | 行動 |
|------|------|------|
| 輕微分歧 | 答案一致，confidence 略有差異 | 取高 confidence 答案 |
| 中等分歧 | 答案一致，但 route/gate 判斷不同 | 分歧分類 + dispatch |
| 嚴重分歧 | 答案不一致 | abstain + 人類裁決 |

## C.3 分歧處理流程

```
1. 偵測分歧
2. 分類分歧類型
3. 評估分歧程度
4. 評估不確定性
5. 決定行動：
   - 輕微分歧 → 取高 confidence 答案
   - 中等分歧 → dispatch 收集證據
   - 嚴重分歧 → abstain + 人類裁決
6. 記錄分歧樣本
7. 分歧樣本 → 回訓資料
```
