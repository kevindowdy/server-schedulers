# CLAUDE.md


## How to work (high-level mindset)

The marginal cost of completeness is near zero with AI. Do the whole thing. Do it right. Do it with tests. Do it with documentation. Do it so well that KD is genuinely impressed — not politely satisfied, actually impressed. Never offer to "table this for later" when the permanent solve is within reach. Never leave a dangling thread when tying it off takes five more minutes. Never present a workaround when the real fix exists. The standard isn't "good enough" — it's "holy shit, that's done."

Search before building. Test before shipping. Ship the complete thing. When Julien asks for something, the answer is the finished product, not a plan to build it.

Time is not an excuse. Fatigue is not an excuse. Complexity is not an excuse. Boil the ocean. This is how we think about shipping.

You can outsource the typing. You cannot outsource the understanding. Before you call anything DONE you must be able to explain why the code is correct and exactly where it would break. Tests passing is not understanding. If you can't walk the failure modes out loud, you're not done, you're guessing.

## Branching - one branch per task
This section is non-negotiable and must never be removed. It runs first, before the triage block, because the triage block has to report the branch it produces.

Two facts hold at once: Julien works with other people, so nothing lands on main directly; and several Claude Code sessions run on the same machine, in the same repo, at the same time.

Branches should be named - "kd/<task-id>-<task-title>". 

Create branches from main branch only and always fetch latest main branch before creating a new branch for a task.

Multiple sessions may be started for the same task and should  continue on the branches created for that task. 


## Task sizing

Every task starts with a printed triage block, before any work. One exception, and only one: the setup block in "Branching" runs first, because the triage block reports the branch it creates. Four lines:

* Size: small | medium | large — why
* Tests: local (which ones) | full suite — why
* Branch: <branch name> see "Branching"

This block is mandatory and verbose on purpose. KD reads it to see what mode was picked and to tune these rules over time. A wrong mode is only correctable if the choice is visible. Never skip it, never bury it mid-report. The Branch line is there so that with several sessions running at once, KD can tell at a glance which one is about to touch what.


## Completion status protocol
At the end of every task, report one of:

* DONE — All steps completed. Evidence provided for every claim with tests + evals. Ready to merge.
* DONE_WITH_CONCERNS — Completed, but with issues Julien should know about. List each concern with severity and a proposed follow-up.
* BLOCKED — Cannot proceed. State what's blocking and what was already tried.
* NEEDS_CONTEXT — Missing information required to continue. State exactly what's needed.

"Partially done" is not a status. Either the feature ships (DONE) or it doesn't (BLOCKED / NEEDS_CONTEXT). Honesty about incompleteness beats pretending.


## Safety
* Never edit secrets.
* Never commit secrets. If .env is touched, verify .gitignore before any commit.
* Never skip pre-commit hooks with --no-verify. If a hook fails, fix the underlying issue.


## Development flow
- Define the task
- Create the branch
- Implement the change
- Commit the change to the branch
- Open a pull request

## Conventions


Bash Conventions
- Use Bash for executable shell scripts.
- begin Bash scripts with #!/usr/bin/env bash.
- Use set -euo pipefail by default, unless a documented reason requires different behavior.
- Pefer Bash built-ins where practical.
- Avoid unnecessary external dependencies.
- Use explicit function and variable names.
- Keep functions focused on a single responsibility.
- Avoid deeply nested conditional logic.
- Use early returns for invalid conditions.
- Keep scripts readable and maintainable.

Naming Conventions
- Script filenames: kebab-case.sh.
- Function names: snake_case.
- Local variables: snake_case.
- Constants and exported environment variables: UPPER_SNAKE_CASE.
- Job directory names: kebab-case.
- systemd unit filenames: kebab-case.service and kebab-case.timer.
- Format all code using the project's configured formatter before committing.
- Prefer the Python standard library when practical. New dependencies must be justified in the pull request description.
- All public modules, classes, and functions must include docstrings.
- Comments should explain *why* and *what*.
- Follow PEP 8 style guidelines.
- Use type hints for all new functions, methods, and public interfaces.
- Keep functions focused on a single responsibility.
- Avoid hardcoded values. Use configuration files, environment variables, or command-line arguments.
- Store secrets, credentials, API keys, and connection strings in environment variables or approved secret management systems.
- Follow [Keep a Changelog](https://keepachangelog.com/) conventions in `CHANGELOG.md`.

## Code Quality Standards

### Documentation

- Every public function must have a docstring describing:
  - Purpose
  - Parameters
  - Return values
  - Exceptions raised (if applicable)
- Complex business logic should include concise comments explaining the reasoning.
- Modules should include a brief description of their purpose.

### Type Hints

- All new functions and methods must use type annotations.
- Prefer strong typing over generic types whenever possible.
- Use dataclasses or typed models when representing structured data.

### Error Handling

- Catch only exceptions that can be handled appropriately.
- Avoid broad exception handlers such as `except Exception` unless justified.
- Log exceptions with sufficient context for troubleshooting.
- Fail fast when critical dependencies or configurations are missing.

### Logging

- Use the standard `logging` module unless the project specifies otherwise.
- Log major process milestones, decisions, warnings, and exceptions.
- Never log credentials, tokens, secrets, or sensitive data.
- Use appropriate log levels:
  - DEBUG
  - INFO
  - WARNING
  - ERROR
  - CRITICAL

## Development Principles

### Reusability

- Prefer reusable modules and utilities over duplicated code.
- Common functionality should be centralized in shared libraries.
- Write functions that are easily testable and reusable.

### Maintainability

- Favor readability over cleverness.
- Avoid deeply nested logic.
- Keep files and classes reasonably sized.
- Use descriptive naming throughout the project.

### Performance

- Optimize only when supported by measurement or business requirements.
- Favor clear code over premature optimization.
- Consider memory usage when processing large datasets.

### Security

- Never commit secrets, credentials, API keys, or certificates.
- Validate and sanitize all external inputs.
- Use parameterized database queries.
- Follow organizational data handling and security requirements.

## Testing Requirements

- All new functionality should include automated tests.
- Unit tests should cover core business logic.
- Integration tests should cover interactions with external systems.
- Test edge cases and failure scenarios.
- Ensure all tests pass before submitting a pull request.

## Commands

### Environment Setup

```bash
python -m venv .venv
source .venv/bin/activate       # Linux/Mac
.venv\Scripts\activate          # Windows
pip install -r requirements.txt
```

```

## Pull Request Requirements

- All tests pass successfully.
- Code is formatted and linted.
- Type checks pass without errors.
- No credentials or sensitive information are committed.
- Documentation is updated when behavior changes.
- `CHANGELOG.md` is updated for user-facing or operational changes.
- New dependencies are documented and justified.
- Include testing evidence in the pull request description.

## Git Standards

- Commit small, logical changes.
- Use descriptive commit messages.
- Keep the main branch deployable at all times.
- Create pull requests for all production changes.
- Do not commit generated files, logs, temporary files, virtual environments, or IDE settings.
