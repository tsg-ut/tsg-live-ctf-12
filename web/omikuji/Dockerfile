FROM node:20-alpine
WORKDIR /app
COPY dist/app/package-lock.json dist/app/package.json dist/app/server.js /app/
COPY dist/app/daikichi dist/app/kyo /app/
COPY dist/app/public/ /app/public
RUN echo "TSGLIVE{1_knew_at_f1rst_g1ance_that_1t_was_so_0rdin4ry_path_traversal}" > /flag

RUN adduser -D app-user && chown -R app-user /app
USER app-user

RUN npm install
EXPOSE 3000
CMD ["node", "server.js"]
