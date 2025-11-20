-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
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

-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  notifications_queue_metrics
-- Queue metrics for [notifications]
CREATE OR REPLACE VIEW vw_notifications_queue_metrics AS
SELECT
  channel,
  status,
  COUNT(*) AS total,
  COUNT(*) FILTER (WHERE status IN (''pending'',''processing'') AND (next_attempt_at IS NULL OR next_attempt_at <= now())) AS due_now,
  PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY EXTRACT(EPOCH FROM (now() - COALESCE(last_attempt_at, created_at)))) AS p95_age_sec
FROM notifications
GROUP BY channel, status
ORDER BY channel, status;

