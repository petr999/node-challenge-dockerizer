FROM postgres:14-bullseye

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

RUN chown -Rf postgres /var/lib/postgresql

USER postgres

RUN /docker-entrypoint.sh

EXPOSE 5432
CMD ["postgres"]
