FROM ubuntu:22.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV GRAFANA_VERSION=12.0.1
ENV GF_PLUGINS_ANALYZER_SERVER=http://127.0.0.1:8086

# 安装基础依赖（移除mysql-server和docker相关）
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    supervisor \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 下载并安装Grafana
RUN wget https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz \
    && tar -zxvf grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz \
    && mv grafana-v${GRAFANA_VERSION} /opt/grafana \
    && rm grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz

# 创建Grafana插件目录
RUN mkdir -p /opt/grafana/data/plugins

# 下载Grafana插件
RUN wget https://github.com/skyline-intelligence/intelligent-log-analyzer/releases/download/v1.0.0/skylineintelligence-errorloganalyzer-app.zip \
    && unzip skylineintelligence-errorloganalyzer-app.zip \
    && mv skylineintelligence-errorloganalyzer-app /opt/grafana/data/plugins/ \
    && rm skylineintelligence-errorloganalyzer-app.zip

# 复制配置文件
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY startup.sh /app/startup.sh

# 设置脚本权限
RUN chmod +x /app/startup.sh

# 暴露端口
EXPOSE 3000 80 3306

# 启动命令
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]