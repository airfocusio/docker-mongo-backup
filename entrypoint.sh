#!/bin/bash
set -e

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
  --gzip --archive | mc pipe "backup/${S3_DIRECTORY}/${FOLDER}/${FILE}"
