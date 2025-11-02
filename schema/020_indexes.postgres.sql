-- Auto-generated from schema-map-postgres.psd1 (map@db2f8b8)
-- engine: postgres
-- table:  notifications
CREATE INDEX IF NOT EXISTS idx_notifications_status_scheduled ON notifications (status, scheduled_at);

CREATE INDEX IF NOT EXISTS idx_notifications_next_attempt ON notifications (next_attempt_at);

CREATE INDEX IF NOT EXISTS idx_notifications_locked_until ON notifications (locked_until);
