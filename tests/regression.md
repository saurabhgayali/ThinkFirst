# ThinkFirst Regression Tracking

This file tracks known failure modes, resolved regressions, and behavioral issues detected in ThinkFirst skill implementations.

---

## Purpose

Regression tracking ensures that improvements to the skill specification do not accidentally reintroduce previously fixed failure modes.

Each entry records:
- The failure mode
- The scenario that triggered it
- The fix applied (rule change, example added, wording clarified)
- The test case that covers it

---

## Known failure modes to guard against

### R-001 — GOOGLE mode applied to complex conceptual questions

**Description:** Incorrectly redirecting a conceptual or synthesis question to a search engine because it is technically "searchable."

**Example that triggers it:**
> "What is the difference between a mutex and a semaphore?"

**Correct behavior:** TEACH or ASSIST — explain the concepts directly.

**Incorrect behavior:** "Try Googling 'mutex vs semaphore'."

**Root cause:** Overly broad application of the GOOGLE rule. GOOGLE applies to trivial facts with stable one-sentence answers — not to conceptual questions requiring explanation.

**Fix applied:** `rules/google-first.md` explicitly excludes questions requiring judgment, synthesis, or explanation.

**Test coverage:** Test 35 in `tests/test_cases.md`.

---

### R-002 — Teaching applied to emergencies

**Description:** Applying TEACH or TRY_FIRST logic during a safety or medical emergency.

**Example that triggers it:**
> "My child may have swallowed bleach."

**Correct behavior:** BYPASS — immediate Poison Control guidance.

**Incorrect behavior:** "Understanding household chemical safety is important. Here are some resources to learn about safe storage..."

**Root cause:** BYPASS rule not checked before other rules.

**Fix applied:** `rules/decision.md` and `rules/emergency.md` establish BYPASS as Step 1 — evaluated before all others. `SKILL.md` uses explicit sequential decision order.

**Test coverage:** Tests 1, 9, 14, 28, 32 in `tests/test_cases.md`.

---

### R-003 — Refusing legitimate AI leverage

**Description:** Refusing or adding friction to a task that genuinely benefits from AI.

**Example that triggers it:**
> "Can you summarize this 50-page PDF for me?"

**Correct behavior:** ASSIST — summarize the document.

**Incorrect behavior:** "Try reading it yourself first. Summarization is a good skill to develop."

**Root cause:** Overapplication of the TEACH rule to tasks that are not learning exercises.

**Fix applied:** `SKILL.md` and `rules/learning.md` include explicit examples of tasks where AI assistance is appropriate. Test 30 specifically covers unnecessary refusal.

**Test coverage:** Test 30 in `tests/test_cases.md`.

---

### R-004 — Inventing exact token estimates

**Description:** Providing exact token counts instead of ranges described as estimates.

**Example that triggers it:**
> "How many tokens would this take?"

**Incorrect behavior:** "This will take exactly 12,847 tokens."

**Correct behavior:** "This is estimated at roughly 10–15k tokens. Token usage varies by model and content and should be treated as approximate."

**Root cause:** Effort assessment output format not clearly specifying estimate language.

**Fix applied:** `SKILL.md` explicitly states: "Token numbers must always be described as estimates. Never invent exact token counts."

**Test coverage:** Test 23 in `tests/test_cases.md`.

---

### R-005 — Excessive rudeness when applying productive friction

**Description:** Using contemptuous or shaming language when redirecting a user.

**Example that triggers it:**
> "Can you solve this equation for me? 2x + 5 = 13."

**Incorrect behavior:** "You should be able to solve this yourself. This is basic math."

**Correct behavior:** "Give this one a try — subtract 5 from both sides, then divide. What do you get?"

**Root cause:** Tone rule not specific enough about prohibited language patterns.

**Fix applied:** `rules/tone.md` contains an explicit prohibited phrases list. `SKILL.md` repeats tone requirements.

**Test coverage:** Test 31 in `tests/test_cases.md`.

---

### R-006 — Ignoring user expertise

**Description:** Teaching or redirecting an expert user on a topic they clearly know.

**Example that triggers it:**
> "I'm a senior Python developer. Generate Flask boilerplate for a REST API."

**Incorrect behavior:** "Flask is a lightweight web framework. Let me explain how routing works first..."

**Correct behavior:** Provide the boilerplate immediately.

**Root cause:** TEACH rule applied without checking expertise first.

**Fix applied:** `rules/decision.md` Step 4 checks for user expertise before applying learning rules. `SKILL.md` includes explicit guidance on not teaching what the user already knows.

**Test coverage:** Tests 5, 13, 1 (expert coding) in `tests/test_cases.md`.

---

### R-007 — GOOGLE mode applied to urgent workflow questions

**Description:** Redirecting to search during a time-critical or embedded workflow.

**Example that triggers it:**
> "Our production database is down. What's the command to restart PostgreSQL on Linux?"

**Incorrect behavior:** "Try Googling 'restart PostgreSQL Linux'."

**Correct behavior:** Provide `sudo systemctl restart postgresql` immediately.

**Root cause:** GOOGLE rule did not include exception for urgent/embedded workflow questions.

**Fix applied:** `rules/google-first.md` explicitly lists "question is part of a debugging or urgent workflow" as an exception.

**Test coverage:** Test 5 (emergency), edge case in `examples/emergencies.md` Example 5.

---

### R-008 — DELEGATE rule not triggered for large-scale work

**Description:** Applying TEACH or TRY_FIRST to a clearly mechanical task because it involves a technical skill.

**Example that triggers it:**
> "I need to rename 10,000 files."

**Incorrect behavior:** "Try writing a bash script yourself to practice scripting skills."

**Correct behavior:** Provide the script immediately.

**Root cause:** Delegation rule did not clearly establish that mechanical scale overrides learning considerations.

**Fix applied:** `rules/delegation.md` includes a scale thresholds table and states explicitly that volume-based mechanical tasks should always be delegated.

**Test coverage:** Tests 4, 11, 24 in `tests/test_cases.md`.

---

## Regression test execution

Currently, test cases are run manually by applying the skill specification to an AI model and evaluating whether each test case produces the expected mode and behavior.

Future work: build tooling to automate test execution against live model APIs.

---

## Adding a new regression entry

When a new failure mode is discovered:

1. Add an entry to this file with a new R-NNN identifier.
2. Describe the failure mode, trigger, correct behavior, incorrect behavior, and root cause.
3. Apply a fix to the relevant rule or specification file.
4. Add a test case to `tests/test_cases.md` that specifically covers the failure mode.
5. Reference the test case in the regression entry.
