FROM node:22-alpine

# ആവശ്യമായ ടൂളുകൾ ഇൻസ്റ്റാൾ ചെയ്യുന്നു
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

# Environment Variables
ENV TZ=Asia/Kolkata
ENV PORT=8080

# പോർട്ട് എക്സ്പോസ് ചെയ്യുന്നു (Back4App-ന് ഇത് നിർബന്ധമാണ്)
EXPOSE 8080

RUN npm install -g --force yarn pm2
RUN yarn install

# ബോട്ട് റൺ ചെയ്യുന്നു
CMD ["npm", "start"]
