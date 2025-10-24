-- Auto-generated from schema-map-postgres.psd1 (map@mtime:2025-10-24T09:46:38Z)
-- engine: postgres
-- table:  notifications
CREATE INDEX idx_notifications_status_scheduled ON notifications (status, scheduled_at);

CREATE INDEX idx_notifications_next_attempt ON notifications (next_attempt_at);

CREATE INDEX idx_notifications_locked_until ON notifications (locked_until);
