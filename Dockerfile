FROM alpine:3.4

EXPOSE 5432

ENV PGDATA=/var/lib/postgresql/data \
    AWS_REGION=us-west-1 \
    LC_ALL=en_US.UTF-8 \
    CRON_PATTERN="0 0 * * *"

VOLUME /var/lib/postgresql/data

# Install PostgreSQL and WAL-E
RUN echo "@edge http://dl-2.alpinelinux.org/alpine/edge/community" \
      >> etc/apk/repositories && \
    apk add -U groff su-exec postgresql postgresql-contrib dcron python3 \
      python3-dev g++ runit@edge pv@edge && \
    pip3 install --upgrade pip && \
    pip3 install wal-e boto

# Configure postgresql archiving
RUN sed -e "s|#\(archive_mode =\) .*|\1 on|"                              \
        -e "s|#\(archive_command =\) .*|\1 '/wal-e-wrapper wal-push %p'|" \
        -e "s|#\(archive_timeout =\) .*|\1 60|"                           \
        -e "s|#\(wal_level =\) .*|\1 archive|"                            \
        -i /usr/share/postgresql/postgresql.conf.sample

# Cleanup
RUN apk del python3-dev g++ && \
    rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

COPY etc /etc
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
