-- Auto-generated from schema-map.psd1 on 2025-10-21T02:32:05
-- table: notifications
ALTER TABLE notifications ADD CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
