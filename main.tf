resource "aws_security_group" "worker_security_group" {
  name_prefix = "worker_security_group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/16",
    ]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.25.0"

  name                 = "this"
  cidr                 = var.network_address
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Name = format("%s-vpc", var.stage)
  }

  public_subnet_tags = {
    Name = format("%s-public-subnet", var.stage)
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    Name = format("%s-private-subnet", var.stage)
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

module "eks" {
  source           = "terraform-aws-modules/eks/aws"
  cluster_name     = local.cluster_name
  subnets      	   = module.vpc.private_subnets

  tags = {
    Name        = format("%s-eks", var.stage)
    Environment = var.stage
  }

  vpc_id = module.vpc.vpc_id

  node_groups = {
    default = {
      desired_capacity  = var.desired_nodes
      max_capacity      = var.max_nodes
      min_capacity      = var.min_nodes
      instance_type     = var.instance_type
      subnets           = module.vpc.private_subnets
      role_arn          = aws_iam_role.this.arn

      additional_tags = {
        Name = format("%s-eks-node", "${var.stage}")
      }

      k8s_labels = {
        Name = format("%s-eks-node", "${var.stage}")
      }
    }
  }
}