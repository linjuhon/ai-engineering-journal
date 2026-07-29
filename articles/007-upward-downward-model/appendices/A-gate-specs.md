# 附錄 A：Gate Specs

> **成熟度：** PROVISIONAL（spec 需與實作同步更新）

---

## A.1 GateSpec Schema

```yaml
gate_id: str
name: str
entry_condition: str
checkpoints: list[str]
pass_condition: str
fail_condition: str
uncertain_condition: str
insufficient_evidence_condition: str
ambiguous_condition: str
next_gate: str | null
fallback_gate: str | null
timeout_ms: int
retry_limit: int
```

## A.2 Route Truth GateSpec

```yaml
gate_id: G1
name: Route Truth
entry_condition: binary/source/hash 對齊
checkpoints:
  - clean build 存在
  - native FP4 nb=1 進入目標 CUDA route
  - allowed route entry checkpoint 存在
  - allowed route exit checkpoint 存在
  - mixed FP4 fail-closed
  - nb>1 unsupported / fail-closed
  - fallback 被排除
  - vec 假路未被當成 native FP4 成功
  - stale binary 被排除
pass_condition: 所有 checkpoint PASS
fail_condition: 任一 checkpoint FAIL
uncertain_condition: checkpoint 證據不足
insufficient_evidence_condition: 缺少關鍵 checkpoint 證據
ambiguous_condition: checkpoint 證據矛盾
next_gate: G2
fallback_gate: null
timeout_ms: 30000
retry_limit: 3
```

## A.3 Numeric Truth GateSpec

```yaml
gate_id: G2
name: Numeric Truth
entry_condition: G1 PASS
checkpoints:
  - P0 input / tensor metadata
  - P1 FP4 block bytes / scale / nibble
  - P2 dequant Q/K/V
  - P3 QK score / MMA
  - P4 mask / scale
  - P5 online softmax
  - P6 p_all / probability
  - P7 V load / V decode
  - P8 P·V accumulation
  - P9 normalize
  - P10 output store
  - P11 final GPU vs oracle
pass_condition: 所有 checkpoint 在 tolerance 內
fail_condition: 存在 first divergence
uncertain_condition: checkpoint 資料不完整
insufficient_evidence_condition: 缺少 oracle 比較基準
ambiguous_condition: 多個 checkpoint 同時 divergence
next_gate: G3
fallback_gate: G1
timeout_ms: 60000
retry_limit: 2
```

## A.4 Quality Truth GateSpec

```yaml
gate_id: G3
name: Quality Truth
entry_condition: G2 PASS
checkpoints:
  - PPL 回歸或改善
  - 下游任務未受影響
  - 數值正確性在不同配置下一致
  - 修復未引入新的數值不穩定
pass_condition: 所有品質指標在門檻內
fail_condition: 任一品質指標超出門檻
uncertain_condition: 品質指標資料不足
insufficient_evidence_condition: 缺少下游任務評估
ambiguous_condition: 不同配置下的品質指標不一致
next_gate: G4
fallback_gate: G2
timeout_ms: 120000
retry_limit: 2
```

## A.5 Performance Truth GateSpec

```yaml
gate_id: G4
name: Performance Truth
entry_condition: G3 PASS
checkpoints:
  - 延遲在預算內
  - 吞吐量達標
  - 效能在不同硬體配置下一致
  - 效能改善建立在正確的數值與品質基礎上
pass_condition: 所有效能指標在門檻內
fail_condition: 任一效能指標超出門檻
uncertain_condition: 效能資料不足
insufficient_evidence_condition: 缺少硬體配置基準
ambiguous_condition: 不同硬體配置下的效能不一致
next_gate: null
fallback_gate: G3
timeout_ms: 120000
retry_limit: 2
```
