-- Auto-generated from schema-map.psd1 (map@1e83bb6)
-- table: notifications
ALTER TABLE notifications ADD CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
