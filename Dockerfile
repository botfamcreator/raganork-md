FROM node:22-alpine

RUN apk add --no-cache \
    git \
    ffmpeg \
    libwebp-tools \
    python3 \
    make \
    g++

# Repo ക്ലോൺ ചെയ്യുന്നു
ADD https://api.github.com/repos/souravkl11/raganork-md/git/refs/heads/main version.json
RUN git clone -b main https://github.com/souravkl11/raganork-md /rgnk

WORKDIR /rgnk
RUN mkdir -p temp

ENV TZ=Asia/Kolkata
ENV PORT=8080
EXPOSE 8080

RUN npm install -g --force yarn pm2
RUN yarn install

# കോഡ് എഡിറ്റ് ചെയ്യാതെ തന്നെ ഒരു വെബ് സെർവർ ബാക്ക്ഗ്രൗണ്ടിൽ റൺ ചെയ്യാനുള്ള കമാൻഡ്
CMD node -e "const http = require('http'); http.createServer((req, res) => { res.writeHead(200); res.end('Alive'); }).listen(process.env.PORT || 8080);" & npm start
