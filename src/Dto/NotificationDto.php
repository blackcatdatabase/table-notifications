<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\Notifications\Dto;

/**
 * Simple immutable DTO with public readonly properties.
 * - No logic; just a data carrier.
 * - Strong types enforce the contract across layers.
 */
final class NotificationDto implements \JsonSerializable {
    public function __construct(
        public readonly int $id,
        public readonly int $tenantId,
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

    /** Suitable for serialization/logging (without large blobs). */
    public function toArray(): array {
        return get_object_vars($this);
    }

    /** toArray() without null values - for clean logging/diffs. */
    public function toArrayNonNull(): array {
        return array_filter(get_object_vars($this), static fn($v) => $v !== null);
    }

    public function jsonSerialize(): array {
       $a = $this->toArray();
       foreach ($a as $k => $v) {
           if ($v instanceof \DateTimeInterface) {
               // ISO-8601 with a timezone; switch to 'Y-m-d H:i:s.u' if needed
               $a[$k] = $v->format(\DateTimeInterface::ATOM);
           }
       }
       return $a;
   }
}
