-- Auto-generated from schema-map-postgres.yaml (map@sha1:8C4F2BC1C4D22EE71E27B5A7968C71E32D8D884D)
-- engine: postgres
-- table:  notifications

CREATE INDEX IF NOT EXISTS idx_notifications_status_scheduled ON notifications (status, scheduled_at);

CREATE INDEX IF NOT EXISTS idx_notifications_next_attempt ON notifications (next_attempt_at);

CREATE INDEX IF NOT EXISTS idx_notifications_locked_until_active ON notifications (locked_until) WHERE status IN ('pending','processing');

CREATE INDEX IF NOT EXISTS gin_notifications_payload ON notifications USING GIN (payload jsonb_path_ops);

CREATE INDEX IF NOT EXISTS idx_notifications_tenant_status_sched ON notifications (tenant_id, status, scheduled_at);
