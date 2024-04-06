locals {
  
  # Base resource-independent tags
  base_tags = {
    Project     = var.project_name
    Environment = var.project_env
    Managed_by  = "terraform"
  }

 
}
