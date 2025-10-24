<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\Notifications;

final class Definitions {
    // --- základní metadata ---
    public static function table(): string { return 'notifications'; }
    public static function contractView(): string { return 'vw_notifications'; }
    /** @return string[] */
    public static function columns(): array { return [ 'id', 'user_id', 'channel', 'template', 'payload', 'status', 'retries', 'max_retries', 'next_attempt_at', 'scheduled_at', 'sent_at', 'error', 'last_attempt_at', 'locked_until', 'locked_by', 'priority', 'created_at', 'updated_at' ]; }
    public static function pk(): string { return 'id'; }

    // --- volitelná metadata (mohou být prázdná) ---
    public static function softDeleteColumn(): ?string {
        $c = ''; return $c !== '' ? $c : null;
    }
    public static function updatedAtColumn(): ?string {
        $c = 'updated_at'; return $c !== '' ? $c : null;
    }
    public static function versionColumn(): ?string {
        $c = ''; return $c !== '' ? $c : null; // pro optimistic locking
    }
    /** např. "created_at DESC, id DESC" */
    public static function defaultOrder(): ?string {
        $c = 'created_at DESC, id DESC'; return $c !== '' ? $c : null;
    }
    /** @return array<int,array<int,string>> seznam unikátních klíčů (sloupcových kombinací) */
    public static function uniqueKeys(): array { return []; }
    /** @return string[] JSON sloupce kvůli castům/operacím */
    public static function jsonColumns(): array { return [ 'payload' ]; }

    // --- pomocníci ---
    public static function hasColumn(string $col): bool {
        static $set = null;
        if ($set === null) { $set = array_fill_keys(self::columns(), true); }
        return isset($set[$col]);
    }
}
