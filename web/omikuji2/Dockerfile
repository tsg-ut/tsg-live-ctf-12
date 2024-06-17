FROM node:20-alpine
WORKDIR /app
COPY dist/app/package-lock.json dist/app/package.json dist/app/server.js /app/
COPY dist/app/daikichi dist/app/kyo /app/
COPY dist/app/public/ /app/public
RUN echo "TSGLIVE{wh3re_1s_my_f1ag?_1s_b1ue_b1rd_1ns1de?}" > /flag

RUN adduser -D app-user && chown -R app-user /app
USER app-user

RUN npm install
EXPOSE 3000
CMD ["node", "server.js"]
