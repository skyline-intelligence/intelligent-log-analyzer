FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV GRAFANA_VERSION=12.0.1
ENV GF_PLUGINS_ANALYZER_SERVER=http://127.0.0.1:8086

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    supervisor \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN wget https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz \
    && tar -zxvf grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz \
    && mv grafana-v${GRAFANA_VERSION} /opt/grafana \
    && rm grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz

RUN mkdir -p /opt/grafana/data/plugins

RUN wget https://github.com/skyline-intelligence/intelligent-log-analyzer/releases/download/v1.0.0/skylineintelligence-errorloganalyzer-app.zip \
    && unzip skylineintelligence-errorloganalyzer-app.zip \
    && mv skylineintelligence-errorloganalyzer-app /opt/grafana/data/plugins/ \
    && rm skylineintelligence-errorloganalyzer-app.zip

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY startup.sh /app/startup.sh

RUN chmod +x /app/startup.sh

EXPOSE 3000 80 3306

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]