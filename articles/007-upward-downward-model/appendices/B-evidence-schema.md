[← 回到技術索引](../TECHNICAL_INDEX.md) | [English](B-evidence-schema.en.md) | **繁體中文**

---

# 附錄 B：Evidence Schema

> **成熟度：** PROVISIONAL（schema 需與實作同步更新）

---

## B.1 Evidence Receipt Schema

```yaml
evidence_id: str
type: binary | log | test_result | oracle | human_feedback | execution_trace
source: str
timestamp: datetime
content_hash: str
claim_id: str
binding_strength: direct | indirect | circumstantial
validity: valid | invalid | expired | superseded
metadata:
  model_version: str | null
  environment: str | null
  hardware: str | null
  seed: int | null
```

## B.2 Claim Schema

```yaml
claim_id: str
statement: str
claim_type: route | numeric | quality | performance | purpose
confidence: float
evidence_ids: list[str]
status: unverified | supported | contradicted | insufficient_evidence
created_at: datetime
updated_at: datetime
```

## B.3 Evidence Binding Rules

1. 任何 claim 必須綁定至少一個 evidence
2. 任何 evidence 必須標明綁定的 claim
3. 無綁定的 claim → 自動標記為 `unverified`
4. 綁定失效的 evidence → 自動標記 claim 為 `insufficient_evidence`
5. 同一 claim 的多個 evidence 必須一致；不一致時標記為 `contradicted`

## B.4 Evidence Validity Rules

| 狀態 | 定義 | 自動轉換條件 |
|------|------|-------------|
| valid | 證據有效 | — |
| invalid | 證據無效 | 證據被證明錯誤 |
| expired | 證據過期 | 超過有效期限 |
| superseded | 證據被取代 | 新證據覆蓋舊證據 |
