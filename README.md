# 📦 Notifications

![SQL](https://img.shields.io/badge/SQL-MySQL%208.0%2B-4479A1?logo=mysql&logoColor=white) ![License](https://img.shields.io/badge/license-BlackCat%20Proprietary-red) ![Status](https://img.shields.io/badge/status-stable-informational) ![Generated](https://img.shields.io/badge/generated-from%20schema--map-blue)

<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->

> Schema package for table **notifications** (repo: `notifications`).

## Files
```
schema/
  001_table.sql
  020_indexes.sql
  030_foreign_keys.sql
```

## Quick apply
```bash
# Apply schema (Linux/macOS):
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/001_table.sql
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/020_indexes.sql
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/030_foreign_keys.sql
```

```powershell
# Apply schema (Windows PowerShell):
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/001_table.sql
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/020_indexes.sql
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/030_foreign_keys.sql
```

## Docker quickstart
```bash
# Spin up a throwaway MySQL and apply just this package:
docker run --rm -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=app -p 3307:3306 -d mysql:8
sleep 15
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/001_table.sql
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/020_indexes.sql
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/030_foreign_keys.sql
```

## Columns
| Column | Type | Null | Default | Extra |
|-------:|:-----|:----:|:--------|:------|
| id | BIGINT | — | AS | PK |
| tenant_id | BIGINT | NO | — |  |
| user_id | BIGINT | YES | — |  |
| channel | TEXT | NO | — |  |
| template | VARCHAR(100) | NO | — |  |
| payload | JSONB | YES | — |  |
| status | TEXT | NO | 'pending' |  |
| retries | INTEGER | NO | 0 |  |
| max_retries | INTEGER | NO | 6 |  |
| next_attempt_at | TIMESTAMPTZ(6) | YES | — |  |
| scheduled_at | TIMESTAMPTZ(6) | YES | — |  |
| sent_at | TIMESTAMPTZ(6) | YES | — |  |
| error | TEXT | YES | — |  |
| last_attempt_at | TIMESTAMPTZ(6) | YES | — |  |
| locked_until | TIMESTAMPTZ(6) | YES | — |  |
| locked_by | VARCHAR(100) | YES | — |  |
| priority | INTEGER | NO | 0 |  |
| created_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) |  |
| updated_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) |  |
| version | INTEGER | NO | 0 |  |

## Relationships
- FK → **tenants** via (tenant_id) (ON DELETE RESTRICT).
- FK → **users** via (user_id) (ON DELETE CASCADE).

```mermaid
erDiagram
  NOTIFICATIONS {
    INT id PK
    INT tenant_id
    INT user_id
    VARCHAR channel
    VARCHAR template
    JSONB payload
    VARCHAR status
    INTEGER retries
    INTEGER max_retries
    TIMESTAMPTZ next_attempt_at
    TIMESTAMPTZ scheduled_at
    TIMESTAMPTZ sent_at
    VARCHAR error
    TIMESTAMPTZ last_attempt_at
    TIMESTAMPTZ locked_until
    VARCHAR locked_by
    INTEGER priority
    TIMESTAMPTZ created_at
    TIMESTAMPTZ updated_at
    INTEGER version
  }
  NOTIFICATIONS }o--|| TENANTS : "tenant_id"
  NOTIFICATIONS }o--|| USERS : "user_id"
```

## Indexes
- 5 deferred index statement(s) in schema/020_indexes.sql.

## Notes
- Generated from the umbrella repository **blackcat-database** using `scripts/schema-map.psd1`.
- To change the schema, update the map and re-run the generators.

## License
Distributed under the **BlackCat Store Proprietary License v1.0**. See `LICENSE`.
