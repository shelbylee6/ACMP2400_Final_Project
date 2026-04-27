# ACMP 2400 Final Project

This project was created through a containerized Python and Django web application. It is deploted to the cloud using Terraform (IaC), and an automated GitHub Actions CI/Cd pipeline. 

# Project Overview

This project demonstrates a DevOps workflow. A sample Django web application that is containerized, scanned for security vulnerabilies, and deployed to a could environment. This is triggered automatically through GitHub Actions.
This project used:
- Python and Django as application runtime
- Docker as containerization
- Terraform for infrastructure supply
- GitHub Actions as CI/CD automation
- Azure for deployment target.

# Project Board and User Stories

Project was planned and tracked using GitHub KanBan Project Board. Organizied into three milestones:
1. Project Setup and Containerization
2. CI/CD Automation
3. IaC and Cloud Deployment
Each task on the board is writted as a user story: "As a [role], I want [goal] so I can [reason]."

# Containerization 

The application is containerized using Docker following best security practices:
- SHA pinning: the base image is pinned to an exact digest, not a floating tag, to prevent supply-chain drift
- No hard coded secrets: all credentials are passed through environment variables
- Minimal RUN layers: dependencies installed in a single layer to keep image size small
- Official image: uses the offical Python image from Docker Hub

# Infrastructure as Code - Terraform

Cloud infrastructure is defined and managed using Terraform. 
Resources:
- Azure Container Instance
- Public IP address with port 8000 exposed
- Key Vault for secret management
Best practices applied:
- Remote state: Terraform state is stored in a remote backend (azure storage) with encryption as rest enabled
- No hard coded secrets: credentails are passed via environment variables or secrets managers. No sensitive values appear in .tf files
- Official providers: uses the verified official provider for target cloud platform
- Misconfiguration scanning; IaC is scanned for security misconfigurations as part of the pipeline
- Plan before apply: terraform plan output is reviewed in CI before terraform apply runs

# GitHub Actions CI/Cd Pipeline:

Pipeline stages:
1. Build: builds the docker image
2. Test: runs the application tests
3. Scan (image): custom action generates an SBOM and checks for vulnerabilities
4. Scan (secrets): scans for accidentially committed secrets
5. Scan (IaC): Terraform configs scanned for misconfigurations
6. Terraform Plan: plans infrastrcture changes
7. Terraform Apply: applies infrastrucutre changes (on approval/merge to main)
8. Push: pushes verified image to container registry
9. Deploy: deploys the container to the cloud environment 
10. Health Check: custom action verifies the app return to HTTP 200

The custom action defined in .github/actions/ that performs a health check curl against the deployed application endpoint, confirming it returns HTTP 200 before the pipeline is considered successful. 
Best Practices applied:
- All third party actions are SHA-pinned to verified commits
- Workflow permissions follow the Principle of Least Privilege - each job declares only the permissions it needs
- No secrets in workflow files - all credentials stored in key vault
- Triggers use push and pull request - no unauthenticated workflow dispatch
- Actions use verified/offical actions where possible

# Deployment 
The application is deployed to Azure and accessible at: http://your-public-domain:8000
To trigger a deployment, push to the main branch. The GitHub Actions pipeline will automatically build, scan, provision infrastructure, and deploy the updated application. 







