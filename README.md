# Server Schedulers
Centralized repository for managing and deploying scheduled automation jobs across home lab servers. Organizes systemd service and timer configurations by job, with host-specific deployment scripts for consistent, scalable automation management.

## Structure

```text
jobs/<job-name>/<job-name>.service   # what to run
jobs/<job-name>/<job-name>.timer     # when to run it
installers/install-<host>.sh         # deploys that host's jobs as systemd units
```

## Jobs

| Job | Host | Schedule | Command |
| --- | --- | --- | --- |
| `youtube-social` | air01 | Daily at 09:00 | `venv/bin/python3 main.py --group social` in `/home/kd/tools/upload-video-to-youtube` |

## Deploying to a host

Clone repository to target host in tools directory
```bash
git clone git@github.com:kevindowdy/server-schedulers.git
```

Run the matching installer as root on the target host after pulling this repo:

```bash
sudo installers/install-air01.sh
```

It copies that host's unit files into `/etc/systemd/system`, reloads the systemd daemon, and enables + starts each job's timer.
