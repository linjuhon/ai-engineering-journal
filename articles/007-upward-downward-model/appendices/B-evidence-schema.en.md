[← Back to technical index](../TECHNICAL_INDEX.en.md) | **English** | [繁體中文](B-evidence-schema.md)

---

# Appendix B: Evidence Schema

> **Maturity:** PROVISIONAL (schema must be kept in sync with implementation)

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

1. Every claim must bind at least one evidence.
2. Every evidence must specify the claim it binds to.
3. Unbound claim → automatically marked as `unverified`
4. Evidence whose binding becomes invalid → automatically marks the claim as `insufficient_evidence`
5. Multiple evidence for the same claim must be consistent; if inconsistent, marked as `contradicted`

## B.4 Evidence Validity Rules

| Status | Definition | Auto-transition Condition |
|--------|------------|--------------------------|
| valid | Evidence is valid | — |
| invalid | Evidence is invalid | Evidence is proven wrong |
| expired | Evidence has expired | Past the validity period |
| superseded | Evidence is superseded | New evidence overrides old evidence |
