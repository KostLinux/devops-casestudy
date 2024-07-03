locals {
  validation_records_list = tolist(module.app_runner.custom_domain_association_certificate_validation_records)
}