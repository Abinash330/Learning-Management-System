-- ============================================================
--  Broadcast Email Log table — run once in MySQL
-- ============================================================
CREATE TABLE IF NOT EXISTS email_broadcast_log (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    subject         VARCHAR(255) NOT NULL,
    message         TEXT         NOT NULL,
    audience        VARCHAR(100) NOT NULL,
    recipient_count INT          NOT NULL DEFAULT 0,
    sent_at         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
