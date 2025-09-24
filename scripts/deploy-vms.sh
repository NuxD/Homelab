#!/bin/bash

set -e

echo "🚀 Deploying VMs with Terraform..."

# Change to terraform directory
cd terraform

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "❌ terraform.tfvars not found!"
    echo "Please copy terraform.tfvars.example to terraform.tfvars and configure your settings"
    exit 1
fi

# Initialize Terraform
echo "📦 Initializing Terraform..."
terraform init

# Plan deployment
echo "📋 Planning deployment..."
terraform plan

# Ask for confirmation
read -p "Do you want to apply this configuration? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔨 Applying configuration..."
    terraform apply -auto-approve
    
    echo "✅ VMs deployed successfully!"
    echo ""
    echo "📊 VM Information:"
    terraform output -json | jq -r '.vm_ips.value | to_entries[] | "\(.key): \(.value)"'
else
    echo "❌ Deployment cancelled"
    exit 1
fi
