[← 回到技術索引](../TECHNICAL_INDEX.md) | [English](A-contracts-and-schemas.en.md) | **繁體中文**

---

# 附錄 A：元件契約與 Schema

> **成熟度：** PROVISIONAL（schema 需與實作同步更新）

---

## A.1 A Truth Package Schema

```json
{
  "truth_package": {
    "version": "1.0",
    "case_id": "string",
    "input_hash": "string",
    "tradition": "string",
    "school": "string",
    "task": "string",
    "prototypes": [
      {
        "id": "string",
        "name": "string",
        "confidence": 0.0,
        "causal_chain": ["string"],
        "source": "string",
        "boundary_conditions": ["string"]
      }
    ],
    "uncertainty": {
      "overall_confidence": 0.0,
      "low_confidence_items": ["string"],
      "OOD_warning": false
    },
    "metadata": {
      "model_version": "string",
      "inference_time_ms": 0,
      "fallback_used": false
    }
  }
}
```

## A.2 B Story State Schema

```json
{
  "story_state": {
    "case_id": "string",
    "global_arc": ["建立", "堆疊", "轉折", "收束"],
    "current_unit": "string",
    "completed_units": ["string"],
    "emotion_temperature_curve": [0.0],
    "motifs": [
      {
        "name": "string",
        "uses": 0,
        "angles": ["string"]
      }
    ],
    "last_hook": "string",
    "forbidden_escape": ["string"],
    "segment_index": 0
  }
}
```

## A.3 C Score Report Schema

```json
{
  "score_report": {
    "version": "1.0",
    "case_id": "string",
    "dimensions": [
      {
        "id": "C-01",
        "name": "string",
        "score": 0.0,
        "confidence": 0.0,
        "traffic_light": "green|yellow|red",
        "uncertainty_reason": "string|null",
        "evidence": "string"
      }
    ],
    "overall_traffic_light": "green|yellow|red",
    "hard_red_triggers": ["string"],
    "yellow_triggers": ["string"],
    "metadata": {
      "model_version": "string",
      "inference_time_ms": 0
    }
  }
}
```

## A.4 D Proposal Schema

```json
{
  "d_proposal": {
    "version": "1.0",
    "case_id": "string",
    "proposals": [
      {
        "dimension_id": "string",
        "current_rule": "string",
        "suggested_rule": "string",
        "scope": "conditional|prototype_group|global",
        "evidence_ranges": ["string"],
        "reason": "string",
        "confidence": 0.0,
        "alternative_view": "string|null"
      }
    ],
    "no_change_reason": "string|null",
    "analysis_summary": "string",
    "d_version": "string"
  }
}
```

## A.5 E Vector Schema

```json
{
  "e_vector": {
    "version": "1.0",
    "case_id": "string",
    "e_truth": {
      "vector": [0.0],
      "dimension": 1024,
      "model_version": "string"
    },
    "e_text": {
      "vector": [0.0],
      "dimension": 1024,
      "model_version": "string"
    },
    "cosine_similarity": 0.0,
    "metadata": {
      "inference_time_ms": 0,
      "shadow_mode": true
    }
  }
}
```

## A.6 ProcessingEnvelope Schema

```json
{
  "processing_envelope": {
    "request_id": "string",
    "trace_id": "string",
    "user_id": "string",
    "stage": "string",
    "status": "pending|processing|completed|failed|degraded",
    "input_version": "string",
    "schema_version": "string",
    "algorithm_version": "string",
    "model_version": "string",
    "started_at": "datetime",
    "finished_at": "datetime",
    "processing_time_ms": 0,
    "payload_ref": "string",
    "result_ref": "string",
    "quality_score": 0.0,
    "confidence": 0.0,
    "warnings": ["string"],
    "errors": ["string"],
    "provenance": ["string"]
  }
}
```
