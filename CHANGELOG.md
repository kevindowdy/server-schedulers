# Changelog

## [Unreleased]

### Added

- `youtube-social` job: systemd service and timer running `main.py --group social` daily at 09:00 on air01.
- `installers/install-air01.sh`: deploys air01's job units to `/etc/systemd/system` and enables their timers.

## [0.0.0] - 2026-10-22

### Added

- Initial project template: source layout, test scaffolding, CI/CD workflows, and contributor documentation.
