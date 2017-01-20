PostgreSQL
==========

Database server with continuous archiving using [Wal-E](https://github.com/wal-e/wal-e).

## Getting started

### Wal-E

Set the environment variables for your platform as described in [Wal-E's source code ](https://github.com/wal-e/wal-e).

- [AWS S3](https://github.com/wal-e/wal-e#aws-s3-and-work-alikes)
- [Azure Blob Store](https://github.com/wal-e/wal-e#azure-blob-store)
- [Google Storage](https://github.com/wal-e/wal-e#google-storage)
- [Swift](https://github.com/wal-e/wal-e#swift)

### PostgreSQL

Follow the [instuctions for the official postgres](https://hub.docker.com/_/postgres) docker image to configure the PostgreSQL server.

It is highly recommended to set the `POSTGRES_PASSWORD` environment variable.

### Cron

You can change when full backups are made with the `CRON_PATTERN` environment
variable. It runs at midnight by default.

### Example

Archiving to AWS S3, with a full backup daily at 00:42.

```sh
docker run -d --name=postgres \
           -e POSTGRES_PASSWORD=pleasechangeme \
           -e WALE_S3_PREFIX=s3://bucket/path/optionallymorepath \
           -e AWS_ACCESS_KEY_ID=yourkeyhere \
           -e AWS_SECRET_ACCESS_KEY=yoursecrethere \
           -e CRON_PATTERN="42 0 * * *" \
           erlend/postgres
```
