<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->
# Definition – notifications

Outbox for templated user notifications.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT | — | AS | Surrogate primary key. |  |
| tenant_id | BIGINT | NO | — |  |  |
| user_id | BIGINT | YES | — | Target user (optional). |  |
| channel | TEXT | NO | — | Delivery channel. | enum: email, push |
| template | VARCHAR(100) | NO | — | Template identifier. |  |
| payload | JSONB | YES | — | JSON payload for template rendering. |  |
| status | TEXT | NO | 'pending' | Processing status. | enum: pending, processing, sent, failed |
| retries | INTEGER | NO | 0 | Attempt counter. |  |
| max_retries | INTEGER | NO | 6 | Maximum attempts. |  |
| next_attempt_at | TIMESTAMPTZ(6) | YES | — | Backoff until (UTC). |  |
| scheduled_at | TIMESTAMPTZ(6) | YES | — | Scheduled send time (UTC). |  |
| sent_at | TIMESTAMPTZ(6) | YES | — | Actual send time (UTC). |  |
| error | TEXT | YES | — | Last error message. |  |
| last_attempt_at | TIMESTAMPTZ(6) | YES | — | Last attempt time (UTC). |  |
| locked_until | TIMESTAMPTZ(6) | YES | — | Worker lock until (UTC). |  |
| locked_by | VARCHAR(100) | YES | — | Worker id that holds the lock. |  |
| priority | INTEGER | NO | 0 | Priority (higher = sooner). |  |
| created_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |  |
| updated_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Update timestamp (UTC). |  |
| version | INTEGER | NO | 0 |  |  |