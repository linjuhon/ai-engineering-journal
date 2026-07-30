[← 回到文章總覽](../../README.md)

---

# 占星系統全技術棧深度學習與研究總綱

> **文章類型：** Long-form Research Curriculum  
> **成熟度：** 章節化長程學習路線；各技術棧的完成狀態應由程式碼、測試與執行紀錄證明。
> **定位：** 把占星平台的架構意圖拆成能定位到檔案、能執行、能測試、能追蹤、能回滾的完整學習路線。  
> **閱讀方式：** 內容很長，已按技術棧拆成獨立章節，避免單一 Markdown 超過可讀範圍。
>
> **關聯文章：** 本路線圖的產品架構基礎為 [Article 002](../002-astrology-system-architecture/)（九階段系統）；核心智能的深度施工規格請參閱 [Article 006](../006-astrology-truth-narrative-system/)（A–E 真理—敘事共生系統）。



## 課程設計原則

這套總綱不是 API 名詞表。每章固定要求心智模型、檔案位置、最小代碼、生命週期、資料契約、跨服務對應、測試、可觀測性、反例與技術債，最後要求能用自己的話教回來。

## 全部章節

- [00｜軟體工程與系統基礎（先修）](chapters/00.md)
- [01｜樹狀代碼庫與 Monorepo 架構](chapters/01.md)
- [02｜TypeScript](chapters/02.md)
- [03｜Node.js](chapters/03.md)
- [04｜Express](chapters/04.md)
- [05｜TypeORM](chapters/05.md)
- [06｜Python](chapters/06.md)
- [07｜FastAPI](chapters/07.md)
- [08｜NumPy](chapters/08.md)
- [09｜Astropy](chapters/09.md)
- [10｜Swiss Ephemeris](chapters/10.md)
- [11｜TensorFlow](chapters/11.md)
- [12｜Transformers／Hugging Face](chapters/12.md)
- [13｜React](chapters/13.md)
- [14｜Redux Toolkit／RTK Query](chapters/14.md)
- [15｜Ant Design](chapters/15.md)
- [16｜PostgreSQL](chapters/16.md)
- [17｜MongoDB／Mongoose](chapters/17.md)
- [18｜Redis／ioredis](chapters/18.md)
- [19｜Elasticsearch](chapters/19.md)
- [20｜Pinecone／向量資料庫](chapters/20.md)
- [21｜Neo4j](chapters/21.md)
- [22｜TimescaleDB](chapters/22.md)
- [23｜Docker](chapters/23.md)
- [24｜Kubernetes](chapters/24.md)
- [25｜Prometheus](chapters/25.md)
- [26｜Grafana](chapters/26.md)
- [27｜Jaeger／OpenTelemetry](chapters/27.md)
- [28｜GitHub Actions](chapters/28.md)
- [29｜Handlebars／自動文檔處理器](chapters/29.md)
- [30｜測試棧：Jest／Supertest／Playwright](chapters/30.md)
- [31｜GraphQL／WebSocket／Socket.IO](chapters/31.md)
- [32｜Nginx／反向代理與 API Gateway](chapters/32.md)
- [33｜代碼品質：ESLint／Prettier／Husky／SonarQube](chapters/33.md)
- [34｜跨軟體整合（40 章）](chapters/34.md)
- [35｜九階段占星系統落地（36 章）](chapters/35.md)
- [六、實際教學節奏](chapters/36-teaching-rhythm.md)
- [七、第一課：先看懂一筆資料到底怎麼走](chapters/37-first-lesson-data-flow.md)
- [八、第一課自我檢查](chapters/38-first-lesson-checklist.md)

## 狀態聲明

這是一份研究與學習總綱。它描述預計掌握與驗證的能力，不等同於所有技術棧已完成實作或部署；每一章的完成狀態仍應由程式碼、測試、執行紀錄與可重現結果證明。

**版本：** 2026-07-30
