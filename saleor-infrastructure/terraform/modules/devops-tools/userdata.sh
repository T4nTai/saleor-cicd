#!/bin/bash
set -e

sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
echo "fs.file-max=65536"      >> /etc/sysctl.conf


apt-get update -y
apt-get install -y docker.io docker-compose-plugin curl jq unzip
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

mkdir -p /opt/devops-tools/vault/config
mkdir -p /opt/devops-tools/vault/data

cat > /opt/devops-tools/vault/config/vault.hcl << 'EOF'
ui = true

storage "file" {
  path = "/vault/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true
}

api_addr = "http://0.0.0.0:8200"
EOF
cat > /opt/devops-tools/docker-compose.yml << 'EOF'
services:
  sonarqube:
    image: sonarqube:community
    container_name: sonarqube
    restart: unless-stopped
    ports:
      - "9000:9000"
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://sonar-db:5432/sonar
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: sonar
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_logs:/opt/sonarqube/logs
      - sonarqube_extensions:/opt/sonarqube/extensions
    ulimits:
      nofile:
        soft: 65536
        hard: 65536
    depends_on:
      sonar-db:
        condition: service_healthy

  sonar-db:
    image: postgres:15-alpine
    container_name: sonar-db
    restart: unless-stopped
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonar
      POSTGRES_DB: sonar
    volumes:
      - sonar_db_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U sonar"]
      interval: 10s
      timeout: 5s
      retries: 5

  vault:
    image: hashicorp/vault:latest
    container_name: vault
    restart: unless-stopped
    ports:
      - "8200:8200"
    environment:
      VAULT_ADDR: http://0.0.0.0:8200
    cap_add:
      - IPC_LOCK
    volumes:
      - /opt/devops-tools/vault/config:/vault/config:ro
      - /opt/devops-tools/vault/data:/vault/data
    command: server -config=/vault/config/vault.hcl

volumes:
  sonarqube_data:
  sonarqube_logs:
  sonarqube_extensions:
  sonar_db_data:
EOF

# ── Khởi động services ────────────────────────────────────────────────────────
cd /opt/devops-tools
docker compose up -d

# ── Log IP để dễ lấy sau ─────────────────────────────────────────────────────
echo "=== DevOps Tools Ready ===" >> /var/log/devops-tools-init.log
echo "SonarQube: http://$(curl -s ifconfig.me):9000" >> /var/log/devops-tools-init.log
echo "Vault:     http://$(curl -s ifconfig.me):8200"  >> /var/log/devops-tools-init.log
