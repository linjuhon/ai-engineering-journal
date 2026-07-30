[← Back to technical index](TECHNICAL_INDEX.en.md) | **English** | [繁體中文](03-data-engineering.md)

---

# 03 | Data Engineering

> **Maturity:** PROVISIONAL (Six-layer model architecture finalized; specific schemas and thresholds require experimental validation)
> **Corresponding DOCX Section:** 11

---

## 3.1 Six-Layer Data Model

When spanning 20+ schools, data boundaries, indexing, and chain of evidence take precedence over parameter count.

| Layer | Content | Immutable | Purpose |
|-------|---------|-----------|---------|
| **Raw** | Original text, source, time, license, author | No cleaning may overwrite | Original evidence |
| **Normalized** | Structured chart, unified terminology, missing values, time and timezone | Preserve Raw pointer | Normalization |
| **Boundary** | Tradition, school, task, time scale, region, usage prerequisites | No silent cross-school averaging | Boundary governance |
| **Label** | Truth granularity, causal clarity, evidence level, uncertainty, escape risk | Preserve annotator and version | Quality labeling |
| **Split** | train/validation/test/OOD; leave out by configuration combination and tradition | No pure random split | Experiment isolation |
| **Model Views** | A Truth View, B Demapped View, C Score Pair, D Adjudication Case, E Alignment Pair | Views must not back-contaminate | Model-specific |

---

## 3.2 Index Structure per Record

```yaml
record_id: str
source_id: str
source_version: str
license: str
tradition: str          # e.g. Western, Vedic, Chinese
school: str             # e.g. Hellenistic, Modern, Jyotish
lineage: str            # e.g. Lilly, Ptolemy
chart_type: str         # natal/transit/synastry/solar-return/electional
task: str               # career/relationship/health/wealth/spirituality
time_scale: str         # year/month/day/hour
difficulty: str         # easy/moderate/hard/rare
rarity: str             # common/uncommon/rare
OOD_tags: list[str]     # tags that may indicate OOD
structured_input_hash: str
answer_type: str        # truth_report | image_seed | story | feedback | adjudication
causal_units: list
claims: list
uncertainty: list
quality_labels: dict
escape_labels: dict
safety_labels: dict
split_id: str
model_views: dict
created_at: datetime
normalized_at: datetime
reviewer: str
review_version: str
```

---

## 3.3 Correct Definition of Duplication

### Conceptual Duplication (Necessary)

The same archetype appearing repeatedly across different houses, aspects, schools, and tasks is how the model learns invariants. For example, "Sun in Aries" appearing in career readings and relationship readings is necessary duplication.

### Instance Replication (Dangerous)

The same structured input and the same output must not appear multiple times. Similar templates require MinHash, embedding, or rule-based deduplication.

### Customer Preference Weighting

Multiple preferences from the same customer must not be weighted infinitely, or C will learn a single person's emotional model. Recommended strategies:

- Time decay: recent preferences weighted higher, historical preferences decayed
- Count cap: each customer contributes at most N preference records
- Diversity check: preference distribution must cover multiple schools and tasks

### Cross-School Vocabulary

The same term across different schools does not represent the same concept. For example, "Mars" has different interpretations in Western astrology and Vedic astrology. Vocabulary unification must preserve `tradition_id` and cannot rely solely on text normalization.

---

## 3.4 20+ School Index

The system must support at least the following schools:

| School Group | Includes |
|--------------|----------|
| Western Classical | Hellenistic, Medieval, Renaissance |
| Western Modern | Modern, Psychological, Evolutionary |
| Vedic | Jyotish (South/North Indian) |
| Chinese | Ziwei Doushu, Bazi (Four Pillars), Qizheng Siyu (Seven Luminaries and Four Remnants) |
| Other | Arabic, Celtic, Maya |

Each school requires:

- School ID, name, lineage
- Core texts and authors
- House system used, aspect rules, orbs
- Boundaries with other schools (which concepts must not be mixed)

---

## 3.5 Task Classification

| Task Type | Input | Output | Special Requirements |
|-----------|-------|--------|---------------------|
| Natal Reading | Birth time + location | Personality analysis, life themes | Most common, multi-school support required |
| Transit Prediction | Natal + current time | Time windows, trends | Requires time-series data |
| Synastry | Two charts | Relationship patterns | Requires paired data |
| Electional | Time range + goal | Best time | Requires event outcome validation |
| Solar Return | Natal + return year | Annual theme | Requires annual feedback |

---

## 3.6 OOD Holdout Strategy

- **By school holdout:** Training set includes schools A–D, test set is school E
- **By task holdout:** Training set includes natal and transit, test set is synastry
- **By difficulty holdout:** Training set includes simple and moderate cases, test set is rare configurations
- **By time holdout:** Training set is earlier data, test set is recent data

The goal of OOD testing is not "the model performs well on OOD," but "the model knows it is in an OOD state."

---

## 3.7 Model-Specific Data Views

| View | Content | Prohibited |
|------|---------|------------|
| **View A** | Structured input + auditable truth report; preserves causality, boundaries, and uncertainty | No narrative text |
| **View B** | Removes direct symbol → fixed imagery mapping; may include Chinese narrative material | Source and license must be separated |
| **View C** | A/B pair + 100-dimensional human/rule annotation + traffic light result + uncertainty | No raw user data |
| **View D** | A summary + B full text + C yellow lights + human final adjudication; includes unmodified cases | No unadjudicated proposals |
| **View E** | High-quality A–B alignment pairs, hard negatives, multiple valid B for the same A | No low-quality pairs |

---

## 3.8 Data Governance Rules

- **Raw layer must not be overwritten:** No cleaning, normalization, or annotation may modify the Raw layer
- **Views must not back-contaminate:** View B data must not be used to train A
- **License traceability:** Every record retains its source license; data under different licenses must not be mixed
- **Version management:** Dataset version is bound to model version; training results must be reproducible
