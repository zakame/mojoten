FROM perl:5.36-slim-buster

WORKDIR /app

COPY cpanfile* .
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc libssl-dev \
    && cpm install -g Carton \
    && cpm install

COPY . .

EXPOSE 3000

CMD ["perl", "-I", "local/lib/perl5", "script/mojoten", "daemon"]
