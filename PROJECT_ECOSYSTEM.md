# Project Ecosystem / 專案關係與導覽

[English summary](#english-summary) | [繁體中文](#繁體中文)

## 繁體中文

這些資料夾不是六個彼此競爭的專案，而是四類成果，加上兩個本機工作副本。
整理原則是：**GitHub 依成果責任分庫，Journal 統一導覽；同一份大型資料不重複複製。**

### 一眼看懂它們的關係

```text
AI Engineering Journal
├─ 說明理念、方法、文章與整體作品關係
├─ Local Code Intelligence Toolkit
│  └─ 可安裝、可測試、可獨立使用的程式工具
├─ AI Collaboration Forensics
│  └─ 從 AI 協作紀錄整理流程、方法與技術候選
└─ TRI-100R Reconstruction
   ├─ 正式重建成果與三份最終文件
   ├─ extreme-optimization-reconstruction：早期開發現場
   └─ tri100r-clean-06d2d4f：指定提交的乾淨驗證副本
```

### 各資料夾的責任

| 名稱 | 真正角色 | 是否獨立 GitHub 專案 | 應採用的版本 |
|---|---|---:|---|
| `ai-engineering-journal` | 整體理念、文章與作品導覽 | 是 | `main` |
| `local-code-intelligence-toolkit` | 本機程式碼索引與 AI 查詢工具 | 是 | 產品 repo 的 `main`／release |
| `ai-collaboration-forensics` | 跨專案聊天鑑識、方法論與研究成果 | 是 | 經 allowlist 產生的發布候選，不是整個本機工作區 |
| [`tri-100r-rebuild`](https://github.com/linjuhon/tri-100r-reconstruction) | TRI-100R 正式重建成果 | 是 | 提交 `06d2d4f` 的發布樹 |
| `extreme-optimization-reconstruction` | TRI-100R 早期 packet 流程與仍未提交的開發現場 | 否 | 保留本機，不當正式發布版本 |
| `tri100r-clean-06d2d4f` | TRI-100R 提交 `06d2d4f` 的乾淨驗證副本 | 否 | 僅供比對、驗收與復現 |

### 為什麼不合成一個大 repo

1. Journal 是人類閱讀的總入口；LCI 是可執行工具；Forensics 與 TRI-100R 是大型研究證據。它們的使用方式、版本週期與審核標準不同。
2. 把大型語料或重建資料複製進 Journal，會造成兩份內容、兩套雜湊和兩個真相來源。
3. TRI-100R 的開發現場目前仍有未提交內容。直接搬進別的 repo，會混淆「正式成果」與「尚未封存的工作」。
4. 乾淨 clone 是驗收工具，不是新產品。另開 repo 只會讓同一成果出現兩次。

### 單一真相來源

- 作品關係與閱讀順序：本 Journal。
- LCI 程式碼、測試與版本：`local-code-intelligence-toolkit` repo。
- AI 協作研究公開內容：`ai-collaboration-forensics` 的 allowlist 發布樹。
- TRI-100R 正式成果：`tri-100r-rebuild` 的提交 `06d2d4f`；乾淨副本只能用來驗證它。
- TRI-100R 舊 packet 流程和未提交檔案：只留在本機開發現場，直到另行封存。

### 發布與收納規則

- 各 repo 只保留自己負責的內容，使用連結互相導覽。
- 新內容先進功能分支與 draft PR，審核後才合併。
- 不把本機快取、虛擬環境、資料庫、工具輸出、未去識別語料或驗證 clone 推上 GitHub。
- 本機資料夾可以移入共同父資料夾，但移動 Git worktree 前必須先修復並驗證 Git 路徑；不能直接用檔案總管拖曳。
- 有未提交內容的資料夾不得刪除、覆寫或當成乾淨發布來源。

## English summary

These folders represent four deliverables plus two local working copies:

- **AI Engineering Journal** is the human-readable portfolio and navigation hub.
- **Local Code Intelligence Toolkit** is an independently versioned software product.
- **AI Collaboration Forensics** is the deidentified collaboration evidence and research repository.
- **TRI-100R Reconstruction** is a dedicated reconstruction deliverable.
- **extreme-optimization-reconstruction** is an older, currently dirty development workspace.
- **tri100r-clean-06d2d4f** is only a clean verification clone of the TRI-100R release commit.

The repositories stay separate because they have different users, release cycles, evidence
boundaries, and file sizes. The Journal links them together without duplicating their source
or research corpora.
