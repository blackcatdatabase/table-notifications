-- Auto-generated from schema-map-mysql.psd1 (map@mtime:2025-10-24T09:13:35Z)
-- engine: mysql
-- table:  notifications
ALTER TABLE notifications ADD CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
