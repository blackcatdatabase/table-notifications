-- Auto-generated from schema-map-mysql.yaml (map@sha1:B9D3BE28A74392B9B389FDAFB493BD80FA1F6FA4)
-- engine: mysql
-- table:  notifications

ALTER TABLE notifications ADD CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE notifications ADD CONSTRAINT fk_notifications_tenant FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE RESTRICT;

ALTER TABLE notifications ADD CONSTRAINT chk_notifications_retries CHECK (retries >= 0 AND max_retries >= 0);
