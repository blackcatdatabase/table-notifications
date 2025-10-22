-- Auto-generated from schema-map.psd1 (map@6cefe8e)
-- table: notifications
ALTER TABLE notifications ADD CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
