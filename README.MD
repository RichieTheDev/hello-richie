# DevOps Coding Challenge: CORS Proxy on AWS EKS

## 1. Cloud Provider Setup

### Chosen Cloud Provider: AWS

- **Account Setup:**
  - Sign up for an AWS account at [AWS Console](https://aws.amazon.com/).
  - Verify your email, add billing information, and set up IAM roles for secure access.

- **Configurations Applied:**
  - Created a new IAM user with `AdministratorAccess` to manage resources securely.
  - Configured AWS CLI with `aws configure` to set up your `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
  - Enabled billing alarms to monitor usage and avoid unexpected charges.

## 2. Kubernetes Cluster Setup

### Kubernetes Cluster: EKS

- **Cluster Configuration:**
  - Utilized AWS EKS (Elastic Kubernetes Service) to deploy a Kubernetes cluster.
  - Deployed the cluster using Terraform, ensuring high availability with managed node groups spread across multiple availability zones.
  - Configured `eks_managed_node_groups` in Terraform to set up a node group with auto-scaling capabilities.

- **High Availability Setup:**
  - Ensured that the cluster is highly available by spreading nodes across different subnets within different availability zones.
  - Used `min_size`, `max_size`, and `desired_size` settings in Terraform for node group configuration to ensure resilience and scalability.

## 3. Infrastructure as Code

### Using Terraform for Infrastructure Deployment

- **IaC Setup:**
  - Created a VPC with public and private subnets using Terraform.
  - Deployed EKS with Terraform, handling the cluster setup and node groups.

- **Steps to Deploy:**
  1. Initialize Terraform in your project directory using `terraform init`.
  2. Apply the Terraform configuration to create the resources with `terraform apply`.

- **Scripts:**
  - All Terraform scripts are located in the project repository:
    - `vpc.tf`: Configures the VPC and subnets.
    - `eks.tf`: Configures the EKS cluster and node groups.
    - `security_group.tf`: Configures security groups for the cluster.
    - `main.tf`: Root configuration to link modules and manage dependencies.

## 4. Application Deployment

### CORS Proxy Service

- **Deployment on Kubernetes:**
  - Created a Kubernetes deployment for a CORS proxy using the `robinsthedev/cors-anywhere` image.
  - Configured a Kubernetes service of type `LoadBalancer` to expose the CORS proxy externally.

- **Steps to Deploy:**
  1. Apply the deployment and service manifests using `kubectl apply -f deployment.yaml` and `kubectl apply -f service.yaml`.
  2. Ensure the service is accessible via the external load balancer IP.

## 5. Scalability

### Auto-Scaling Configuration

- **Horizontal Pod Autoscaler (HPA):**
  - Configured HPA for the CORS proxy to scale based on CPU utilization.
  - Set minimum and maximum replicas to handle varying loads, scaling from 1 to 10 replicas based on demand.

- **Handling 1000 Requests Per Second:**
  - The configuration allows for automatic scaling up to 10 replicas, with each replica handling a portion of the load.
  - The infrastructure should handle up to 1000 requests per second, depending on the actual request size and processing time.

## 6. Load Testing

### k6 Load Testing

- **Load Testing Setup:**
  - Used `k6` to simulate load on the CORS proxy service.
  - The test script progressively increases the number of users to simulate load and validate the scaling setup.

- **Results:**
  - Achieved the target of 1000 requests per second without significant latency increase.
  - Observed the HPA scaling the number of pods as load increased.

- **Steps to Perform Load Testing:**
  1. Install `k6` on your local machine.
  2. Run the test script using `k6 run load_test.js`.
  3. Monitor the Kubernetes pods and HPA activity during the test.

## 7. Documentation and Deliverables

### Instructions for Deploying the Kubernetes Cluster Using IaC Tool:

- **Deployment Steps:**
  1. Clone the repository to your local machine.
  2. Configure AWS CLI and ensure credentials are set up.
  3. Run `terraform init` to initialize Terraform.
  4. Apply the Terraform configurations with `terraform apply`.
  5. Deploy the Kubernetes manifests using `kubectl apply -f <manifest-file>`.

### Steps to Deploy and Scale the Service on Kubernetes:

- **Deploy the CORS Proxy Service:**
  - Use `kubectl` to deploy the provided Kubernetes manifests for the CORS proxy service.

- **Enable Auto-Scaling:**
  - Apply the HPA configuration with `kubectl apply -f hpa.yaml`.

### Load Testing Methodology and Results:

- **Testing Methodology:**
  - Load tested using a step-wise approach with k6.
  - Simulated traffic up to 1000 requests per second to ensure the application and infrastructure scale accordingly.

- **Results:**
  - The infrastructure scaled appropriately under load, maintaining performance within acceptable thresholds.

### Limitations of the Setup:

- **Current Limitations:**
  - The setup handles up to 1000 requests per second, but beyond this, performance may degrade unless further optimizations are made.
  - AWS costs could increase significantly with higher loads due to scaling.

### Steps to Scale Further:

- **Scaling Beyond 1000 Requests Per Second:**
  - Increase the node group size in EKS to handle more pods.
  - Implement a CDN or caching layer to reduce load on the CORS proxy.
  - Optimize the CORS proxy codebase for better performance.
  - Use a more powerful instance type in EKS node groups to handle more requests per second.

## Source Code and Configuration Files

### Repository Structure:

- All source code, Terraform scripts, Kubernetes manifests, and load testing scripts are included in the project repository.
