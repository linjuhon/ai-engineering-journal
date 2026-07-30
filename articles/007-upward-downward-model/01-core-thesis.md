[← 回到技術索引](TECHNICAL_INDEX.md) | [English](01-core-thesis.en.md) | **繁體中文**

---

# 01｜核心論點

> **成熟度：** SETTLED（核心命題）
> **對應原始章節：** Part 0（一句話總綱）

---

## 1.1 一句話總綱

這不是一個普通 prompt、不是一套單純工程流程、也不是一個 reviewer-agent，而是一種**雙方向、對抗協調式、以不確定性校準為核心的後訓練能力對齊框架**。

它的核心是：

> 一個模型負責從目的往下生成細節；另一個模型負責從結果、細節、報告、軌跡往上反推目的、契約、gate 與因果鏈。
> 兩者都產生答案，並在同一個目的向量下競爭、互補、重組、回訓。
> 系統不是急著產生確定答案，而是先判斷目前是否有足夠證據進入下一層 truth gate；證據不足時，必須誠實 abstain，並發出精確的 bounded next dispatch。

最終目標不是讓 AI 更會「猜答案」，而是讓 AI 學會：

```
看到細節，不是立刻往下修；
而是先往上反推：
這個細節屬於哪個 route？
哪個 gate？
哪個 contract？
哪個 human intent？
目前是否有資格進入下一步？
```

這是一種**反向抽象能力**。

---

## 1.2 核心矛盾

現有 AI 系統（尤其是大型語言模型）有一個根本的行為缺陷：

> **模型太容易從細節直接跳到 patch，跳過 route verification、跳過因果診斷、跳過不確定性評估。**

典型行為鏈：

```
看到可疑程式碼
→ 往下猜 root cause
→ patch
→ 用漂亮敘事覆蓋不確定性
→ 宣稱完成
```

這在工程場景中尤其危險，因為：

- 修錯路線比不修更糟（引入新 bug、汙染證據）
- 假成功比明顯失敗更難偵測（敘事完整、測試通過、但根本問題未解）
- 不確定性被隱藏而非被管理（模型不說「我不確定」，而是編造合理答案）

---

## 1.3 核心解法

### 工程層：四層 Truth Gate

```
Route Truth → Numeric Truth → Quality Truth → Performance Truth
```

- Route 沒過，不准談 numeric root cause
- Numeric 沒有 first divergence，不准 patch
- Quality 沒過，不准 performance
- Performance 不能建立在錯路或假成功上

### 模型層：下行模型 × 上行模型

- **下行模型 D↓**：從目的（purpose vector）往下生成答案、程式碼、報告
- **上行模型 U↑**：從結果、細節、軌跡往上反推目的、契約、gate、因果鏈
- 兩者在同一目的向量下對抗、互補、重組、回訓

### 訓練層：目的鎖定雙向對抗後訓練

```
Goal-Locked Bidirectional Adversarial Post-Training
```

- 不是普通 prompt
- 不是 ordinary reviewer
- 不是普通 debate
- 不是 solver-verifier

### 不確定性層：不確定性直面框架

系統最終不是要「一直給確定答案」，而是：

```
辨識不確定性 → 表達不確定性 → 校準不確定性
→ 面對不確定性 → 證據不足時 abstain
→ 在不確定時發 bounded next dispatch
```

分歧不是雜訊。分歧是系統對自身不確定性的主要感測器。

---

## 1.4 與現有 Articles 的關係

| Article | 關係 |
|---------|------|
| **001** | 007 的「上行模型審計 claim、抓假成功」正是 001 案例（GPT-5.6 目標接管）的系統化解法 |
| **005** | 005 提出「全局智能」理論框架（認知調度器、飽和估計、範式切換）；007 是更具體的雙向對抗後訓練架構，兩者互補 |
| **006** | 006 的 A–E 系統（C 控制面、D 治理閉環、truth gates）與 007 的工程 truth gates（Route/Numeric/Quality/Performance）共享相同 DNA，但 007 抽象成通用框架 |
