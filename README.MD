# Kubernetes Cluster and Service Deployment

This document outlines the process of deploying a Kubernetes cluster using Infrastructure as Code (IaC), setting up a service, performing load testing, and discussing scalability.

## Table of Contents

1. [Setup and Configuration](#setup-and-configuration)
2. [Deploying the Kubernetes Cluster](#deploying-the-kubernetes-cluster)
3. [Deploying and Scaling the Service](#deploying-and-scaling-the-service)
4. [Load Testing](#load-testing)
5. [Limitations](#limitations)
6. [Scalability Considerations](#scalability-considerations)
7. [Source Code and Configuration Files](#source-code-and-configuration-files)

## Setup and Configuration

### AWS Account Setup

1. **Create an AWS Account:** If you don’t have an AWS account, sign up at [aws.amazon.com](https://aws.amazon.com/).
2. **Configure IAM Role:**
### Install AWS CLI 

As the first step, you need to install AWS CLI as we will use the AWS CLI (`aws configure`) command to connect Terraform with AWS in the next steps.

Follow the below link to Install AWS CLI.
```
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
```

3. **Terraform Installation:**
   - Install Terraform by following the instructions [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).


### Infrastructure as Code Configuration

The project is structured to use Terraform for provisioning AWS resources, including a VPC, subnets, security groups, and an EKS cluster. The main Terraform configuration files are located in the root of the directory

- **`variables.tf`**: Contains all the input variables used in the Terraform configuration.
- **`main.tf`**: Main Terraform configuration file to set up the AWS provider and modules for VPC, EKS, and security groups.
- **`outputs.tf`**: Defines the output variables for the Terraform configuration, such as VPC ID and EKS cluster endpoint.

## Deploying the Kubernetes Cluster

### Prerequisites

- Ensure AWS credentials are configured on your local machine (e.g., via `aws configure` or environment variables).
- Terraform installed on your local machine.

### Deployment Steps
## Instructions to Build and Run

### Clone the Repository
   ```bash
   git clone https://github.com/RichieTheDev/hello-richie.git
   cd hello-richie
   ```
1. **Initialize Terraform:**

   - Navigate to the `terraform` directory:
     ```bash
     cd terraform
     ```
   - Run Terraform initialization:
     ```bash
     terraform init
     ```

2. **Apply Terraform Configuration:**

   - Review the plan and apply the Terraform configuration:
     ```bash
     terraform apply
     ```
   - This will provision the VPC, subnets, security groups, and EKS cluster as defined in the `main.tf` file.

3. **Output Values:**
   - After the deployment is successful, Terraform will output key values like the VPC ID, EKS cluster ID, and endpoint.

## Deploying and Scaling the Service

### Deploy the CORS Proxy Service

1. **Deployment Configuration:**

   - A Kubernetes deployment configuration (`Deployment`) is provided in the YAML format.
   - The deployment uses a Docker image (`robinsthedev/cors-anywhere:latest`) to run the CORS proxy service.

2. **Install kubectl:**

   - Install `kubectl` by following the instructions [here](https://kubernetes.io/docs/tasks/tools/).

3. **Apply Deployment:**

   - Use `kubectl` to apply the deployment:
     ```bash
     kubectl apply -f k8/deployment.yaml
     ```
   - The deployment configuration will create a pod with the specified resource requests and limits.

4. **Expose the Service:**

   - Apply the Service configuration to expose the CORS proxy via a LoadBalancer:
     ```bash
     kubectl apply -f k8/service.yaml
     ```

5. **Horizontal Pod Autoscaler (HPA):**

   - The HPA configuration is also provided to scale the service based on CPU utilization.
   - Apply the HPA:
     ```bash
     kubectl apply -f k8/hpa.yaml
     ```

6. **Check the Status**

```bash
kubectl get deployments
kubectl get services
kubectl get hpa
```

7. **Access the CORS Proxy**

- LoadBalancer service type might take a few minutes for the external IP to be assigned. You can check the status by running:

```bash
kubectl get services
```

8. **Monitor and Debug**

```bash
kubectl logs deployment/cors-proxy
kubectl describe deployment cors-proxy
```

9. **Test and Validate**

- Test the CORS proxy to ensure it's working as expected. You can send requests to the external IP or domain of your service.

```bash
curl http://<external-ip-or-domain>/your-endpoint
```

## Load Testing

### Load Testing with k6

1. **Install k6:**

   - Install `k6` by following the instructions [here](https://k6.io/docs/getting-started/installation/).

2. **Run Load Test:**

   - A sample `k6` script is provided to test the CORS proxy service under various loads:
     ```bash
     k6 run load-testing/load-test-script.js
     ```
   - The script simulates gradual traffic increase and measures response times.

3. **Analyze Results:**
   - The script includes thresholds for acceptable performance (e.g., 95% of requests completing in under 500ms).

## Limitations

- **Scalability:** The default setup is designed for moderate loads and may not handle extreme traffic (e.g., 10k or 100k requests per second) without further optimization.
- **AWS Costs:** The setup includes resources like Load Balancers and EKS, which can incur significant costs, especially at higher scales.

## Scalability Considerations

To scale the setup further, consider the following steps:

1. **Optimize Kubernetes Resources:**

   - Increase the number of nodes in the EKS cluster.
   - Use larger instance types for the nodes to handle more requests.

2. **Increase HPA Limits:**

   - Adjust the HPA configuration to allow more replicas based on the load.

3. **Use Auto Scaling Groups:**

   - Implement auto-scaling groups for the EC2 instances backing the EKS cluster.

4. **Distributed Load Testing:**

   - Perform distributed load testing across multiple regions to simulate higher traffic.

5. **API Gateway and Caching:**
   - Use AWS API Gateway for better management of incoming requests.
   - Implement caching mechanisms like AWS CloudFront to reduce the load on the backend.

## Source Code and Configuration Files

All the source code and configuration files used in this challenge are organized as follows:

- **Terraform Files:** Located in `terraform module.
- **Kubernetes Deployment,service and HPA:** YAML files provided for the CORS proxy service deployment and scaling.
- **Load Testing Script:** `k6` script for simulating various loads on the service.

---

This documentation provides a comprehensive overview of the setup, deployment, and scalability considerations for your Kubernetes cluster and service. Use it as a reference to manage and scale your infrastructure effectively.

```

```
