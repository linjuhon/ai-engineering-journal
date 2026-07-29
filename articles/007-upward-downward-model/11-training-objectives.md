# 11｜訓練目標

> **成熟度：** PROVISIONAL（訓練目標已定義；訓練順序需實驗）
> **對應原始章節：** Part XVIII + XIX + XX（訓練目標、人類抽樣策略、評估指標）

---

## 11.1 主要目標：Calibration

校準是系統最重要的訓練目標。

**目標：** 讓模型的 confidence 與實際 accuracy 一致。

**訓練信號：**

- 正確 + 高 confidence → 正獎勵
- 正確 + 低 confidence → 輕微負獎勵
- 錯誤 + 高 confidence → 強烈負獎勵
- 錯誤 + 低 confidence → 輕微正獎勵
- abstain + 正確判斷 → 正獎勵
- abstain + 錯誤判斷 → 負獎勵

---

## 11.2 輔助目標 1：Divergence Classification

**目標：** 讓模型能正確分類分歧類型。

**訓練信號：** D↓ 與 U↑ 的實際分歧類型（route / numeric / purpose / evidence / gate）

**評估指標：** 分歧分類準確率

---

## 11.3 輔助目標 2：Uncertainty Source Attribution

**目標：** 讓模型能正確歸因不確定性來源。

**訓練信號：** 不確定性的實際來源（證據不足 / 證據矛盾 / 模型限制 / 任務模糊 / OOD）

**評估指標：** 歸因準確率

---

## 11.4 輔助目標 3：Bounded Next Dispatch

**目標：** 讓模型能在不確定時發出精確的下一步 dispatch。

**訓練信號：** 人類專家的下一步行動

**評估指標：** dispatch 的 precision / recall

---

## 11.5 訓練順序

### Phase 0：不訓練，雙 prompt 驗證

- 使用現有模型，透過 prompt 模擬 D↓ 和 U↑
- 驗證分歧系統是否產生有用信號
- 收集初始分歧樣本

### Phase 1：先訓練 U↑

- 使用反向資料庫訓練上行模型
- 目標：從結果反推目的、gate 狀態、因果鏈
- 評估：反推準確率

### Phase 2：Preference Training

- 使用分歧樣本進行偏好訓練
- D↓ 和 U↑ 的答案 → 人類偏好標註
- 目標：讓模型學會在分歧時 abstain

### Phase 3：改善 D↓

- 使用 U↑ 的反饋改善下行模型
- 目標：減少 premature patch
- 評估：patch 前 route verification 率

### Phase 4：離線交替更新

- D↓ 更新 → 收集新分歧樣本
- U↑ 更新 → 收集新分歧樣本
- 交替更新，避免趨同

---

## 11.6 人類抽樣策略

人類不標全部，只標高價值點：

| 抽樣優先級 | 樣本類型 | 原因 |
|-----------|---------|------|
| 最高 | D↓ 與 U↑ 分歧樣本 | 分歧是系統的不確定性感測器 |
| 高 | 低 confidence 正確樣本 | 校準不足的信號 |
| 高 | 高 confidence 錯誤樣本 | 過度自信的信號 |
| 中 | OOD 樣本 | 分布外行為 |
| 低 | 高 confidence 正確樣本 | 低資訊價值 |

---

## 11.7 評估指標

### 主要指標

- **校準誤差**：|confidence - accuracy| 的平均值
- **分歧檢出率**：系統正確檢出分歧的比例
- **abstain 正確率**：abstain 時確實不確定的比例
- **dispatch precision**：dispatch 的正確率

### 輔助指標

- **分歧分類準確率**
- **不確定性歸因準確率**
- **假成功檢出率**
- **premature patch 率**

### 最重要單一指標

> **假成功檢出率**：系統正確辨識並阻止假成功的比例。

如果這個指標沒有改善，其他指標再好都沒有意義。
