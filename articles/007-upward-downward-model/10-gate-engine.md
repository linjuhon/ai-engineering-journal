[← 回到技術索引](TECHNICAL_INDEX.md) | [English](10-gate-engine.en.md) | **繁體中文**

---

# 10｜Gate Engine、分歧系統與證據系統

> **成熟度：** PROVISIONAL（gate 狀態已定義；分歧分類需實驗）
> **對應原始章節：** Part XV + XVI + XVII（Gate Engine、分歧系統、證據系統）

---

## 10.1 Gate 狀態

每個 truth gate 有五種可能狀態：

| 狀態 | 定義 | 後續動作 |
|------|------|---------|
| **PASS** | 證據充分，gate 通過 | 解鎖下一個 gate |
| **FAIL** | 證據顯示 gate 未通過 | 鎖定後續所有 gate，回報失敗原因 |
| **UNCERTAIN** | 證據不足以判斷 PASS 或 FAIL | 觸發分歧系統 |
| **INSUFFICIENT_EVIDENCE** | 缺乏必要證據 | 發 bounded next dispatch 收集證據 |
| **AMBIGUOUS** | 證據指向矛盾結論 | 觸發分歧系統 + 人類裁決 |

---

## 10.2 FA4 Gate Sequence

```
Gate 1: Route Truth
  PASS → 解鎖 Gate 2
  FAIL → 停止，回報 route 錯誤

Gate 2: Numeric Truth
  PASS → 解鎖 Gate 3
  FAIL → 回報 first divergence，不准 patch

Gate 3: Quality Truth
  PASS → 解鎖 Gate 4
  FAIL → 回報品質問題，不准最佳化

Gate 4: Performance Truth
  PASS → 完成
  FAIL → 回報效能問題
```

---

## 10.3 GateSpec 範例

```yaml
gate_id: G1
name: Route Truth
entry_condition: binary/source/hash 對齊
checkpoints:
  - clean build 存在
  - native FP4 nb=1 進入目標 route
  - mixed FP4 fail-closed
  - fallback 被排除
  - stale binary 被排除
pass_condition: 所有 checkpoint PASS
fail_condition: 任一 checkpoint FAIL
uncertain_condition: checkpoint 證據不足
next_gate: G2
```

---

## 10.4 分歧類型

| 分歧類型 | 定義 | 可能原因 |
|---------|------|---------|
| Route 分歧 | D↓ 和 U↑ 對當前 route 判斷不一致 | 路線證據不足 |
| Numeric 分歧 | D↓ 和 U↑ 對數值分析不一致 | 數值證據不足 |
| Purpose 分歧 | D↓ 和 U↑ 對目的理解不一致 | 目的向量模糊 |
| Evidence 分歧 | D↓ 和 U↑ 對證據解讀不一致 | 證據矛盾 |
| Gate 分歧 | D↓ 和 U↑ 對 gate 狀態判斷不一致 | gate 條件模糊 |

---

## 10.5 分歧是主要輸出

分歧不是系統的失敗模式，而是**系統對自身不確定性的主要感測器**。

分歧處理流程：

1. 偵測分歧（D↓ vs U↑ 不一致）
2. 分類分歧（route / numeric / purpose / evidence / gate）
3. 評估不確定性（分歧程度 + 信心度）
4. 決定行動（收集證據 / abstain / dispatch / 人類裁決）
5. 記錄分歧（分歧樣本 → 回訓資料）

---

## 10.6 Evidence Receipt

每個證據必須包含：

```yaml
evidence_id: str
type: binary | log | test_result | oracle | human_feedback
source: str
timestamp: datetime
content_hash: str
claim_id: str
binding_strength: direct | indirect | circumstantial
validity: valid | invalid | expired | superseded
```

---

## 10.7 證據完整性

證據完整性檢查：

1. **綁定檢查**：每個 claim 是否有對應的 evidence？
2. **有效性檢查**：evidence 是否仍然有效（未過期、未被 supersede）？
3. **一致性檢查**：多個 evidence 是否指向同一結論？
4. **完整性檢查**：是否有缺失的關鍵 evidence？

---

## 10.8 Claim-Evidence 綁定

Claim 與 Evidence 的綁定是系統的核心治理機制：

- 任何 claim 必須綁定至少一個 evidence
- 任何 evidence 必須標明綁定的 claim
- 無綁定的 claim → 自動標記為「未驗證」
- 綁定失效的 evidence → 自動標記 claim 為「證據過期」
