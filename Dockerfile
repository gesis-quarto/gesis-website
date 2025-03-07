ARG QUARTO_VERSION=1.7.14

FROM debian:12.9-slim AS downloader

ARG QUARTO_VERSION

ADD https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb /tmp/quarto.deb

FROM debian:12.9-slim

RUN --mount=type=bind,from=downloader,source=/tmp,target=/tmp dpkg -i /tmp/quarto.deb

WORKDIR /mnt/gesis

EXPOSE 4444

ENTRYPOINT ["quarto"]

CMD ["preview", "--host", "0.0.0.0", "--port", "4444", "--render", "html", "--no-browser"]