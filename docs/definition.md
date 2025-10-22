<!-- Auto-generated from schema-map.psd1 @ 6cefe8e (2025-10-22T20:27:41+02:00) -->
# Definition – notifications

Outbox for templated user notifications.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT UNSIGNED | — | — | Surrogate primary key. |  |
| user_id | BIGINT UNSIGNED | YES | — | Target user (optional). |  |
| channel | ENUM('email','push') | NO | — | Delivery channel. | enum: email, push |
| template | VARCHAR(100) | NO | — | Template identifier. |  |
| payload | JSON | YES | — | JSON payload for template rendering. |  |
| status | ENUM('pending','processing','sent','failed') | NO | 'pending' | Processing status. | enum: pending, processing, sent, failed |
| retries | INT | NO | 0 | Attempt counter. |  |
| max_retries | INT | NO | 6 | Maximum attempts. |  |
| next_attempt_at | DATETIME(6) | YES | — | Backoff until (UTC). |  |
| scheduled_at | DATETIME(6) | YES | — | Scheduled send time (UTC). |  |
| sent_at | DATETIME(6) | YES | — | Actual send time (UTC). |  |
| error | TEXT | YES | — | Last error message. |  |
| last_attempt_at | DATETIME(6) | YES | — | Last attempt time (UTC). |  |
| locked_until | DATETIME(6) | YES | — | Worker lock until (UTC). |  |
| locked_by | VARCHAR(100) | YES | — | Worker id that holds the lock. |  |
| priority | INT | NO | 0 | Priority (higher = sooner). |  |
| created_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |  |
| updated_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) | Update timestamp (UTC). |  |