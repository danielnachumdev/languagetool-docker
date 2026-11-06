# LanguageTool embedded HTTP server
# https://dev.languagetool.org/http-server

FROM eclipse-temurin:17-jre-jammy

ARG LT_URL=https://languagetool.org/download/LanguageTool-stable.zip

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl unzip \
    && curl -fsSL "$LT_URL" -o /tmp/lt.zip \
    && unzip -q /tmp/lt.zip -d /tmp \
    && mv /tmp/LanguageTool-* /app \
    && rm /tmp/lt.zip \
    && apt-get purge -y curl unzip \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY server.properties /app/server.properties

WORKDIR /app
EXPOSE 8081

# --public is required so the host can reach the server through Docker port publishing.
CMD ["java", "-cp", "languagetool-server.jar", "org.languagetool.server.HTTPServer", "--config", "server.properties", "--port", "8081", "--allow-origin", "--public"]
