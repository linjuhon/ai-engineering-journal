[← 回到技術索引](../TECHNICAL_INDEX.md) | [English](36-teaching-rhythm.en.md) | **繁體中文**

---

# 六、實際教學節奏

不要一次讀完整份總綱。每次只推進一章，節奏固定為：

1. 你先用自己的話回答一個起始問題。
2. 我補齊心智模型與一個最小範例。
3. 你判斷資料應放在哪一個資料夾。
4. 我們一起建立 10–50 行的最小程式碼。
5. 你預測它的輸出或故障。
6. 再串接下一層軟體。
7. 最後做一次「你教我」與小型驗收。

## 第一條實作主線

第一輪不碰 Kubernetes、Pinecone、Neo4j、TensorFlow。先完成：

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

這條線完成後，你才真正擁有一個可以擴充的骨架；否則同時學七種資料庫只會得到七個互不相連的範例。
