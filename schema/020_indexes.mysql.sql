-- Auto-generated from schema-map-mysql.yaml (map@sha1:0D716345C0228A9FD8972A3D31574000D05317DB)
-- engine: mysql
-- table:  notifications

CREATE INDEX idx_notifications_status_scheduled ON notifications (status, scheduled_at);

CREATE INDEX idx_notifications_next_attempt ON notifications (next_attempt_at);

CREATE INDEX idx_notifications_locked_until_active ON notifications (locked_until);

CREATE INDEX idx_notifications_tenant_status_sched ON notifications (tenant_id, status, scheduled_at);
