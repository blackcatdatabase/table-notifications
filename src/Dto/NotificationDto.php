<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\Notifications\Dto;

/**
 * Jednoduché, neměnné DTO s veřejnými readonly vlastnostmi.
 * - Bez logiky; pouze nosič dat.
 * - Silné typy drží kontrakt napříč vrstvami.
 */
final class NotificationDto {
    public function __construct(
        public readonly ?int $id,
        public readonly ?int $userId,
        public readonly string $channel,
        public readonly string $template,
        public readonly array|null $payload,
        public readonly string $status,
        public readonly int $retries,
        public readonly int $maxRetries,
        public readonly ?\DateTimeImmutable $nextAttemptAt,
        public readonly ?\DateTimeImmutable $scheduledAt,
        public readonly ?\DateTimeImmutable $sentAt,
        public readonly ?string $error,
        public readonly ?\DateTimeImmutable $lastAttemptAt,
        public readonly ?\DateTimeImmutable $lockedUntil,
        public readonly ?string $lockedBy,
        public readonly int $priority,
        public readonly \DateTimeImmutable $createdAt,
        public readonly \DateTimeImmutable $updatedAt,
        public readonly int $version
    ) {}

    /** Vhodné pro serializaci/logování (bez velkých blobů). */
    public function toArray(): array {
        return get_object_vars($this);
    }
}
