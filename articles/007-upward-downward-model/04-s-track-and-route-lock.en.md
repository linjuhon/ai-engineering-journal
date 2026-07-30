[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](04-s-track-and-route-lock.md)

---

# 04 | S Track, Route Lock, and State Lock

> **Maturity:** SETTLED (engineering concepts validated)
> **Corresponding source section:** Part III (S Track concept)

---

## 4.1 Do Not Probe Freely—Seal the Route First

Traditional debugging follows a “free-form probe insertion” mindset: add print statements everywhere, test everywhere, and guess everywhere. Experience with FA4 shows that, in complex systems, free-form probe insertion can:

- contaminate the execution state (probe side effects)
- generate false leads (bugs in the probe itself)
- spread attention too thin (too many candidate root causes)

The correct approach is to **seal the route first**: prove which routes are correct and which are incorrect, then insert probes only along the correct route.

---

## 4.2 S Track

The S Track is **the only permitted correct execution path**. It is defined by the following conditions:

- an explicit entry checkpoint (entry condition)
- an explicit exit checkpoint (exit condition)
- an explicit intermediate station (observable point)
- explicit fallback exclusion rules
- explicit false-route exclusion rules

Before the S Track is proven, all numeric analysis is premature.

---

## 4.3 Route Lock

Route Lock is a **route-sealing mechanism**: it locks execution to the S Track and excludes every other route.

The conditions for Route Lock are:

1. binary/source/hash alignment
2. a clean build exists
3. the target route is proven to be executing
4. the non-target route is proven not to be executing
5. fallback has been ruled out
6. stale binary has been ruled out

Once Route Lock is established, all subsequent analysis is performed along this locked path.

---

## 4.4 State Lock

State Lock is a **state-locking mechanism**: it ensures that the system state is not changed accidentally during analysis.

The conditions for State Lock are:

1. input data is fixed
2. model weights are fixed
3. environment parameters are fixed
4. hardware configuration is fixed
5. random seed is fixed

State Lock ensures that every run is reproducible. Without State Lock, it is impossible to distinguish between “the repair worked” and “random variation.”

---

## 4.5 Reference Contract

Reference Contract is a **correct-execution contract**: it explicitly defines what qualifies as “correct execution.”

- the correct input format
- the correct execution order
- the correct range for intermediate results
- the correct output format
- the correct baseline for oracle comparison

Reference Contract is the basis on which the Upward Model determines “whether execution has deviated from the purpose.”

---

## 4.6 After Route Sealing, the Probe-Insertion Problem Is Reduced in Scope

Once the S Track is locked, the state is locked, and the contract is defined, the probe-insertion problem is reduced from “searching everywhere for the root cause” to “finding the first divergence along a known path.”

This is precisely the engineering value of the four-layer Truth Gate: **it does not restrict debugging; it transforms debugging from a blind search into precise localization.**
