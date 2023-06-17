FROM node:20-alpine
RUN mkdir -p /opt/app
WORKDIR /opt/app
COPY . .

RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      harfbuzz \
      ca-certificates \
      ttf-freefont

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

RUN npm i -g pnpm
RUN pnpm install
EXPOSE 8000
CMD [ "npm", "run", "multiple" ]