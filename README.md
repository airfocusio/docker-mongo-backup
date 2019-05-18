# mongo-backup

```
docker run --rm \
  -e HOST=mongodb://localhost:27017
  -e DATABASE=mydatabase
  -e USERNAME=user
  -e PASSWORD=pass
  -e AUTH_DATABASE=admin
  -e S3_HOST=https://fra1.digitaloceanspaces.com
  -e S3_ACCESS_KEY_ID=id
  -e S3_ACCESS_KEY_SECRET=secret
  -e S3_DIRECTORY=myspace/mongo-backup \
  airfocusio/mongo-backup:3.6.12
```
