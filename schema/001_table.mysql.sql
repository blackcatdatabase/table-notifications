-- Auto-generated from schema-map-mysql.yaml (map@sha1:7AAC4013A2623AC60C658C9BF8458EFE0C7AB741)
-- engine: mysql
-- table:  notifications

CREATE TABLE IF NOT EXISTS notifications (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tenant_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NULL,
  channel ENUM('email','push') NOT NULL,
  template VARCHAR(100) NOT NULL,
  payload JSON NULL,
  status ENUM('pending','processing','sent','failed') NOT NULL DEFAULT 'pending',
  retries INT NOT NULL DEFAULT 0,
  max_retries INT NOT NULL DEFAULT 6,
  next_attempt_at DATETIME(6) NULL,
  scheduled_at DATETIME(6) NULL,
  sent_at DATETIME(6) NULL,
  error TEXT NULL,
  last_attempt_at DATETIME(6) NULL,
  locked_until DATETIME(6) NULL,
  locked_by VARCHAR(100) NULL,
  priority INT NOT NULL DEFAULT 0,
  created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  version INT UNSIGNED NOT NULL DEFAULT 0,
  INDEX idx_notifications_status_scheduled (status, scheduled_at),
  INDEX idx_notifications_tenant_status_sched (tenant_id, status, scheduled_at),
  INDEX idx_notifications_next_attempt (next_attempt_at),
  INDEX idx_notifications_locked_until_active (locked_until)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
