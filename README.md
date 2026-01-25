# final-project
infra/
└── terraform/
    ├── env/
    │   ├── dev/
    │   │   ├── main.tf
    │   │   ├── providers.tf
    │   │   ├── variables.tf
    │   │   ├── terraform.tfvars
    │   │   └── outputs.tf
    │   └── prod/
    │       ├── main.tf
    │       ├── providers.tf
    │       ├── variables.tf
    │       ├── terraform.tfvars
    │       └── outputs.tf
    │
    └── modules/
        ├── network/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        │
        ├── gke/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        │
        ├── cloud_sql/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        │
        └── storage/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf
