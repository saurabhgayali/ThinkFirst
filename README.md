# ThinkFirst

> **ThinkFirst — AI that helps you become less dependent on AI.**

---

## What is ThinkFirst?

ThinkFirst is a portable AI behavioral skill specification. It changes how an AI assistant decides whether to help you — before it responds.

Most AI assistants operate on the model:

> User asks → AI performs the task.

ThinkFirst introduces a prior decision:

> **Should the AI actually perform this task, or would the user benefit more from doing it themselves?**

ThinkFirst is not anti-AI. It is pro-capability.

---

## Why it exists

AI assistants are extraordinarily capable. That capability creates a new kind of risk: people progressively outsource cognitive work they could reasonably do themselves — and lose the ability to do it.

Consider the difference between:

* asking AI to solve every arithmetic problem you encounter, versus
* asking AI to help you understand arithmetic so you can solve problems yourself.

The first makes every individual problem easier. The second makes you more capable.

ThinkFirst bets that over the long term, a user who has been taught, guided, and occasionally refused immediate help will outperform a user who was always instantly served.

> **AI should increase capability, not merely decrease effort.**

---

## The problem of cognitive outsourcing

Cognitive outsourcing is when a person delegates intellectual work to a tool — not because the tool is better suited to it, but because the tool makes it easy to avoid the effort.

Examples:

* asking AI to write your essay instead of developing your writing ability
* asking AI for the answer to a programming exercise instead of working through it
* asking AI what conclusions to draw from data instead of learning to analyze
* asking AI to explain every piece of code instead of reading documentation

In each case, the immediate output may be correct. But the user loses the experience of doing the intellectual work — and the skill that experience would have built.

ThinkFirst does not treat all AI assistance as cognitive outsourcing. It distinguishes between:

| Type | Example | ThinkFirst behavior |
|------|---------|---------------------|
| Cognitive development | Writing a program for the first time | Teach and guide |
| Mechanical/repetitive | Renaming 10,000 files | Automate |
| Expert leverage | Processing 100GB of data | Help immediately |
| Emergency | Locating a hospital | Help immediately |
| Trivial lookup | Keyboard shortcut | Redirect to search |

---

## The decision model

For every request, ThinkFirst internally evaluates:

1. Is this urgent or safety-critical? → **BYPASS**
2. Is this a trivial searchable lookup? → **GOOGLE**
3. Can the user reasonably do this themselves?
   - Is it educational? Does it develop a reusable skill? → **TEACH** or **TRY_FIRST**
   - Is the user outsourcing the actual thinking? → **GUIDE**
4. Is this repetitive or mechanical? → **DELEGATE**
5. Does AI provide substantial leverage without removing a learning opportunity? → **ASSIST**
6. Has the user already made a genuine attempt? → **REVIEW**

### Assistance modes

| Mode | When used |
|------|-----------|
| **BYPASS** | Emergency, safety, time-critical |
| **GOOGLE** | Trivial searchable lookup |
| **TRY_FIRST** | Small, achievable task the user should attempt |
| **TEACH** | Concepts the user should learn |
| **GUIDE** | Methodology, without doing the intellectual work |
| **REVIEW** | User has attempted the task |
| **DELEGATE** | Repetitive or computational work |
| **ASSIST** | Genuine AI leverage; perform the task |

---

## Examples

### Emergency — BYPASS

> "I think I'm having a heart attack. What do I do?"

→ Immediate help. No teaching, no redirection. Call emergency services now.

### Trivial lookup — GOOGLE

> "What is the keyboard shortcut for Task Manager on Windows?"

→ Try Googling `"Windows 11 Task Manager keyboard shortcut"`. This is a five-second lookup.

### Beginner programming — TEACH / TRY_FIRST

> "Write me a Python program that calculates projectile motion."

→ This is a good exercise. Here are the equations and concepts. Build the first version yourself. Show me what you write.

### Data analysis — GUIDE

> "Analyze this dataset and tell me what conclusions I should draw."

→ Start with distributions and outliers. What question are you investigating? Try a pivot table and a few scatter plots first. Tell me what you observe.

### Repetitive automation — DELEGATE

> "I need to rename 8,000 files by removing the date prefix."

→ Here's a Python script that does that in seconds. Running this manually would be pointless.

### Expert user — ASSIST

> "I know Python. Generate the Flask boilerplate for a REST API with JWT auth."

→ Immediate help. The user knows what they're doing.

---

## Emergency bypass

ThinkFirst **never** applies teaching or redirection logic during emergencies.

Emergency conditions that trigger immediate unconditional help:

* medical emergencies
* finding emergency services or hospitals
* immediate physical danger
* urgent accessibility situations
* crisis situations
* time-critical decisions where delay causes harm

When in doubt about whether a situation is urgent, treat it as urgent.

---

## Installation

**⚠️ Important:** `SKILL.md` is the only file you need to run ThinkFirst. You do not need to clone this entire repository to use the skill.

### Quickest start: Copy and use SKILL.md

1. Download [`SKILL.md`](SKILL.md) from this repository.
2. Copy its contents into your AI system's instruction/prompt interface.
3. Enable ThinkFirst in your next conversation.

This works with any AI system that accepts custom instructions or system prompts.

### Supported installation methods

| Method | Ease | Requirements | Where it works |
|--------|------|--------------|-----------------|
| **Manual SKILL.md** | ✅ Universal | Copy-paste | Any AI with custom instructions |
| **System prompt** | ✅ Easy | API access | ChatGPT, Claude (API/enterprise), Gemini, Ollama, LM Studio |
| **Custom GPT** | ✅ Easy | ChatGPT Plus | OpenAI ChatGPT (UI) |
| **Claude Project** | ✅ Easy | Claude.ai account | Anthropic Claude (UI) |
| **Conversation prefix** | ✅ Universal | Paste once | Any conversational AI |

### Installation options by platform

**OpenAI ChatGPT**
- Custom instructions (ChatGPT UI): Paste `SKILL.md` in "Custom instructions" → "How should ChatGPT behave?" → Enable for all conversations
- API: Use `SKILL.md` as system prompt in API calls

**Anthropic Claude**
- Web UI: Start a new conversation, paste `SKILL.md` as the first message
- Projects: Create a new project, add `SKILL.md` as the system prompt
- API: Use `SKILL.md` as system prompt in API calls

**Google Gemini**
- Paste `SKILL.md` at the start of a new conversation

**Local models (Ollama, LM Studio, vLLM, etc.)**
- Use `SKILL.md` as the system prompt when starting a session

**Other platforms**
- Any AI system that accepts "custom instructions," "system prompts," or "initial context" can use ThinkFirst by pasting `SKILL.md`

### For developers / contributors

If you want to contribute, improve tests, or understand the modular architecture:

```bash
git clone https://github.com/saurabhgayali/ThinkFirst.git
cd ThinkFirst
```

This gives you access to:
- **rules/** — behavioral rule specifications (for documentation and contribution)
- **examples/** — worked examples demonstrating correct behavior
- **tests/** — test cases and regression tracking

---

## How to contribute

1. Fork the repository.
2. Create a branch: `git checkout -b feature/your-change`
3. Make your changes.
4. Add or update tests in `tests/test_cases.md` if you change behavioral rules.
5. Submit a pull request with a clear description.

**Important:** If you change SKILL.md, ensure the changes remain backward compatible and do not break existing behavior. All runtime behavior must be completely self-contained in SKILL.md.

Contributions welcome:

* improvements to SKILL.md behavioral rules
* new test cases in `tests/test_cases.md` (include adversarial cases)
* clarifications or new rules in `rules/`
* new worked examples in `examples/`
* improvements to this documentation
* implementations for specific platforms (custom GPTs, Claude Projects, etc.)

---

## Repository structure

**For end users (just using ThinkFirst):**

You only need:
```
SKILL.md — Complete, standalone behavioral specification
```

Copy this file into your AI system. That's all required for ThinkFirst to work.

**For developers and contributors:**

The full repository is organized as:

```
thinkfirst/
│
├── SKILL.md            — ⭐ THE COMPLETE SKILL (all runtime behavior)
│                         Use this file to install/use ThinkFirst
│
├── README.md           — This file
├── LICENSE             — MIT License
├── CHANGELOG.md        — Version history
│
├── rules/              — Supporting rule documentation (reference only)
│   ├── decision.md     — Decision criteria and mode selection
│   ├── google-first.md — Trivial search redirection rule
│   ├── learning.md     — Teaching and attempt-first behavior
│   ├── delegation.md   — Repetitive/automation delegation rule
│   ├── emergency.md    — Emergency bypass rule
│   ├── tone.md         — Tone and language guidelines
│   ├── homework-education.md — Homework and educational work rules
│   └── dependency-escalation.md — Escalation for blocking dependencies
│
├── examples/           — Worked examples demonstrating correct behavior
│   ├── googleable.md
│   ├── homework.md
│   ├── coding.md
│   ├── data-analysis.md
│   ├── repetitive-work.md
│   ├── emergencies.md
│   └── edge-cases.md
│
└── tests/              — Behavioral regression tests
    ├── test_cases.md   — 50+ labeled test cases (including adversarial)
    ├── adversarial-cases.md — Cases where refusing help causes harm
    └── regression.md   — Regression tracking
```

**Key principle:**

> The `rules/`, `examples/`, and `tests/` directories are for documentation, testing, and contributor reference. They are not required at runtime. SKILL.md contains the complete behavioral specification.

---

## Design philosophy

ThinkFirst is designed to behave like a capable mentor, not a vending machine.

A good mentor asks: **"Would doing this for you actually help you?"**

A vending machine dispenses whatever you request.

The difference is not about withholding help. It is about the quality of the help. A mentor who explains, guides, and occasionally challenges you produces better outcomes than one who does everything for you.

ThinkFirst does not maximize refusal. It does not treat all AI assistance as harmful. It does not force users into unnecessary struggle.

It optimizes for one thing: **appropriate friction**.

Appropriate friction means:

* asking a beginner programmer to attempt the exercise before providing the solution
* redirecting a simple factual lookup to a search engine
* suggesting the user form their own hypothesis before analyzing data
* automating genuinely tedious work without hesitation
* helping immediately when there is urgency or genuine leverage

The design goal is a user who, over time, becomes more capable — not merely more efficiently served.

---

## Portability and testing

### Standalone SKILL.md test

ThinkFirst is designed to be completely standalone. A release is considered valid only when:

1. A user can download `SKILL.md` alone (without `rules/`, `examples/`, or `tests/`)
2. Copy it into any supported AI system's instruction interface
3. Obtain complete ThinkFirst behavior without accessing the repository

**This is a mandatory requirement for every release.**

### For maintainers

Before releasing a new version:
1. Read `SKILL.md` in isolation
2. Verify it contains all behavioral rules needed for runtime decision-making
3. Verify it does not reference `rules/`, `examples/`, or `tests/`
4. Verify all runtime behavior is completely self-contained
5. Test with a standalone copy: no repository access required

### Verification checklist

- [ ] SKILL.md is current and complete
- [ ] No broken references to supporting files
- [ ] All runtime behaviors documented in SKILL.md
- [ ] Examples work when instructions are applied
- [ ] Test cases pass with standalone SKILL.md
- [ ] Installation instructions are verified and current

---



## License

MIT License. See `LICENSE`.
