-- Auto-generated from joins-mysql.yaml (map@85230ed)
-- engine: mysql
-- view:   notifications_due

CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_notifications_due AS
SELECT
  n.id,
  n.channel,
  n.status,
  n.next_attempt_at,
  n.last_attempt_at,
  n.created_at,
  TIMESTAMPDIFF(SECOND, n.created_at, NOW()) AS age_sec,
  TIMESTAMPDIFF(SECOND, COALESCE(n.last_attempt_at, n.created_at), NOW()) AS idle_sec
FROM notifications n
WHERE n.status IN ('pending','processing')
  AND (n.next_attempt_at IS NULL OR n.next_attempt_at <= NOW());

-- Auto-generated from joins-mysql.yaml (map@85230ed)
-- engine: mysql
-- view:   notifications_queue_metrics

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_notifications_queue_metrics AS
WITH base AS (
  SELECT
    channel,
    status,
    COUNT(*) AS total,
    SUM(CASE WHEN status IN ('pending','processing') AND (next_attempt_at IS NULL OR next_attempt_at <= NOW())
             THEN 1 ELSE 0 END) AS due_now
  FROM notifications
  GROUP BY channel, status
),
ranked AS (
  SELECT
    channel,
    status,
    TIMESTAMPDIFF(SECOND, COALESCE(last_attempt_at, created_at), NOW()) AS age_sec,
    ROW_NUMBER() OVER (PARTITION BY channel, status ORDER BY TIMESTAMPDIFF(SECOND, COALESCE(last_attempt_at, created_at), NOW())) AS rn,
    COUNT(*) OVER (PARTITION BY channel, status) AS cnt
  FROM notifications
)
SELECT
  b.channel,
  b.status,
  b.total,
  b.due_now,
  MAX(CASE WHEN r.rn = CEIL(0.95 * r.cnt) THEN r.age_sec END) AS p95_age_sec
FROM base b
LEFT JOIN ranked r
  ON r.channel = b.channel AND r.status = b.status
GROUP BY b.channel, b.status, b.total, b.due_now;

