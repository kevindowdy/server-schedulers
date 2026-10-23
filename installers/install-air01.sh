#!/usr/bin/env bash
#
# Installs this repo's air01 jobs as systemd units and starts their timers.
# Must be run as root (system unit files live under /etc/systemd/system).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
readonly REPO_ROOT
readonly SYSTEMD_UNIT_DIR="/etc/systemd/system"
readonly AIR01_JOBS=(
  "youtube-social"
  "youtube-segments"
  "social-crosspost"
)

require_root() {
  if [[ "${EUID}" -ne 0 ]]; then
    echo "error: must be run as root (try: sudo ${0})" >&2
    exit 1
  fi
}

install_job() {
  local job_name="$1"
  local job_dir="${REPO_ROOT}/jobs/${job_name}"
  local service_file="${job_dir}/${job_name}.service"
  local timer_file="${job_dir}/${job_name}.timer"

  if [[ ! -f "${service_file}" || ! -f "${timer_file}" ]]; then
    echo "error: missing unit files for job '${job_name}' in ${job_dir}" >&2
    exit 1
  fi

  install -m 644 "${service_file}" "${SYSTEMD_UNIT_DIR}/${job_name}.service"
  install -m 644 "${timer_file}" "${SYSTEMD_UNIT_DIR}/${job_name}.timer"
  echo "installed ${job_name}.service and ${job_name}.timer"
}

enable_job_timer() {
  local job_name="$1"
  systemctl enable --now "${job_name}.timer"
  echo "enabled ${job_name}.timer"
}

main() {
  require_root

  for job_name in "${AIR01_JOBS[@]}"; do
    install_job "${job_name}"
  done

  systemctl daemon-reload

  for job_name in "${AIR01_JOBS[@]}"; do
    enable_job_timer "${job_name}"
  done

  echo "air01 install complete."
}

main "$@"
