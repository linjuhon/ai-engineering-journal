[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](08-problem-design.md)

---

# 08｜Reverse Problem Design

> **Maturity:** PROVISIONAL (problem type defined; work-order generation requires experimentation)
> **Corresponding source section:** Part VIII + IX (Problems must also be reverse-designed; how to generate work orders)

---

## 8.1 Engineering Problems Need the Upward Model More

Chess is a toy domain. The real value of the upward model is shown in engineering problems:

- Engineering problems have a defined route (correct execution path)
- Engineering problems have defined gates (truth gate order)
- Engineering problems have defined evidence (binary, log, test result)
- Engineering problems have defined false success modes (fixing the wrong route, tests passing)

---

## 8.2 Engineering Upward Problem Types

### Claim Audit Problem

**Input:** A claim + related evidence

**Task:** Determine whether the claim is supported by the evidence

- Claim has evidence bound? → PASS
- Claim has no evidence bound? → FAIL + flag missing evidence
- Claim contradicts evidence? → FAIL + flag contradiction type

### Gate Classification Problem

**Input:** An execution trace + current state

**Task:** Determine which truth gate the system is currently at

- Has Route Truth been passed?
- Has Numeric Truth been passed?
- Has Quality Truth been passed?
- Has Performance Truth been passed?

### Evidence Mapping Problem

**Input:** A result + a set of candidate evidence

**Task:** Map the result to the corresponding evidence

- Which evidence supports this result?
- Which evidence contradicts this result?
- Which evidence is missing?

### Forbidden Action Problem

**Input:** An action plan + purpose vector

**Task:** Determine whether the plan contains forbidden actions

- Is the plan patching before Route Truth?
- Is the plan optimizing before Numeric Truth?
- Does it use a forbidden route?

### Dispatch Problem

**Input:** Current state + uncertainty assessment

**Task:** Decide the next dispatch

- Continue on the current route?
- Switch to another route?
- Collect more evidence?
- Abstain + report uncertainty?

---

## 8.3 Work-Order Generation

The real challenge is not "designing problems," but **automatically generating work orders**.

Work order = task description + purpose vector + constraints + evidence requirements + acceptance criteria

Work-order generation strategies:

1. **Generate from real engineering traces**: Record real debugging processes, extract key decision points
2. **Generate from failure cases**: Analyze agent failure cases, convert into training work orders
3. **Generate from divergence samples**: Cases where D↓ and U↑ diverge, convert into divergence classification work orders

---

## 8.4 Reverse Database

A reverse database is a **dataset that looks backward from results to intent**:

- Given code + execution result → reverse-engineer the original purpose
- Given a patch + review result → reverse-engineer the root cause hypothesis
- Given a trace + final state → reverse-engineer the decision chain

The reverse database is the core resource for training the upward model.

---

## 8.5 Trace Decompilation

Trace decompilation is **reconstructing intent from an execution trace**:

- Tool call sequence → decision tree
- Decision tree → purpose hypothesis
- Purpose hypothesis → purpose vector

Trace decompilation enables the upward model to infer "why it was done" from "what was done."
