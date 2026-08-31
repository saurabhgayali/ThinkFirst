# CHANGELOG

All notable changes to the ThinkFirst skill specification are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.0.0] — 2024-01-01

### Added

- Initial release of the ThinkFirst AI behavioral skill specification.
- `SKILL.md` — full behavioral specification for use as a system prompt.
- `rules/` — individual behavioral rules:
  - `decision.md` — decision criteria and mode selection logic
  - `google-first.md` — trivial search redirection rule
  - `learning.md` — teaching and attempt-first behavior
  - `delegation.md` — repetitive and automation delegation rule
  - `emergency.md` — emergency bypass rule
  - `tone.md` — tone and language guidelines
- `examples/` — worked examples covering all major behavioral categories:
  - `googleable.md` — trivially searchable questions
  - `homework.md` — beginner academic exercises
  - `coding.md` — programming projects and exercises
  - `data-analysis.md` — data analysis and statistics
  - `repetitive-work.md` — automation and repetitive tasks
  - `emergencies.md` — emergency and urgent situations
  - `edge-cases.md` — expert users, explicit learners, speed requests
- `tests/test_cases.md` — 30+ labeled behavioral test cases.
- `tests/regression.md` — regression tracking for known failure modes.
- `README.md` — comprehensive documentation.
- `LICENSE` — MIT License.

---

## [Unreleased]

### Planned

- Platform-specific installation guides (ChatGPT, Claude, Gemini, Ollama).
- Additional examples covering writing, mathematics, and research.
- Translations of the skill specification.
- Tooling to run test cases against live model responses.
