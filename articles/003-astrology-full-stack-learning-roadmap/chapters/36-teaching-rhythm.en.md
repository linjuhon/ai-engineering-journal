[← Back to technical index](../TECHNICAL_INDEX.en.md) | **English** | [繁體中文](36-teaching-rhythm.md)

---

# 6. Practical Teaching Rhythm

Do not read the entire roadmap all at once. Advance only one chapter at a time, using this consistent rhythm:

1. First, answer an opening question in your own words.
2. I fill in the mental model and provide one minimal example.
3. You decide which folder the data belongs in.
4. Together, we build 10–50 lines of minimal code.
5. You predict its output or failure.
6. Then we integrate the next software layer.
7. Finally, we do one “teach it back to me” exercise and a brief acceptance check.

## The First Implementation Spine

For the first pass, do not touch Kubernetes, Pinecone, Neo4j, or TensorFlow. Complete this first:

```text
React BirthForm
  → RTK Query
  → Express POST /v1/charts
  → contract validation
  → FastAPI /v1/celestial/calculate
  → Swiss Ephemeris adapter
  → PostgreSQL job record
  → Redis progress cache
  → React report page
  → Prometheus metric + OpenTelemetry trace
```

After you complete this spine, you will truly have an extensible skeleton; otherwise, learning seven databases at the same time will only leave you with seven disconnected examples.
