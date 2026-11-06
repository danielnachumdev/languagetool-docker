# languagetool-docker

Run [LanguageTool](https://languagetool.org/)’s embedded HTTP server locally with Docker.

This follows [dev.languagetool.org/http-server](https://dev.languagetool.org/http-server). The local server does **not** include LanguageTool Cloud AI rules or add-on synonyms.

## Quick start

```bash
docker compose up -d
```

First build downloads LanguageTool stable (~250 MB) and may take a few minutes.

## Test

Browser:

http://localhost:8081/v2/check?language=en-US&text=my+text

curl:

```bash
curl -d "language=en-US" -d "text=a simple test" http://localhost:8081/v2/check
```

## Stop

```bash
docker compose down
```

`restart: unless-stopped` keeps the container running across Docker restarts until you stop it.

## Privacy

The image starts with `--public` so host → container port mapping works. Anything that can reach `localhost:8081` (or the published port on your network) can send text to this server. Do not expose that port on the public internet without a reverse proxy and access control.

Text is checked on your machine; it is not sent to LanguageTool Cloud.

## Pin a version

By default the image downloads `LanguageTool-stable.zip`. To pin a release:

```bash
docker compose build --build-arg LT_URL=https://languagetool.org/download/LanguageTool-6.6.zip
docker compose up -d
```

## Browser add-on

In the LanguageTool browser add-on: options → Experimental settings → Local server (port `8081`).

## License

This repository’s Docker wrapper is MIT. The LanguageTool software downloaded into the image is licensed separately by the LanguageTool project.
