-- Auto-generated from core\joins-postgres.yaml (map@sha1:29CF395A3A4C8964482083733F8E613ABFBEF5CC)
-- engine: postgres
-- view:   notifications_due

-- Notifications due for sending (pending/processing and due_now)
CREATE OR REPLACE VIEW vw_notifications_due AS
SELECT
  n.id,
  n.channel,
  n.status,
  n.next_attempt_at,
  n.last_attempt_at,
  n.created_at,
  EXTRACT(EPOCH FROM (now() - n.created_at)) AS age_sec,
  EXTRACT(EPOCH FROM (now() - COALESCE(n.last_attempt_at, n.created_at))) AS idle_sec
FROM notifications n
WHERE n.status IN ($$pending$$,$$processing$$)
  AND (n.next_attempt_at IS NULL OR n.next_attempt_at <= now());

-- Auto-generated from core\joins-postgres.yaml (map@sha1:29CF395A3A4C8964482083733F8E613ABFBEF5CC)
-- engine: postgres
-- view:   notifications_queue_metrics

-- Queue metrics for [notifications]
CREATE OR REPLACE VIEW vw_notifications_queue_metrics AS
SELECT
  channel,
  status,
  COUNT(*) AS total,
  COUNT(*) FILTER (WHERE status IN ('pending','processing') AND (next_attempt_at IS NULL OR next_attempt_at <= now())) AS due_now,
  PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY EXTRACT(EPOCH FROM (now() - COALESCE(last_attempt_at, created_at)))) AS p95_age_sec
FROM notifications
GROUP BY channel, status
ORDER BY channel, status;

