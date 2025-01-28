# Stage 1: Base
FROM node:20.18-alpine3.20 AS base

# Install dependencies for building native modules
RUN apk update && apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    g++ \
    make \
    libffi-dev \
    bash 

WORKDIR /app

# Install PNPM and dependencies
RUN corepack enable
RUN chown node:node /app
USER node
ENV RUN_ENV=docker

# Copy only package files initially for caching
COPY --chown=node:node package*.json pnpm-lock.yaml ./

# Install dependencies with caching
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile

# Expose port
EXPOSE 5173

# Stage 2: Development
FROM base AS development

ENV NODE_ENV=development

# Copy the application source code
COPY --chown=node:node . .

# Start the Remix app in development mode
CMD ["pnpm", "run", "dev", "--port=5173", "--host=0.0.0.0"]

# Stage 3: Production
FROM base AS production

ENV NODE_ENV=production

# Copy built files from the base stage
COPY --from=base /app/public ./public
COPY --from=base /app/pnpm-lock.yaml ./
COPY --from=base /app/package.json ./

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

RUN pnpm run build

CMD ["pnpm", "start"]
