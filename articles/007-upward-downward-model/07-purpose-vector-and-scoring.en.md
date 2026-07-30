[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](07-purpose-vector-and-scoring.md)

---

# 07｜Purpose Vector and Three Locks

> **Maturity:** PROVISIONAL (concept finalized; dimensions require experimental calibration)
> **Corresponding source section:** Part VII (Purpose Vector and Twenty-Dimensional Scoring)

---

## 7.1 A Purpose Cannot Be Just a Single Natural-Language Sentence

Natural-language descriptions of a purpose have fundamental problems:

- Ambiguity (“fix this bug” → which bug? What counts as fixed?)
- Can be reinterpreted (the model will rewrite the purpose into a version that is convenient for it to execute)
- Cannot be quantitatively calibrated (it is impossible to determine “whether the system has deviated from the purpose”)

Therefore, the purpose must be encoded as a **structured purpose vector**.

---

## 7.2 Twenty-Dimensional Purpose Vector (Initial Proposal)

| Dimension | Definition | Range |
|-----------|------------|-------|
| V01 | Task type | debug / implement / analyze / optimize |
| V02 | Correct route ID | Designated S Track |
| V03 | Permitted route lock conditions | binary/source/hash/checkpoint |
| V04 | Disallowed route | fallback / vec / stale |
| V05 | Numerical precision requirement | FP4 / FP8 / FP16 / FP32 |
| V06 | Numerical tolerance | max abs_error / rel_error |
| V07 | Quality metric | PPL / downstream task |
| V08 | Quality threshold | Minimum acceptable value |
| V09 | Performance target | latency / throughput |
| V10 | Performance threshold | Minimum acceptable value |
| V11 | Evidence requirement | Evidence types that must be bound |
| V12 | Uncertainty tolerance | Maximum permitted uncertainty |
| V13 | abstain condition | When the system may abstain |
| V14 | dispatch scope | Permitted subtasks for dispatch |
| V15 | Prohibited actions | Operations that may not be performed |
| V16 | Time budget | Maximum execution time |
| V17 | Resource budget | Maximum compute resources |
| V18 | Rollback condition | When rollback is mandatory |
| V19 | Completion criteria | What counts as “complete” |
| V20 | Acceptance criteria | What counts as “pass” |

---

## 7.3 Purpose Lock

Purpose Lock is a **purpose-locking mechanism**: once the purpose vector is locked, no component may modify it unilaterally.

- Once locked, the downward model can generate only within the scope of the purpose vector
- The upward model checks whether the result deviates from the purpose vector
- Any deviation must be handled through the divergence system and cannot be corrected silently

---

## 7.4 Event Gate Lock

Event Gate Lock is an **event-gate locking mechanism**: passing each truth gate constitutes an event, and each subsequent gate depends on the preceding gate's event.

- Gate 1 PASS → unlock Gate 2
- Gate 2 PASS → unlock Gate 3
- Gate 3 PASS → unlock Gate 4
- Any gate FAIL → lock all subsequent gates

---

## 7.5 Dual Format Lock

Dual Format Lock is a **dual-format locking mechanism**: the outputs of the downward and upward models must use the same format so the judge can compare them fairly.

- Downward model output: answer + purpose-alignment declaration
- Upward model output: answer + purpose-alignment declaration
- Both use the same schema
- The Judge compares quality and consistency within the same format
