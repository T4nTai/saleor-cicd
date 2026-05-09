# Vault Secrets Structure

Tất cả secrets được lưu tại path: `secret/data/saleor/`

## Paths

### CI/CD
```
secret/data/saleor/ci
  sonar_token         # SonarQube authentication token
  registry_password   # GHCR / Docker registry password
```

### AWS
```
secret/data/saleor/aws
  access_key_id       # AWS_ACCESS_KEY_ID cho Terraform
  secret_access_key   # AWS_SECRET_ACCESS_KEY cho Terraform
  role_arn            # IAM Role ARN để deploy lên EKS
```

### Backend (Django)
```
secret/data/saleor/backend
  secret_key          # Django SECRET_KEY
  database_url        # PostgreSQL connection string
  redis_url           # Redis connection string
  email_url           # SMTP credentials
```

### Storefront
```
secret/data/saleor/storefront
  saleor_api_url      # NEXT_PUBLIC_SALEOR_API_URL
```

## Cách thêm secret

```bash
vault kv put secret/saleor/ci \
  sonar_token="<token>" \
  registry_password="<password>"
```

## Cách dùng trong GitHub Actions

```yaml
- uses: hashicorp/vault-action@v3
  with:
    url: ${{ secrets.VAULT_ADDR }}
    token: ${{ secrets.VAULT_TOKEN }}
    secrets: |
      secret/data/saleor/ci sonar_token | SONAR_TOKEN
```

## GitHub Secrets cần thiết (bootstrap)

Chỉ 2 secrets cần lưu trực tiếp trong GitHub:
- `VAULT_ADDR` — địa chỉ Vault server (vd: https://vault.example.com)
- `VAULT_TOKEN` — token CI với policy read-only
