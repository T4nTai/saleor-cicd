# Policy cho CI/CD pipeline
# Chỉ read, không write

path "secret/data/saleor/*" {
  capabilities = ["read"]
}

path "secret/metadata/saleor/*" {
  capabilities = ["list", "read"]
}

# Deny write/delete từ CI
path "secret/data/saleor/*" {
  denied_parameters = {
    "*" = []
  }
  capabilities = ["read"]
}
