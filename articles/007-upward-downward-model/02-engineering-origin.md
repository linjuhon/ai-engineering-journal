# 02｜工程起源：FA4 的四層 Truth Gate

> **成熟度：** SETTLED（工程方法已驗證）
> **對應原始章節：** Part I（FA4 問題中長出來的工程正確解）

---

## 2.1 表面問題：FA4 很難修

FA4 表面上是一個 CUDA / FP4 / Flash Attention 問題。當時看到的狀態包括：

```
ERR 變大
PPL 爛掉
native FP4 nb=1 不過
mixed FP4 不確定
nb>1 不確定
binary/source 可能不一致
fallback 可能偷跑
probe 可能污染現場
agent 可能看見可疑 code 就亂修
```

從傳統 debug 角度看，它像是「哪一行 CUDA 錯？rowsum？writeback？dispatch？V accumulation？MMA_FP4？lane mapping？」

但真正更深的問題是：

> **在沒有證明「現在跑的是不是正確路線」之前，所有數值推論、patch、品質測試、效能測試都有可能是假的。**

---

## 2.2 四層 Truth Gate

最終 FA4 的正確推進順序被收斂成四層：

```
Gate 1：Route Truth     路線真假
Gate 2：Numeric Truth   數字真假
Gate 3：Quality Truth   品質真假
Gate 4：Performance Truth  效能真假
```

這四層不能互相偷換，也不能跳步。

---

## 2.3 Gate 1：Route Truth

Route Truth 只問一件事：**這次執行到底有沒有走我們規定的 FA4 S 賽道？**

它不問數字對不對。它要先確認：

1. binary/source/hash 是否對齊
2. clean build 是否存在
3. native FP4 nb=1 是否真的進入目標 CUDA route
4. allowed route entry checkpoint 是否存在
5. allowed route exit checkpoint 是否存在
6. mixed FP4 是否 fail-closed
7. nb>1 是否 unsupported / fail-closed
8. fallback 是否被排除
9. vec 假路是否沒有被當成 native FP4 成功
10. stale binary 是否被排除

這一關沒有過，不得進 Numeric Truth。在 Route Truth 沒有過以前，不准討論 rowsum、writeback、p_all、MMA score、softmax recurrence、V accumulation——因為如果路線都沒證明，數值分析可能全是錯路上的數值。

---

## 2.4 Gate 2：Numeric Truth

Numeric Truth 只在 Gate 1 已證明的 S 賽道上進行。

它的任務不是猜 root cause，而是找 **FIRST_DIVERGENCE**：

```
FIRST_DIVERGENCE_STAGE
FIRST_DIVERGENCE_FILE
FIRST_DIVERGENCE_FUNCTION
FIRST_DIVERGENCE_BLOCK
FIRST_DIVERGENCE_VALUE
```

Numeric Truth 的 checkpoint 應包含：

```
P0  input / tensor metadata
P1  FP4 block bytes / scale / nibble
P2  dequant Q/K/V
P3  QK score / MMA
P4  mask / scale
P5  online softmax
P6  p_all / probability
P7  V load / V decode
P8  P·V accumulation
P9  normalize
P10 output store
P11 final GPU vs oracle
```

每一站都必須輸出：stage、file、function、block、tile、logical_row、logical_col、actual_gpu、expected_oracle、abs_error、rel_error、PASS/FAIL。

**沒有 FIRST_DIVERGENCE_TABLE，不准 patch。**

---

## 2.5 Gate 3：Quality Truth

只有 Numeric Truth 過了，才進 Quality Truth。

Quality Truth 問：**修完之後，模型品質是否維持或改善？**

- PPL 是否回歸或改善
- 下游任務是否受影響
- 數值正確性是否在不同配置下一致
- 修復是否引入新的數值不穩定

---

## 2.6 Gate 4：Performance Truth

只有 Quality Truth 過了，才進 Performance Truth。

Performance Truth 問：**修完之後，效能是否達到目標？**

- 延遲是否在預算內
- 吞吐量是否達標
- 效能是否在不同硬體配置下一致
- 效能改善是否建立在正確的數值與品質基礎上

---

## 2.7 關鍵工程原則

```
Route Truth 先於 Numeric Truth
路線真假 先於 數字真假
```

這四層 gate 的順序不是建議，而是**硬門檻**。任何跳步都會導致假成功：修好了錯路的效能、通過了錯路的測試、產生了錯路的漂亮報告。

這個工程原則，是整個上行/下行模型框架的**經驗基礎**。
