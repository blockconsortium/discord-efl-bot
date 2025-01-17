# --- !Ups
CREATE TABLE IF NOT EXISTS settings (
    `key`       VARCHAR(128)        NOT NULL
    , `value`   VARCHAR(255)        NOT NULL

    , PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS users (
    id                  BIGINT UNSIGNED     NOT NULL    AUTO_INCREMENT
    , discord_user_id   BIGINT UNSIGNED     NOT NULL
    , created           DATETIME            NOT NULL    DEFAULT CURRENT_TIMESTAMP

    , PRIMARY KEY (id)
    , UNIQUE(discord_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS wallet_addresses (
    id                      BIGINT UNSIGNED     NOT NULL    AUTO_INCREMENT
    , current_user_id       BIGINT UNSIGNED     NOT NULL
    , address               VARCHAR(64)         NOT NULL
    , locked_until          DATETIME            NOT NULL
    , created               DATETIME            DEFAULT CURRENT_TIMESTAMP

    , PRIMARY KEY (id)
    , INDEX (current_user_id)
    , UNIQUE (address)
    , INDEX (locked_until)

    , CONSTRAINT wallet_addresses_current_user_id FOREIGN KEY (current_user_id) REFERENCES users (id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS transactions (
    id                  BIGINT UNSIGNED     NOT NULL    AUTO_INCREMENT
    , from_user_id      BIGINT UNSIGNED                 DEFAULT NULL
    , to_user_id        BIGINT UNSIGNED                 DEFAULT NULL
    , status            ENUM(
                            'confirmed',
                            'pending',
                            'invalid'
                        )                   NOT NULL
    , transaction_type  ENUM(
                            'deposit',
                            'withdrawal',
                            'tip'
                        )                   NOT NULL
    , amount            BIGINT              NOT NULL
    , transaction_id    VARCHAR(128)                    DEFAULT NULL
    , vout              INT(6)                          DEFAULT NULL
    , created           DATETIME            NOT NULL    DEFAULT CURRENT_TIMESTAMP

    , PRIMARY KEY (id)
    , INDEX (from_user_id)
    , INDEX (to_user_id)
    , INDEX (status)
    , INDEX (transaction_type)
    , UNIQUE (transaction_id, vout)

    , CONSTRAINT transactions_ibfk_from_user_id FOREIGN KEY (from_user_id) REFERENCES users (id) ON DELETE RESTRICT
    , CONSTRAINT transactions_ibfk_to_user_id FOREIGN KEY (to_user_id) REFERENCES users (id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# --- !Downs
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS wallet_addresses;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS settings;
