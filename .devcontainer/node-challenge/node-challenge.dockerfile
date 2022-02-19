FROM node:16-bullseye
RUN npm i -g npm

RUN apt update
RUN apt install --no-install-recommends -y aptitude
RUN aptitude install --without-recommends -y man less neovim tmux jq wget git recode postgresql-client
RUN aptitude clean -y
RUN rm -rf /var/lib/apt/lists/*

ENV HOME=/app
ARG USER UID

RUN groupadd --gid "${UID}" "${USER}" \
    && useradd --uid "${UID}" --gid "${UID}" --home-dir ${HOME} "${USER}" \
    && mkdir -m 0700 /app \
    && chown -Rf "${USER}":"${USER}" /app

USER "${USER}"

WORKDIR $HOME
RUN touch .hushlogin

CMD ["sleep","infinity"]
