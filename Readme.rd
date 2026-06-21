# ☁️ AWS Highly Available Resume Website

A highly available and fault-tolerant resume website deployed on AWS to demonstrate cloud architecture best practices, including auto scaling, load balancing, multi-AZ deployments, monitoring, and automated recovery.

This project showcases how modern cloud-native infrastructure can ensure continuous availability, scalability, and resilience while following security and operational best practices.

---

## 📖 Overview

Traditional single-server websites are vulnerable to outages caused by hardware failures, traffic spikes, or infrastructure issues.

This project addresses those challenges by implementing a highly available architecture on AWS using:

- Multiple Availability Zones
- Application Load Balancer
- Auto Scaling Group
- Health checks and self-healing
- CloudWatch monitoring
- Secure networking with VPC

The website remains accessible even if an EC2 instance or an entire Availability Zone becomes unavailable.

---

## 🏗️ Architecture

```
Users
  │
  ▼
Route 53
  │
  ▼
Application Load Balancer
  │
  ▼
Auto Scaling Group
 ┌─────────────┬─────────────┐
 ▼             ▼             ▼
EC2 Instance  EC2 Instance  EC2 Instance
(AZ-1)        (AZ-2)        (AZ-3)
  │             │             │
  └─────────────┴─────────────┘
                │
                ▼
        CloudWatch Monitoring
```

### Architecture Flow

1. Users access the website using a custom domain configured in Route 53.
2. Route 53 directs traffic to the Application Load Balancer.
3. The Application Load Balancer distributes requests across healthy EC2 instances.
4. EC2 instances are managed by an Auto Scaling Group.
5. CloudWatch continuously monitors the infrastructure.
6. Unhealthy instances are automatically replaced.

---

## 🚀 Key Features

- High availability across multiple Availability Zones
- Fault-tolerant architecture with automatic recovery
- Application Load Balancer for traffic distribution
- Auto Scaling based on demand
- Health checks for instance monitoring
- Automatic replacement of unhealthy instances
- HTTPS support using SSL/TLS certificates
- CloudWatch dashboards, metrics, and alerts
- Secure network design using VPC and Security Groups
- No single point of failure

---

## 🛠️ AWS Services Used

| Service | Purpose |
|---------|---------|
| Amazon EC2 | Hosts the resume website |
| Auto Scaling Group | Automatically scales and replaces instances |
| Application Load Balancer | Distributes incoming traffic |
| Amazon VPC | Provides network isolation |
| AWS IAM | Identity and access management |
| Security Groups | Controls network access |


```

---

## ⚙️ Deployment Steps

### 1. Create a Custom VPC

- Create a VPC.
- Create public subnets across at least two Availability Zones.
- Attach an Internet Gateway.
- Configure route tables.

### 2. Configure Security Groups

Allow the following inbound traffic:

| Port | Protocol | Purpose |
|------|----------|---------|
| 80 | HTTP | Web traffic |
| 443 | HTTPS | Secure web traffic |
| 22 | SSH | Administrative access |

> Restrict SSH access to trusted IP addresses only.

### 3. Launch an EC2 Instance

Create an EC2 instance and install the web server.


### 4. Create a Launch Template

Configure the following:

- Amazon Machine Image (AMI)
- Instance type
- Security groups
- IAM role
- User data script

### 5. Configure an Auto Scaling Group

- Attach the launch template.
- Select multiple Availability Zones.
- Configure minimum, desired, and maximum capacity.

Example configuration:

| Setting | Value |
|---------|-------|
| Minimum Capacity | 2 |
| Desired Capacity | 2 |
| Maximum Capacity | 5 |

### 6. Create an Application Load Balancer

- Create a target group.
- Register the Auto Scaling Group.
- Configure health checks.

Example health check:

```
Path: /
Protocol: HTTP
Healthy threshold: 2
Unhealthy threshold: 2
```

## 📈 Auto Scaling Policy

### Scale Out

- Trigger when CPU utilization exceeds 70%
- Add one instance

### Scale In

- Trigger when CPU utilization falls below 30%
- Remove one instance

This approach ensures optimal performance while controlling infrastructure costs.

---

## 🧪 Fault Tolerance Testing

The following scenarios were tested:

- Manual termination of EC2 instances
- Simulated instance failures
- High traffic load testing
- Availability Zone failure scenarios

### Results

- Failed instances were automatically replaced.
- Traffic was redirected to healthy instances.
- No manual intervention was required.
- The website remained available during failures.

---

## 🔒 Security Best Practices

- Follow the principle of least privilege using IAM roles
- Restrict inbound traffic using Security Groups
- Enable HTTPS with SSL/TLS certificates
- Avoid hardcoding secrets or credentials
- Keep AMIs updated and patched
- Restrict SSH access to trusted IP addresses
- Enable access logging and monitoring

---

## 📊 Monitoring and Observability

Amazon CloudWatch is used to monitor:

- CPU utilization
- Network traffic
- Application health
- Auto Scaling events
- Load balancer metrics

CloudWatch alarms notify administrators when thresholds are exceeded.

---

## 🔄 Future Enhancements

- Provision infrastructure using Terraform
- Implement CI/CD using GitHub Actions
- Containerize the application with Docker
- Deploy containers using Amazon ECS or Amazon EKS
- Add CloudFront for global content delivery
- Integrate AWS WAF for additional security
- Implement Blue/Green deployments
- Add centralized logging with OpenSearch

---

## 🎯 Learning Outcomes

Through this project, I gained hands-on experience with:

- Designing highly available cloud architectures
- Building fault-tolerant systems
- Configuring Auto Scaling Groups
- Implementing load balancing
- Monitoring cloud infrastructure
- Applying AWS security best practices
- Optimizing performance and cost






