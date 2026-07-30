# Source Manifest / 來源清單

## English

- **Original file:** [`original-complete-spec.docx`](original-complete-spec.docx)
- **English derivative:** [`original-complete-spec.en.md`](original-complete-spec.en.md)
- **Role:** Original integrated specification and reasoning history
- **Canonical specification:** No
- **Canonical Markdown version:** The chapters and appendices in the parent directory
- **Generated date:** 2026-07-30
- **Source material:** Consolidated multi-turn discussions covering the progressive A–E architecture, cold start, and governance mechanisms
- **Original SHA-256:** `392EF20929A4F9B086489C7C8171964BF7E5064EA40C484B91E96F4DA9BCCB8C`

### Known Superseded Sections

- Step 5 (hard enforcement across all 100 C dimensions) is revised in [`06-control-plane-100d.md`](../06-control-plane-100d.md) to observe all dimensions but hard-enforce only a subset.
- Step 9 (5,000 Few-Shot examples) is revised in [`05-cold-start-and-training.md`](../05-cold-start-and-training.md) to begin cold start with a smaller dataset.
- Step 10 (enabling deduplication markers from day one) is revised in [`04-runtime-pipeline.md`](../04-runtime-pipeline.md) to conditional activation.
- Step 14 (early B self-distillation) is revised in [`05-cold-start-and-training.md`](../05-cold-start-and-training.md) to wait for 2,000 works scoring 80+.
- Step 18 (early 1024-dimensional injection) is revised in [`08-semantic-bridge-1024d.md`](../08-semantic-bridge-1024d.md) to wait for 5,000 aligned pairs.

### Notes

- The original DOCX preserves the complete reasoning history for Steps 0–20; later discussions supersede some proposals.
- The original DOCX remains unchanged. The English Markdown file is a noncanonical derivative.
- The formal Markdown chapters take precedence when implementation details conflict with the DOCX.

---

## 繁體中文

- **原始檔案：** [`original-complete-spec.docx`](original-complete-spec.docx)
- **英文衍生版：** [`original-complete-spec.en.md`](original-complete-spec.en.md)
- **角色：** 原始整合規格與推論歷程
- **正式規格：** 否
- **正式 Markdown 版本：** 上層各章節與附錄
- **產生日期：** 2026-07-30
- **來源材料：** 多輪對話整合、A–E 架構逐步推演、冷啟動與治理機制討論
- **原始檔 SHA-256：** `392EF20929A4F9B086489C7C8171964BF7E5064EA40C484B91E96F4DA9BCCB8C`

### 已被後續規格取代的段落

- Step 5（C 的 100 維全部硬執法）由 [`06-control-plane-100d.md`](../06-control-plane-100d.md) 修正為「全部觀測、少數硬執法」。
- Step 9（5,000 個 Few-Shot）由 [`05-cold-start-and-training.md`](../05-cold-start-and-training.md) 修正為冷啟動先採較小資料集。
- Step 10（去過標記從第一天啟用）由 [`04-runtime-pipeline.md`](../04-runtime-pipeline.md) 修正為條件啟用。
- Step 14（B 自蒸餾可早期啟動）由 [`05-cold-start-and-training.md`](../05-cold-start-and-training.md) 修正為延後至累積 2,000 篇 80 分以上佳作。
- Step 18（1024 維注入可早期啟動）由 [`08-semantic-bridge-1024d.md`](../08-semantic-bridge-1024d.md) 修正為延後至累積 5,000 組對齊資料。

### 備註

- 原始 DOCX 保留 Steps 0–20 的完整推論歷程，部分方案已由後續討論修正。
- 原始 DOCX 保持不變；英文 Markdown 是非正式衍生版。
- 若 Markdown 與 DOCX 的實作細節衝突，以正式 Markdown 章節為準。
