#!/bin/bash
set -e
set -o pipefail

function encrypt {
  if [ -z "${S3_GPG_ENCRYPTION_PASSPHRASE}" ]
  then
    cat
  else
    gpg --symmetric --batch --passphrase "${S3_GPG_ENCRYPTION_PASSPHRASE}"
  fi
}

function decrypt {
  if [ -z "${S3_GPG_ENCRYPTION_PASSPHRASE}" ]
  then
    cat
  else
    gpg --decrypty --batch --passphrase "${S3_GPG_ENCRYPTION_PASSPHRASE}"
  fi
}

if [ "$1" == "backup" ]; then
  mc config host add backup ${S3_HOST} ${S3_ACCESS_KEY_ID} ${S3_ACCESS_KEY_SECRET}
  FOLDER="$(/bin/date +%Y)/$(/bin/date +%Y-%m)/$(/bin/date +%Y-%m-%d)"
  FILE="$(/bin/date +%Y-%m-%d-%H%M%S)-${DATABASE}.mongodb.gz"
  mongodump \
    --host "${HOST}" \
    --port "${PORT:-27017}" \
    --db "${DATABASE}" \
    --username "${USERNAME}" \
    --password "${PASSWORD}" \
    --authenticationDatabase "${AUTH_DATABASE:-admin}" \
    --gzip --archive | encrypt | mc pipe "backup/${S3_DIRECTORY}/${FOLDER}/${FILE}"

  if [ -z "${S3_CLEAN_OLDER_THAN}" ]
  then
    echo "Skipping cleanup of old backups."
  else
    mc rm -r --force --older-than "${S3_CLEAN_OLDER_THAN}" "backup/${S3_DIRECTORY}"
  fi
elif [ "$1" == "restore" ]; then
  mc config host add backup ${S3_HOST} ${S3_ACCESS_KEY_ID} ${S3_ACCESS_KEY_SECRET}
  mc cat "backup/${S3_DIRECTORY}/$2" | decrypt | mongorestore \
    --host "${HOST}" \
    --port "${PORT:-27017}" \
    --username "${USERNAME}" \
    --password "${PASSWORD}" \
    --authenticationDatabase "${AUTH_DATABASE:-admin}" \
    --gzip --archive --drop
else
  echo "Mode must be backup or restore!"
  exit 1
fi
