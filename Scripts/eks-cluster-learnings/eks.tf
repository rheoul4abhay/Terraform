module "eks" {

  # import the eks module template
  source             = "terraform-aws-modules/eks/aws"
  version            = "~> 21.0"
  kubernetes_version = "1.33"

  # cluster info (control plane)
  name                   = local.name
  endpoint_public_access = true
  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnets

  addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = { most_recent = true }
  }

  # control plane network
  control_plane_subnet_ids = module.vpc.intra_subnets

  # managing nodes in the cluster
  eks_managed_node_groups = {
    my-cluster-ng = {
      instance_types                        = ["t3.medium"]
      min_size                              = 1
      max_size                              = 3
      desired_size                          = 2
      capacity_type                         = "ON_DEMAND"
      attach_cluster_primary_security_group = true
      iam_role_arn   = aws_iam_role.eks_node_role.arn
    }
  }
}