-- Auto-generated from schema-views-mysql.psd1 (map@mtime:2025-10-24T09:19:46Z)
-- engine: mysql
-- table:  notifications
-- Contract view for [notifications]
CREATE OR REPLACE VIEW vw_notifications AS
SELECT
  id,
  user_id,
  channel,
  template,
  payload,
  status,
  retries,
  max_retries,
  next_attempt_at,
  scheduled_at,
  sent_at,
  error,
  last_attempt_at,
  locked_until,
  locked_by,
  priority,
  created_at,
  updated_at
FROM notifications;
