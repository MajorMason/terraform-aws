# Terraform AWS ECS (PaaS) Infrastructure

This repository contains Terraform code for deploying a containerized application stack on AWS. The architecture consists of two public-facing frontend ECS services that communicate with a single backend ECS service.
The backend service connects to a PostgreSQL RDS instance, both of which are deployed in private subnets for security.

## Architecture Overview

### Components

- **Frontend ECS Services (2x)**
  - Deployed in public subnets
  - Accessible to end users
  - Communicate directly with the backend API service

- **Backend ECS Service**
  - Deployed in private subnets
  - Not publicly accessible
  - Handles all API and business logic
  - Communicates with the PostgreSQL database

- **PostgreSQL RDS Instance**
  - Deployed in private subnets
  - Only accessible from the backend ECS service
  - Configurable instance class, storage, and engine version

- **Networking**
  - VPC with public and private subnets across multiple AZs
  - Security groups enforcing least‑privilege communication
  - Optional Application Load Balancer for frontend services

### High-Level Architecture

[ Users ]
|
v
[ Frontend ECS Services ]  <-- Public Subnets
|
v
[ Backend ECS Service ]    <-- Private Subnets
|
v
[ PostgreSQL RDS ]


## Features

- Infrastructure-as-code using Terraform
- Leverages Atmos for variable simplification + deployment
- Multi-service ECS deployment (frontend ×2, backend ×1)
- Secure private networking for backend and database layers
- Parameterized modules for reusability
- Optional autoscaling and load balancing
