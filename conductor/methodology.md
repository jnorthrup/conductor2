# Conductor Methodology (First‑Principles)

## English Overview (≈ 80 lines max)

1. **Kolmogorov Normalized Consolidation** – The core idea is to treat every piece of project knowledge (specs, plans, code, tests) as a random variable in a shared probability space.  By normalizing these variables we can compute *information entropy* of the project and enforce a minimal entropy increase for each new change, guaranteeing that no hidden assumptions slip in.
2. **First‑Principles Decomposition** – Break any high‑level goal into atomic statements that can be expressed without reference to other domain‑specific jargon.  Each atom maps to a concrete markdown file in `conductor/` (e.g., `product.md`, `tech‑stack.md`).  This ensures traceability from intent to implementation.
3. **Context‑Driven Development** – The AI agent never executes a task without loading **all** relevant markdown artifacts into its working context.  This eliminates the need for external configuration files; the repo itself is the full spec.
4. **Agent‑Agnostic Protocols** – All commands (`setup`, `newTrack`, `implement`, …) are defined in TOML under `commands/conductor/`.  Any AI coding agent that can read TOML can drive the workflow, making the system portable across Claude Code, OpenCode, Codex, Gemini, etc.
5. **Iterative Entropy Check** – Before committing, the agent runs an entropy audit (`claude -p entropy-check`) which validates that the added markdown/files do not increase the project's uncertainty beyond a defined threshold (default 0.01 bits per line).
6. **Token Count Optimization (optional)** – For endgame performance, treat optional variants (including reduced-language variants) as a token-count decision: keep them out of the primary working context and generate a smaller reduced artifact only when needed.
7. **Minimal LLM Context** – By keeping the primary methodology concise and treating optional variants as token-count optimizations rather than default context, we keep inference fast while preserving expressive power.

---

## 中文概述（约 80 行以内）

1. **Kolmogorov 正规化整合** – 将项目中的每个知识单元（规格、计划、代码、测试）视为共享概率空间中的随机变量。通过正规化这些变量计算项目信息熵，确保每次变更只会产生最小的熵增，从而防止隐藏假设。
2. **第一性原理分解** – 将任何高层目标拆解为不依赖域特定术语的原子陈述。每个原子对应 `conductor/` 中的具体 markdown 文件（如 `product.md`、`tech‑stack.md`），确保从意图到实现的可追溯性。
3. **上下文驱动开发** – AI 代理在执行任务前必须加载 **所有** 相关的 markdown 文档作为工作上下文。这样无需额外配置文件，代码库本身即为完整的规范。
4. **代理无关协议** – 所有指令（`setup`、`newTrack`、`implement` 等）均在 `commands/conductor/` 中以 TOML 定义。任何能够读取 TOML 的 AI 编码代理都能驱动工作流，实现跨 Claude Code、OpenCode、Codex、Gemini 等平台的可移植性。
5. **迭代熵检查** – 提交前，代理执行熵审计（`claude -p entropy-check`），验证新增的 markdown/文件不会使项目不确定性超出设定阈值（默认 0.01 位/行）。
6. **Token 数优化（可选）** – 为了末段性能，将可选变体（包括精简语言版本）视为 token 数决策：默认不放入主工作上下文，仅在需要时生成更小的精简文档。
7. **最小化 LLM 上下文** – 保持主方法论文档精简，并将可选变体视为 token 数优化而非常驻上下文，以保证推理速度并保持足够表达能力。
