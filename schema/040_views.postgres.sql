-- Auto-generated from schema-views-postgres.psd1 (map@mtime:2025-11-27T15:36:13Z)
-- engine: postgres
-- table:  notifications

-- Contract view for [notifications]
-- Adds is_locked helper.
CREATE OR REPLACE VIEW vw_notifications AS
SELECT
  id,
  tenant_id,
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
  (locked_until IS NOT NULL AND locked_until > now()) AS is_locked,
  locked_by,
  priority,
  created_at,
  updated_at,
  version
FROM notifications;
