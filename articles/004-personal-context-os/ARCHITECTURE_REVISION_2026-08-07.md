[← 回到 Article 004](README.md) | [English](ARCHITECTURE_REVISION_2026-08-07.en.md) | **繁體中文**

---

# Personal Context OS V2 架構修訂

## Canonical Context × Skill Federation × Pi Runtime Kernel

**日期：** 2026-08-07  
**狀態：** Accepted Architecture Revision  
**作用：** 本文件是 2026-07-30 `FULL_ARTICLE.md` 的增量修訂，不刪除 V1；V1 保留為設計演化基線。本文件在「Skill 分層、第三方 Skill 相容、Pi 完全體定位、上下升格／下放、資料契約」等議題上優先於 V1。

> **新的核心結論：** Personal Context OS 不應擁有所有 Skills。它應擁有「什麼是目前正式狀態、誰有權修改、哪些能力應被啟動、能力產物能否升格、以及正式約束如何下放成可執行 Gate」的控制權。
>
> **Skills 是能力；Context OS 是讓能力在正確現實狀態下工作的控制平面。**

---

# 1. 為什麼需要 V2

V1 正確抓到了長期 AI 協作最危險的問題：聊天歷史不是單純太短，而是缺乏目的、完成標準、底線、版本、衝突與權威管理。V1 因此把 Purpose、Criteria、Boundary、State、Plan、Decision、Hypothesis、Interaction、Method、Evidence 都描述成不同類型的 Skills。

這個模型在封閉系統內可行，但接上成熟的 Agent Skill 生態後會產生語義過載：

1. **正式狀態與程序能力被叫做同一種 Skill。**「這個專案禁止改 benchmark」與「如何做 TDD」本質上不是同一種物件。
2. **Evidence 被當成 Skill 不自然。**測試、Git、ADR、文件與工具結果是在支持判斷，不是「如何做事」的能力。
3. **第三方 Skill 可能自己產生 context/spec/ADR。**如果這些產物直接等同 Context OS 的正式狀態，就會產生多個 Source of Truth。
4. **成熟 Skill 會形成 primitive → workflow → composite 的內部層級。**Context OS 不應重新包裝或重寫這些能力。
5. **Pi 的 SDK 與 Extension 能力足以承載完整產品。**因此 Pi 不應只被描述成 Coding Adapter；更合理的定位是完整體的 reference runtime kernel，同時保留領域層抽象邊界。

這次修訂不是推翻 V1，而是把 V1 中「所有長期資訊都統一叫 Skill」的過度統一拆開。

---

# 2. V1 中保持不變的核心不變量

以下原則不因 V2 改變：

- **當前訊息擁有焦點權。**舊背景不能因內容豐富而搶走本輪問題。
- **Purpose / Criteria / Boundary 不能被模型無聲改寫。**重大變更屬於使用者決策權。
- **tentative / hypothesis 不能冒充 confirmed。**
- **Clerk 仍是中央紀事與校正角色。**
- **Question Gate 依決策所有權而不是單純不確定度。**
- **Execution Spec 是正式執行前的凍結契約。**
- **完成必須靠證據，而不是模型自述。**
- **回饋必須形成可回放 eval。**

因此 V2 是邊界重構，不是理念轉向。

---

# 3. 四個 Plane：新的完整資料與責任模型

```text
                    Current Turn
                         │
                         ▼
┌──────────────────────────────────────────────┐
│ 1. Governance Plane                         │
│ authority / scope / conflict / promotion   │
│ approval / lifecycle / execution policy    │
└──────────────────────┬───────────────────────┘
                       │
┌──────────────────────▼───────────────────────┐
│ 2. Canonical Context Plane                  │
│ Purpose / Criteria / Boundary               │
│ State / Plan / Decision / Hypothesis        │
│ Interaction Policy                          │
└──────────────────────┬───────────────────────┘
                       │ Context Envelope
                       ▼
┌──────────────────────────────────────────────┐
│ 3. Capability / Skill Plane                 │
│ internal / Pi / third-party / community     │
│ primitive → workflow → composite            │
└──────────────────────┬───────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────┐
│ 4. Evidence / Runtime Plane                 │
│ AgentSession / tools / tests / Git / ADR    │
│ artifacts / logs / documents / results      │
└──────────────────────────────────────────────┘
```

## 3.1 Governance Plane

它回答的不是「怎麼做」，而是：

- 誰有權修改這個值？
- 這個修正只適用本輪、專案、領域，還是全域？
- 新舊要求是否衝突？
- 第三方產物能否升格成正式狀態？
- 哪個動作可以直接執行，哪個必須阻斷詢問？
- 哪些下層工具行為應被 Execution Gate 禁止？

## 3.2 Canonical Context Plane

這裡保存「現在什麼仍然有效」，不是保存所有發生過的聊天。

核心物件：

- Purpose
- Criteria
- Boundary
- Current State
- Active Plan
- Confirmed Decision
- Tentative / Hypothesis
- Interaction Policy

它們可以繼續用可讀 Markdown＋Git 管理，但語義上不再與程序型 Agent Skill 混用。

## 3.3 Capability / Skill Plane

這層才是真正的 Agent Skills：

- primitive：單一可重用能力。
- workflow：把多個 primitive 串成流程。
- composite / domain skill：在特定領域組合方法、工具與參考資料。

來源可以是 Context OS 內建、Pi、第三方 repository、社群或專案本地 Skill。

## 3.4 Evidence / Runtime Plane

這層保存「發生了什麼」與「有什麼能支持判斷」：

- Session / tool trace
- Git diff / commit
- test result
- logs
- spec / ADR / CONTEXT.md
- code / video / document / image artifact
- external research evidence

Evidence 可以支持 Canonical Context 的更新，但沒有自動修改權。

---

# 4. V1 十種 Skill 的重新歸位

| V1 類型 | V2 位置 | 原因 |
|---|---|---|
| Purpose | Canonical Context | 正式目的，不是能力 |
| Criteria | Canonical Context | 正式驗收契約 |
| Boundary | Governance + Canonical Context | 具有禁止、授權與衝突效果 |
| State | Canonical Context | 描述目前真實狀態 |
| Plan | Canonical Context | 描述目前採用路線 |
| Decision | Decision Ledger | 保存確認過的取捨與取代理由 |
| Hypothesis | Canonical Context（非 confirmed） | 保持認知狀態 |
| Interaction | 拆分 | 全域互動政策上放；程序訪談方法下放 |
| Method | Capability Skill | 方法與能力 |
| Evidence | Evidence Plane | 支持判斷，不是能力 |

> **不是所有正式長期資訊都需要叫 Skill。它們需要被治理，但不需要被塞進同一種物件。**

---

# 5. Skill Federation：兼用，而不是取代

Personal Context OS 的完整體要預留 Federation 層，允許不同 Skill 生態並存。

```text
skills/
├── system/
├── internal/
├── project/
└── external/
    ├── aihero/
    ├── pi/
    ├── vendor-a/
    └── community/
```

## 5.1 External Skill Non-Overwrite Principle

Context OS 對第三方 Skill **可以**：

- discover
- index
- classify
- route
- invoke
- 傳入 Context Envelope
- 限制可用工具與執行範圍
- 收集輸出與 artifact
- 評估結果
- 提出 wrapper 或 patch 建議

但預設**不可以**：

- 自動重寫第三方原始 Skill
- 因 Context OS 有類似方法就覆蓋它
- 把 Skill 內容吸入全域 Prompt 當唯一版本
- 把 Skill 的推論直接升為 Canonical State
- 為了統一資料模型而改掉第三方 Skill 自己的 primitive/workflow 結構

第三方 Skill 的 source、version、namespace 必須可追溯。

---

# 6. 成熟 Skill 生態作為驗證案例

本修訂不依賴任何特定第三方 Skill，但成熟 Skill 生態已顯示出幾個值得保留的模式：

- 共用 interview primitive 可被多個上層 workflow 重用。
- planning、spec、tickets、implement、review 可以是不同職責的 Skill。
- Skill 可以自己產生 `CONTEXT.md`、ADR、spec、tickets 等持久 artifact。
- 某些 Skill 應由使用者明確啟動，不必全部由模型自動觸發。

這說明 Context OS 不應重新發明成熟程序能力；它應處理更上一層的問題：**哪個能力現在應被啟動、帶什麼正式上下文、結果能改什麼，以及衝突時誰有最後決策權。**

---

# 7. 第三方 CONTEXT.md / ADR / Spec 不能自動成為 Canonical State

```text
Third-party Skill
      ↓
produces CONTEXT.md / ADR / spec
      ↓
SkillArtifact
source = external/<namespace>
      ↓
Clerk extracts candidate changes
      ↓
Diff against Canonical Context
      ↓
ContextPatch Proposal
      ↓
Promotion Gate
      ├─ reversible / derived fact → 驗證後更新
      └─ purpose / boundary / major decision → 使用者批准
      ↓
Canonical Context
```

第三方產物可以是很好的證據與提案，但不能因為檔名叫 `CONTEXT.md` 就自動取得治理權。

---

# 8. 雙路啟動：Canonical Context 與 Capability Skill

## 8.1 Canonical Context Activation

Purpose、Criteria、Boundary、Current State 等由 Context Router 主動選取；不能期待主模型自己想起來。

- 當前訊息：焦點權
- confirmed Purpose / Criteria / Boundary：規格權
- State / history：理解權

## 8.2 Capability Skill Activation

方法型 Skill 允許 progressive disclosure：

```text
Skill index / explicit command / workflow dependency
          ↓
select capability
          ↓
load full skill only when needed
          ↓
invoke primitive/workflow
```

Context OS 路由與提供乾淨 Context Envelope，不把所有方法型 Skill 每輪全文塞入。

---

# 9. Pi 的新定位：Reference Application Kernel

V1 把 Pi / OpenCode / Codex 放在 Executor Gateway 後面。V2 對 Pi 的定位升級：

```text
Personal Context OS
├── UI
├── Context Domain
├── Governance
├── Skill Federation
├── Clerk
├── Context Compiler
├── Evals
└── Pi Runtime Kernel
    ├── AgentSession
    ├── ModelRuntime
    ├── ResourceLoader
    ├── Extensions
    ├── Tools
    └── Session Events
```

完整體可以直接是一個 **Pi SDK Application**。

但 Canonical Context 不應等於 Pi Session，Context Domain 也不應使用 Pi 內部型別來定義真實世界語義。

## 9.1 AgentRuntime 邊界

```ts
interface AgentRuntime {
  createSession(config: SessionConfig): Promise<RuntimeSession>;
  run(packet: ContextPacket): Promise<RunResult>;
  abort(sessionId: string): Promise<void>;
}
```

reference implementation 可以只有 `PiAgentRuntime`。

> **Context OS 可以完整建立在 Pi 上；但 Context OS 的真實世界語義不能被 Pi 的內部資料結構定義。**

---

# 10. 多 Session 完全體

| Session | 可見資料 | 工具 | 職責 |
|---|---|---|---|
| Chat Session | Current Turn + Context Envelope | chat/research | 討論、分析、創作 |
| Clerk Session | recent turns + canonical targets | read + structured output | 抽取、比對、Patch、Conflict |
| Execution Session | frozen ExecutionSpec | gated coding/tools | 實際工作 |
| Review Session | spec + results + evidence | read/test/inspect | 驗收、找假成功 |
| Memory Worker | conversation/artifact candidates | retrieval/write-memory | 離線記憶萃取 |
| Eval Session | frozen regression cases | isolated | 回放行為測試 |

Execution Session 不應看見大量已被否決的舊方向。

---

# 11. 上行 Promotion

```text
Skill Result
   ↓
Evidence
   ↓
Clerk identifies reusable candidate
   ↓
ContextPatch Proposal
   ↓
Scope classification
turn / project / domain / global
   ↓
Conflict + regression check
   ↓
User approval when authority requires it
   ↓
Canonical Context
```

上放的是可驗證規則，不是整份程序 Skill。

---

# 12. 下行 Compilation

```text
Canonical Boundary
      ↓
Context Compiler
      ↓
ExecutionSpec
      ↓
Skill / Tool Policy
      ↓
Pi tool_call Gate
      ↓
ALLOW / BLOCK / REQUIRE APPROVAL
```

> **上層保存語義真相；下層負責把真相變成機器可執行約束。**

---

# 13. 資料契約修訂

V2 將 V1 過度泛化的 `SkillPatch` 拆開：

- `ContextPatch`：只修改 Canonical Context。
- `SkillPatch`：只修改 capability definition。
- `SkillInvocation`：記錄 Skill source/version、Context Envelope hash、工具權限、Session。
- `SkillResult`：記錄 output、proposed decisions、artifacts、evidence、assumptions。
- `ArtifactRef`：追蹤 CONTEXT.md、ADR、spec、tickets、程式、影片等。
- `ExecutionSpec`：新增 canonical context version、allowed namespaces/tools、forbidden mutations、evidence requirements、policy hash。

---

# 14. V1 → V2 結果差異

| 面向 | V1 | V2 |
|---|---|---|
| 核心單位 | 多種內容統一成 Skill | Context / Capability / Evidence / Governance 分離 |
| Purpose | Skill | Canonical Context |
| Method | Skill | Capability Skill |
| Evidence | Skill | Evidence / Artifact |
| Interaction | 一種 Skill | Policy 與 procedural capability 分離 |
| 第三方 Skill | 尚未完整定義 | Federated、保留 namespace/version |
| 第三方 CONTEXT.md | 可能撞正式 Context | Artifact → Promotion Gate |
| 載入策略 | 相關 Skill 偏統一全文注入 | Canonical 主動載入；Capability progressive disclosure |
| 狀態更新 | SkillPatch | ContextPatch |
| 能力更新 | 未明確區分 | SkillPatch |
| Pi | Executor Adapter | Reference Application Kernel |
| 執行約束 | Prompt + ExecutionSpec | ExecutionSpec + runtime policy Gate |
| 系統成長 | 增加自己的 Skills | 接入更多 Skill 生態而不吞掉它們 |

V2 定位：

> **Canonical Context + Skill Federation + Evidence-Gated Runtime 的個人 AI 控制平面。**

---

# 15. 新的終點站架構

```text
┌──────────────────────────────────────────────┐
│ Personal Context OS UI                      │
│ Chat | Projects | Context | Skills | Diff   │
│ Conflict | Evidence | Artifacts | Evals     │
└──────────────────────┬───────────────────────┘
                       ▼
┌────────────── Context / Governance ──────────┐
│ Mode Router                                 │
│ Canonical Context Registry                  │
│ Context Activator                           │
│ Clerk                                       │
│ Conflict / Question Gate                    │
│ Promotion Gate                              │
│ Context Compiler                            │
│ Context Patcher                             │
│ Evidence Reconciler                         │
└───────────────┬──────────────────────────────┘
                │
        Context Envelope / ExecutionSpec
                │
┌───────────────▼──────────────────────────────┐
│ Skill Federation                            │
│ internal | project | Pi | external vendors  │
│ primitive | workflow | composite            │
└───────────────┬──────────────────────────────┘
                │
┌───────────────▼──────────────────────────────┐
│ Pi Runtime Kernel                           │
│ AgentSession | ModelRuntime | Extensions    │
│ ResourceLoader | Tools | Events | Policy    │
└───────────────┬──────────────────────────────┘
                ▼
┌──────────────────────────────────────────────┐
│ Evidence / Artifact Stores                  │
│ Git | DB | tests | logs | docs | media      │
└──────────────────────────────────────────────┘
```

---

# 16. 建議 Repository 結構

```text
personal-context-os/
├── apps/
│   ├── web/
│   └── desktop/
├── packages/
│   ├── context-domain/
│   ├── governance/
│   ├── context-store/
│   ├── context-compiler/
│   ├── skill-federation/
│   ├── evidence/
│   ├── evals/
│   └── pi-runtime/
├── services/
│   ├── clerk/
│   ├── memory-worker/
│   └── artifact-indexer/
├── pi-extensions/
│   ├── context-injection.ts
│   ├── execution-gate.ts
│   ├── evidence-collector.ts
│   └── interrupt-correction.ts
├── context/
│   ├── global/
│   ├── domain/
│   └── project/
├── skills/
│   ├── internal/
│   ├── project/
│   └── external/
├── artifacts/
├── evals/
└── contracts/
    ├── context_packet.ts
    ├── context_patch.ts
    ├── skill_invocation.ts
    ├── skill_result.ts
    ├── artifact_ref.ts
    ├── execution_spec.ts
    └── conflict_question.ts
```

---

# 17. 新增驗收維度

1. `external-skill-non-overwrite`
2. `artifact-promotion`
3. `context-vs-capability-routing`
4. `namespace-integrity`
5. `promotion-scope`
6. `downward-policy-compilation`
7. `runtime-kernel-independence`
8. `multi-session-isolation`

---

# 18. 已接受架構決策

- **ADR-V2-001：Canonical Context 與 Capability Skill 分離**
- **ADR-V2-002：Evidence 移出 Skill**
- **ADR-V2-003：第三方 Skill 不覆寫**
- **ADR-V2-004：第三方 Context Artifact 必須 Promotion**
- **ADR-V2-005：Pi 升級為 Reference Application Kernel**
- **ADR-V2-006：保留 AgentRuntime 抽象邊界**
- **ADR-V2-007：下層經驗向上 Promotion，上層約束向下 Compilation**

---

# 19. 尚待實測

1. 同輪多 Capability Skills 的控制權衝突。
2. 第三方 Skill trust level / sandbox policy。
3. External Skill 升版後是否自動重跑 regression。
4. CONTEXT.md / ADR / spec 矛盾時的 artifact ranking。
5. Promotion scope 是否需要第二 reviewer。
6. Pi Extension 載入順序能否繞過 Governance Gate。
7. 多 Session Context Envelope hash 的可重現性。
8. Canonical Context 長大後的 shard 策略。
9. Skills 跨 harness 共用的 capability contract。
10. 自然語言 Boundary 下放成 Tool Gate 的結構化程度。

---

# 20. 與 Article 005 / 007 的關係

- **Article 004：** 管理正式現實、能力調度、權威與執行契約。
- **Article 005：** 管理何時應換方法、何時不能困在局部解。
- **Article 007：** 提供由目的向下與由結果向上的雙向思想。

```text
Evidence / Skill Result
        ↑ Promotion
        │
Canonical Context
        │
        ↓ Compilation
ExecutionSpec / Runtime Gate
```

---

# 21. 最終定位

V1：

> 不是更長的聊天歷史，而是多個可持續更新、需要時自動置入的 Skills。

V2：

> **不是把更多 Skills 收進自己的系統，而是建立一個 Canonical Context 與 Skill Federation 的控制平面：它維護目的、標準、底線與現況，讓外部與內部能力在正確上下文中工作，將結果經證據與 Promotion Gate 回流，並把正式約束編譯成執行時可檢查的 Gate。**

> **能力越多，就越需要一個不吞掉能力、但能決定何時使用、能看到什麼、能改什麼，以及什麼才算真的完成的控制平面。**

---

## External references / 外部驗證案例

- Pi SDK: https://pi.dev/docs/latest/sdk
- Pi Extensions: https://pi.dev/docs/latest/extensions
- Pi Skills: https://pi.dev/docs/latest/skills
- AI Hero `grill-with-docs`: https://www.aihero.dev/grill-with-docs
- AI Hero `grilling`: https://www.aihero.dev/skills-grilling
- AI Hero `to-spec`: https://www.aihero.dev/skills-to-spec
- AI Hero `to-tickets`: https://www.aihero.dev/skills-to-tickets

> 以上外部系統只作架構驗證與相容性案例，不是 Personal Context OS 的必要依賴。
