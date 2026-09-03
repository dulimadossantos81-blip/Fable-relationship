FROM denoland/deno:2.5.0

WORKDIR /app

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL \
      "https://github.com/dulimadossantos81-blip/fable-relationship/raw/refs/heads/main/fable-relationship-v0.3.zip" \
      -o /tmp/fable.zip \
    && unzip -q /tmp/fable.zip -d /app \
    && rm /tmp/fable.zip

RUN sed -i \
      "s/import relationship from '~\/src\/relationship\/index.ts';/import * as relationship from '~\/src\/relationship\/index.ts';/g" \
      src/gacha.ts src/interactions.ts

RUN sed -i \
      "s/Deno.serve(async (request: Request) => {/Deno.serve({ port: Number(Deno.env.get('PORT') ?? '8000') }, async (request: Request) => {/" \
      src/deno.ts

RUN deno cache --allow-scripts src/deno.ts

CMD ["sh", "-c", "deno run -A --env update_commands.ts && deno run -A --env src/deno.ts"]
