-- Auto-generated from schema-map-mysql.yaml (map@sha1:B9D3BE28A74392B9B389FDAFB493BD80FA1F6FA4)
-- engine: mysql
-- table:  notifications

CREATE INDEX idx_notifications_status_scheduled ON notifications (status, scheduled_at);

CREATE INDEX idx_notifications_next_attempt ON notifications (next_attempt_at);

CREATE INDEX idx_notifications_locked_until_active ON notifications (locked_until);

CREATE INDEX idx_notifications_tenant_status_sched ON notifications (tenant_id, status, scheduled_at);
