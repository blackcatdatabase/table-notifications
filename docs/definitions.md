# notifications

Outbox for templated user notifications.

## Columns
| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| id | BIGINT | NO |  | Surrogate primary key. |
| user_id | BIGINT | YES |  | Target user (optional). |
| channel | mysql: ENUM('email','push') / postgres: TEXT | NO |  | Delivery channel. (enum: email, push) |
| template | VARCHAR(100) | NO |  | Template identifier. |
| payload | mysql: JSON / postgres: JSONB | YES |  | JSON payload for template rendering. |
| status | mysql: ENUM('pending','processing','sent','failed') / postgres: TEXT | NO | pending | Processing status. (enum: pending, processing, sent, failed) |
| retries | mysql: INT / postgres: INTEGER | NO | 0 | Attempt counter. |
| max_retries | mysql: INT / postgres: INTEGER | NO | 6 | Maximum attempts. |
| next_attempt_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | YES |  | Backoff until (UTC). |
| scheduled_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | YES |  | Scheduled send time (UTC). |
| sent_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | YES |  | Actual send time (UTC). |
| error | TEXT | YES |  | Last error message. |
| last_attempt_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | YES |  | Last attempt time (UTC). |
| locked_until | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | YES |  | Worker lock until (UTC). |
| locked_by | VARCHAR(100) | YES |  | Worker id that holds the lock. |
| priority | mysql: INT / postgres: INTEGER | NO | 0 | Priority (higher = sooner). |
| created_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |
| updated_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Update timestamp (UTC). |

## Engine Details

### mysql

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_notifications_locked_until_active | locked_until | CREATE INDEX idx_notifications_locked_until_active ON notifications (locked_until) |
| idx_notifications_next_attempt | next_attempt_at | CREATE INDEX idx_notifications_next_attempt ON notifications (next_attempt_at) |
| idx_notifications_status_scheduled | status,scheduled_at | CREATE INDEX idx_notifications_status_scheduled ON notifications (status, scheduled_at) |
| idx_notifications_tenant_status_sched | tenant_id,status,scheduled_at | CREATE INDEX idx_notifications_tenant_status_sched ON notifications (tenant_id, status, scheduled_at) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_notifications_tenant | tenant_id | tenants(id) | ON DELETE RESTRICT |
| fk_notifications_user | user_id | users(id) | ON DELETE CASCADE |

### postgres

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| gin_notifications_payload | payloadjsonb_path_ops | CREATE INDEX IF NOT EXISTS gin_notifications_payload ON notifications USING GIN (payload jsonb_path_ops) |
| idx_notifications_locked_until_active | locked_until | CREATE INDEX IF NOT EXISTS idx_notifications_locked_until_active ON notifications (locked_until) WHERE status IN ('pending','processing') |
| idx_notifications_next_attempt | next_attempt_at | CREATE INDEX IF NOT EXISTS idx_notifications_next_attempt ON notifications (next_attempt_at) |
| idx_notifications_status_scheduled | status,scheduled_at | CREATE INDEX IF NOT EXISTS idx_notifications_status_scheduled ON notifications (status, scheduled_at) |
| idx_notifications_tenant_status_sched | tenant_id,status,scheduled_at | CREATE INDEX IF NOT EXISTS idx_notifications_tenant_status_sched ON notifications (tenant_id, status, scheduled_at) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_notifications_tenant | tenant_id | tenants(id) | ON DELETE RESTRICT |
| fk_notifications_user | user_id | users(id) | ON DELETE CASCADE |

## Engine differences

## Views
| View | Engine | Flags | File |
| --- | --- | --- | --- |
| vw_notifications | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views.mysql.sql](../schema/040_views.mysql.sql) |
| vw_notifications_due | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_notifications_queue_metrics | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_notifications | postgres |  | [../schema/040_views.postgres.sql](../schema/040_views.postgres.sql) |
| vw_notifications_due | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
| vw_notifications_queue_metrics | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
