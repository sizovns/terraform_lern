Dir structure:

├── modules
│   ├── aws_network
│   ├── aws_security_group
│   └── aws_something
└── projectA
    ├── dev
    │   ├── kms
    │   ├── network
    │   ├── route53
    │   ├── s3
    │   └── vpc
    │       ├── applications
    │       │   ├── app1
    │       │   └── app2
    │       ├── databases
    │       ├── ecs_cluster
    │       └── vpn
    ├── prod
    │   ├── kms
    │   ├── network
    │   ├── route53
    │   ├── s3
    │   └── vpc
    │       ├── applications
    │       │   ├── app1
    │       │   └── app2
    │       ├── databases
    │       ├── ecs_cluster
    │       └── vpn
    └── staging
        ├── kms
        ├── network
        ├── route53
        ├── s3
        └── vpc
            ├── applications
            │   ├── app1
            │   └── app2
            ├── databases
            ├── ecs_cluster
            └── vpn
