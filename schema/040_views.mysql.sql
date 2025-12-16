-- Auto-generated from schema-views-mysql.yaml (map@sha1:FFA9A9D6FA9EE079B0DAEBB6FEE023C138E8FFA1)
-- engine: mysql
-- table:  notifications

-- Contract view for [notifications]
-- Adds is_locked helper.
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_notifications AS
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
  (locked_until IS NOT NULL AND locked_until > NOW()) AS is_locked,
  locked_by,
  priority,
  created_at,
  updated_at,
  version
FROM notifications;
