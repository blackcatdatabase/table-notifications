# 📦 Notifications

![SQL](https://img.shields.io/badge/SQL-MySQL%208.0%2B-4479A1?logo=mysql&logoColor=white) ![License](https://img.shields.io/badge/license-BlackCat%20Proprietary-red) ![Status](https://img.shields.io/badge/status-stable-informational) ![Generated](https://img.shields.io/badge/generated-from%20schema--map-blue)

<!-- Auto-generated from schema-map.psd1 @ 1e83bb6 (2025-10-21T10:18:36+02:00) -->

> Schema package for table **notifications** (repo: `notifications`).

## Files
```
schema/
  001_table.sql
  # (no deferred indexes declared in map)
  030_foreign_keys.sql
```

## Quick apply
```bash
# Apply schema (Linux/macOS):
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/001_table.sql
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/030_foreign_keys.sql
```

```powershell
# Apply schema (Windows PowerShell):
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/001_table.sql
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/030_foreign_keys.sql
```

## Docker quickstart
```bash
# Spin up a throwaway MySQL and apply just this package:
docker run --rm -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=app -p 3307:3306 -d mysql:8
sleep 15
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/001_table.sql
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/030_foreign_keys.sql
```

## Columns
| Column | Type | Null | Default | Extra |
|-------:|:-----|:----:|:--------|:------|
| id | BIGINT UNSIGNED | — | — | AUTO_INCREMENT, PK |
| user_id | BIGINT UNSIGNED | YES | — |  |
| channel | ENUM('email','push') | NO | — |  |
| template | VARCHAR(100) | NO | — |  |
| payload | JSON | YES | — |  |
| status | ENUM('pending','processing','sent','failed') | NO | '' |  |
| retries | INT | NO | 0 |  |
| max_retries | INT | NO | 6 |  |
| next_attempt_at | DATETIME(6) | YES | — |  |
| scheduled_at | DATETIME(6) | YES | — |  |
| sent_at | DATETIME(6) | YES | — |  |
| error | TEXT | YES | — |  |
| last_attempt_at | DATETIME(6) | YES | — |  |
| locked_until | DATETIME(6) | YES | — |  |
| locked_by | VARCHAR(100) | YES | — |  |
| priority | INT | NO | 0 |  |
| created_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) |  |
| updated_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) |  |

## Relationships
- FK → **users** via (user_id) (ON DELETE CASCADE).

```mermaid
erDiagram
  NOTIFICATIONS {
    INT id PK
    INT user_id
    ENUM channel
    VARCHAR template
    JSON payload
    ENUM status
    INT retries
    INT max_retries
    DATETIME next_attempt_at
    DATETIME scheduled_at
    DATETIME sent_at
    VARCHAR error
    DATETIME last_attempt_at
    DATETIME locked_until
    VARCHAR locked_by
    INT priority
    DATETIME created_at
    DATETIME updated_at
  }
  NOTIFICATIONS }o--|| USERS : "user_id"
```

## Indexes
- No deferred indexes declared for this table.

## Notes
- Generated from the umbrella repository **blackcat-database** using `scripts/schema-map.psd1`.
- To change the schema, update the map and re-run the generators.

## License
Distributed under the **BlackCat Store Proprietary License v1.0**. See `LICENSE`.
