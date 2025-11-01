-- Auto-generated from schema-views-postgres.psd1 (map@c5e4097)
-- engine: postgres
-- table:  notifications
-- Contract view for [notifications]
-- Adds is_locked helper.
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
  CASE WHEN (locked_until IS NOT NULL AND locked_until > now()) THEN 1 ELSE 0 END AS is_locked,
  locked_by,
  priority,
  created_at,
  updated_at,
  version
FROM notifications;
