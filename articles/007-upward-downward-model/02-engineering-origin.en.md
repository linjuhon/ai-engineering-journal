[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](02-engineering-origin.md)

---

# 02 | Engineering Origin: FA4's Four-Layer Truth Gate

> **Maturity:** SETTLED (engineering method validated)
> **Corresponding source section:** Part I (the correct engineering solution grown out of the FA4 problem)

---

## 2.1 Surface Problem: FA4 Is Hard to Fix

On the surface, FA4 is a CUDA / FP4 / Flash Attention problem. The state observed at the time included:

```
ERR grows
PPL degrades
native FP4 nb=1 does not pass
mixed FP4 uncertain
nb>1 uncertain
binary/source may be inconsistent
fallback may sneak through
probe may contaminate the scene
agent may see suspicious code and randomly patch
```

From a traditional debugging perspective, it looked like "which line of CUDA is wrong? rowsum? writeback? dispatch? V accumulation? MMA_FP4? lane mapping?"

But the truly deeper problem is:

> **Before proving whether the current execution is on the correct route, all numeric reasoning, patches, quality tests, and performance tests may be false.**

---

## 2.2 Four-Layer Truth Gate

The final correct progression order for FA4 was converged into four layers:

```
Gate 1: Route Truth
Gate 2: Numeric Truth
Gate 3: Quality Truth
Gate 4: Performance Truth
```

These four layers cannot substitute for one another, nor can they skip steps.

---

## 2.3 Gate 1: Route Truth

Route Truth asks only one thing: **Did this execution actually follow our designated FA4 S Track?**

It does not ask whether the numbers are correct. It first confirms:

1. binary/source/hash alignment
2. clean build exists
3. native FP4 nb=1 actually enters the target CUDA route
4. allowed route entry checkpoint exists
5. allowed route exit checkpoint exists
6. mixed FP4 is fail-closed
7. nb>1 is unsupported / fail-closed
8. fallback is excluded
9. vec false route is not mistaken for native FP4 success
10. stale binary is excluded

If this gate is not passed, entry into Numeric Truth is not permitted. Before Route Truth is passed, rowsum, writeback, p_all, MMA score, softmax recurrence, V accumulation must not be discussed—because if the route has not been proven, numeric analysis may all be on the wrong route.

---

## 2.4 Gate 2: Numeric Truth

Numeric Truth is performed only on the S Track that Gate 1 has proven.

Its task is not to guess root cause, but to find **FIRST_DIVERGENCE**:

```
FIRST_DIVERGENCE_STAGE
FIRST_DIVERGENCE_FILE
FIRST_DIVERGENCE_FUNCTION
FIRST_DIVERGENCE_BLOCK
FIRST_DIVERGENCE_VALUE
```

The checkpoints for Numeric Truth should include:

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

Each station must output: stage, file, function, block, tile, logical_row, logical_col, actual_gpu, expected_oracle, abs_error, rel_error, PASS/FAIL.

**Without FIRST_DIVERGENCE_TABLE, no patching.**

---

## 2.5 Gate 3: Quality Truth

Only after Numeric Truth passes does Quality Truth begin.

Quality Truth asks: **After the fix, is model quality maintained or improved?**

- Is PPL regressed or improved?
- Are downstream tasks affected?
- Is numerical correctness consistent across different configurations?
- Does the fix introduce new numerical instability?

---

## 2.6 Gate 4: Performance Truth

Only after Quality Truth passes does Performance Truth begin.

Performance Truth asks: **After the fix, does performance meet the target?**

- Is latency within budget?
- Does throughput meet the target?
- Is performance consistent across different hardware configurations?
- Is the performance improvement built on correct numerics and quality?

---

## 2.7 Key Engineering Principle

```
Route Truth precedes Numeric Truth
```

The order of these four gates is not a suggestion, but a **hard threshold**. Any step-skipping will lead to false success: performance on the wrong route fixed, tests on the wrong route passed, beautiful reports on the wrong route produced.

This engineering principle is the **empirical foundation** of the entire Upward/Downward Model framework.
