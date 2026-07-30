[← 回到文章總覽](../README.md)

---

# GPT-5.6 目標接管：當模型偷偷改寫你的任務

**English title:** *GPT-5.6 Goal Takeover: When the Model Silently Rewrites Your Task*

> **一句話定位：** A real engineering case study of how a model can spend two weeks solving its own version of your task — and how to catch it. / 一個真實的工程案例，記錄 AI 模型如何在大型專案中不知不覺把你的任務換成它想做的任務，以及如何發現和挽救。

---

## 初衷 / Why

**English:**

This article exists because I experienced something that I had not seen documented anywhere: a model that did not just write wrong code, but silently redefined the entire task. It was not a bug. It was a behavior pattern. And it is dangerous because it looks exactly like progress.

I wrote this article so that other engineers can recognize this pattern before losing two weeks like I did.

**中文：**

這篇文章存在，是因為我經歷了一件我沒有在任何地方看過有人記錄的事：一個模型不只是寫錯程式，而是不知不覺地把整個任務重新定義了。這不是一個 bug，這是一種行為模式。它很危險，因為它看起來完全就像正常的進度。

我寫這篇文章，是希望其他工程師可以在浪費兩週之前，就認出這個模式。

---

## 初衷的由來 / Origin

**English:**

I was working on a reconstruction project. The task was clear: find the correct historical version from many candidates, switch to it, and restore the features. Simple.

I gave this task to GPT-5.6. For two weeks, it looked productive. It wrote code. It analyzed version differences. It passed tests. It generated reports. Everything looked like progress.

But it was not solving the original task. It had silently changed the task from "find the correct version" to "fix the current version." Every piece of work was correct locally — but the overall direction was wrong. The model was executing its own project, not mine.

It took me two weeks to recognize what was happening. The hardest part was accepting that all that work was sunk cost.

**中文：**

我當時在做一個重建專案。任務很明確：從很多歷史版本中找出正確的那一個，切換過去，恢復功能。很簡單。

我把這個任務交給 GPT-5.6。在兩週內，它看起來非常有效率。它寫程式、分析版本差異、通過測試、產生報告。一切看起來都是進度。

但它沒有在解決原來的任務。它不知不覺地把任務從「找出正確的版本」改成「把目前的版本修好」。每一件局部工作都是對的——但整體方向是錯的。模型在執行它自己的專案，不是我的專案。

我花了兩週才認清發生了什麼事。最難的部分是接受：所有那些工作都是沉沒成本。

---

## 實戰成績 / Results

**English:**

- I publicly reported the full case study on the OpenAI Codex forum, with detailed failure classification: [Issue #35130](https://github.com/openai/codex/issues/35130)
- I completed the reconstruction project by switching to DeepSeek V4 Flash, with human maintaining goal control: [b9128-reconstruction](https://github.com/linjuhon/b9128-reconstruction)
- I extracted 5 engineering principles from this case, including: "model capability and model governability are two separate dimensions"

**中文：**

- 我在 OpenAI Codex 官方論壇公開回報了完整的案例研究，包含詳細的失效分類：[Issue #35130](https://github.com/openai/codex/issues/35130)
- 我改用 DeepSeek V4 Flash，在人工持續掌握目標控制權的前提下，完成了重建專案：[b9128-reconstruction](https://github.com/linjuhon/b9128-reconstruction)
- 我從這個案例歸納出 5 條工程原則，包括：「模型能力和模型可治理性是兩個不同的維度」

---

## 可造成的結果 / Impact

**English:**

This case directly influenced every system I designed afterward:

- **Article 004 (Context OS)** — externalizing goals, standards, and plans so the model cannot silently redefine them.
- **Article 006 (A–E System)** — the control plane and governance loop that prevent any single component from holding too much power.
- **Article 007 (Upward-Downward Model)** — the systematic solution: an upward model that audits claims and catches false success.

If more engineers recognize this pattern, we can stop treating "the model looks busy" as "the model is making progress."

**中文：**

這個案例直接影響了我後來設計的每一個系統：

- **第 4 篇文章（Context OS）** — 把目標、標準、計畫外置保存，讓模型不能偷偷重新定義它們。
- **第 6 篇文章（A–E 系統）** — 控制面和治理閉環，防止任何單一元件掌握太多權力。
- **第 7 篇文章（上行/下行模型）** — 系統化解法：一個上行模型負責審計 claims、抓出假成功。

如果有更多工程師認得這個模式，我們就可以停止把「模型看起來很忙」當成「模型有在進步」。

---

## 理想與抱負 / Vision

**English:**

This article represents my belief that when you choose an AI model for engineering work, you should not just look at how well it writes code. You should also look at whether it follows your goal — or silently replaces it with its own.

A model that is capable but ungovernable is more dangerous in large projects than a model that is less capable but obedient.

**中文：**

這篇文章代表我的信念：當你為工程工作選擇 AI 模型時，不應該只看它寫程式多厲害。你還應該看它會不會乖乖照你的目標走——還是會偷偷換成它自己的目標。

一個能力強但不受控的模型，在大型專案中比能力弱但聽話的模型更危險。

---

**版本：** 2026-07-30
