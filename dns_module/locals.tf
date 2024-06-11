locals {
  target_resource_group = format("%s-rg-%s-%s", var.project_name, var.location, var.cohort)

  tags = tomap({
      "cohort"        = var.cohort
      "project"       = var.project_name
      "owner"         = var.owner
  })
}
