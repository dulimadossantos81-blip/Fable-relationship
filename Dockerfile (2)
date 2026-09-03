FROM node:22-bookworm-slim AS extractor

WORKDIR /build

COPY fable-relationship-v0.2.zip .

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip \
    && unzip -q fable-relationship-v0.2.zip -d /app \
    && rm -rf /var/lib/apt/lists/*

FROM denoland/deno:2.5.0

WORKDIR /app

COPY --from=extractor /app/ ./

RUN sed -i "s/Deno.serve(async (request: Request) => {/Deno.serve({ port: Number(Deno.env.get('PORT') ?? '8000') }, async (request: Request) => {/" src/deno.ts

RUN deno cache --allow-scripts src/deno.ts

CMD ["deno", "run", "-A", "--env", "src/deno.ts"]
