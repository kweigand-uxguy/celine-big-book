# Notification Bridge

Celine Server has a sanitized notification workflow concept for important events.

A Pushover-style notification provider may be used for server, deployment, bridge, or workflow events that Ken should see quickly.

## Rules

- Do not include provider keys in this repo.
- Do not expose notification tokens.
- Avoid notification spam.
- Critical events should notify Ken when notification settings are enabled locally.
- Notification failures should not break unrelated work unless the notification itself is the task.
