# final-project
infra/
└── terraform/
    ├── env/
    │   ├── prod/
    │       ├── main.tf
    │       ├── providers.tf
    │       ├── variables.tf
    │       ├── terraform.tfvars
    │       └── outputs.tf
    │
    └── modules/
        ├── iam/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        |
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
        ├── postgres/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        │
        ├── secrets/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        |
        └── storage/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf
