# mongo-backup

```
docker run --rm \
  -e HOST=localhost \
  -e PORT=27017 \
  -e DATABASE=mydatabase \
  -e USERNAME=user \
  -e PASSWORD=pass \
  -e AUTH_DATABASE=admin \
  -e S3_HOST=https://fra1.digitaloceanspaces.com \
  -e S3_ACCESS_KEY_ID=id \
  -e S3_ACCESS_KEY_SECRET=secret \
  -e S3_DIRECTORY=myspace/mongo-backup \
  -e S3_CLEAN_OLDER_THAN=30d \
  -e S3_GPG_ENCRYPTION_PASSPHRASE=secret \
  airfocusio/mongo-backup:4.0.9 \
  backup
```

```
docker run --rm \
  -e HOST=localhost \
  -e PORT=27017 \
  -e DATABASE=mydatabase \
  -e USERNAME=user \
  -e PASSWORD=pass \
  -e AUTH_DATABASE=admin \
  -e S3_HOST=https://fra1.digitaloceanspaces.com \
  -e S3_ACCESS_KEY_ID=id \
  -e S3_ACCESS_KEY_SECRET=secret \
  -e S3_DIRECTORY=myspace/mongo-backup \
  airfocusio/mongo-backup:4.0.9 \
  restore 2019/2019-01/2019-01-01/2019-01-01-010203-mydatabase.mongodb.gz
```