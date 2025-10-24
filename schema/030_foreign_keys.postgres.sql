-- Auto-generated from schema-map-postgres.psd1 (map@mtime:2025-10-24T09:46:38Z)
-- engine: postgres
-- table:  notifications
ALTER TABLE notifications ADD CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
