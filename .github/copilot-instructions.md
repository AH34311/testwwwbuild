# Copilot / AI agent instructions for testwwwbuild

Purpose: help an AI coding agent be immediately productive in this Puppet module by describing the project's architecture, conventions, test and lint workflows, and important files to reference.

## Quick facts
- Module name: `ahtest-testwwwbuild` (see `metadata.json`).
- Target Puppet versions: >= 7.24 and < 9.0.0 (see `requirements` in `metadata.json`).
- Template / PDK: generated with PDK `3.4.0`.

## Where the code lives (quick map)
- `manifests/` — Puppet classes and defined types. Primary entry: `manifests/init.pp` which includes `testwwwbuild::config`.
- `manifests/config.pp` — main logic for creating directories, maps and symlinks; heavily uses hierarchical data lookups.
- `data/` — Hiera YAML data (see `hiera.yaml` for hierarchy rules).
- `spec/` — RSpec/rspec-puppet test setup and default facts (`spec/spec_helper.rb`, `spec/default_facts.yml`).
- `Rakefile` / `Gemfile` — test and development tasks and dependencies.
- `.puppet-lint.rc` — project lint configuration (some checks intentionally disabled).

## Architecture & patterns to follow 🔧
- Hierarchical configuration: code reads runtime config via `lookup()` and `hiera()` (you'll see both used in `manifests/config.pp`). Match the surrounding style when editing a file (be consistent within a file).
  - Example in `manifests/config.pp`:
    - `file { lookup('web_root_info'): ... }`
    - `file { hiera('dev-map-file-destination'): ... }`
- Hiera hierarchy: defined in `hiera.yaml`.
  - Put default values in `data/common.yaml` and OS-specific overrides in `data/os/<OS>/<major>.yaml` (the hierarchy enumerates `os/%{facts.os.name}/%{facts.os.release.major}.yaml` and `os/%{facts.os.family}/%{facts.os.release.major}.yaml`).
- Tests and facts:
  - Unit tests use `rspec-puppet` and `rspec-puppet-facts`. Default facts are merged from `spec/default_facts.yml` in `spec_helper.rb`.
  - When adding resource behavior, add a corresponding `spec/classes` or `spec/defines` test and supply minimal facts using `add_custom_fact` or the `default_facts.yml` pattern.
- Linting and style:
  - `PuppetLint` settings are customized in `.puppet-lint.rc` and some checks are disabled; still aim to avoid warnings since `fail_on_warnings` is set in `Rakefile`.

## How to run common developer workflows (commands to run locally) ✅
- Install dependencies:
  - `bundle install` (use `--path .bundle` if you prefer isolated installs)
- Run unit tests:
  - `bundle exec rake spec` — runs RSpec/rspec-puppet tests and reports coverage.
- Syntax and linters (Rake tasks provided by gems in `Gemfile` / `Rakefile`):
  - `bundle exec rake syntax` — puppet-syntax checks (provided by `puppet-syntax`)
  - `bundle exec rake rubocop` — ruby linting (if installed via Gemfile)
  - `bundle exec rake metadata:validate` or `bundle exec rake metadata_lint` — validate `metadata.json` (tools provided by `puppetlabs_spec_helper` / `metadata-json-lint`).
- Generate docs (if `puppet-strings` installed):
  - `bundle exec rake strings:generate`
- System tests / acceptance tests (optional if `puppet_litmus` is installed):
  - Rake tasks exposed by `puppet_litmus` (not present by default in this repo). See `Gemfile` group `:system_tests`.

## What to check when changing code
- Data vs code: if you change a path, add/update the proper Hiera key under `data/` (or the OS-specific file under `data/os/...`).
- Tests: add / update `spec/*` tests. Ensure `spec/spec_helper.rb` default facts still apply and set any additional facts there or in test files.
- Lint & warnings: run `bundle exec rake syntax` and `bundle exec rake` tasks to catch puppet-lint and other issues early.
- Consistency: follow the existing use of `lookup()`/`hiera()` and match the style (indentation and resource declarations) in `manifests/`.

## Examples (do this, not that)
- Good (mirrors project style):
  - Use `lookup('some_key')` when reading a path/key already expressed in Hiera.
  - Add data to `data/common.yaml` or OS-specific `data/os/*` entries.
  - Add unit tests under `spec/classes` that validate resources created in `manifests/`.
- Avoid:
  - Hardcoding environment-specific paths or removing Hiera lookups when there is an existing key (prefer single source-of-truth in `data/`).

## Known constraints & helpful facts
- Puppet requirement: module requires Puppet >= 7.24, < 9.0.0 (see `metadata.json`).
- PDK-related files were used to generate the module; standard PDK workflows apply.
- There is no CI workflow in `.github/workflows` presently — ask the maintainer if you should add GitHub Actions to run lint/tests.

---
If any part of this file is unclear or you'd like additional sections (for example: CI config, more test examples, or a CONTRIBUTING note), tell me which you'd like and I will iterate. 💡