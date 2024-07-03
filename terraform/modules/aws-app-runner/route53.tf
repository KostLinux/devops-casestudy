resource "aws_route53_record" "validation_records_app_runner" {
  count = 2

  name    = local.validation_records_list[count.index].name
  type    = local.validation_records_list[count.index].type
  records = [local.validation_records_list[count.index].value]
  ttl     = 30
  zone_id = data.aws_route53_zone.existing_route53_zone.zone_id
  depends_on = [
    module.app_runner
  ]
}

resource "aws_route53_record" "app_runner" {
  zone_id = data.aws_route53_zone.existing_route53_zone.zone_id
  name    = "${var.application_name}.${data.aws_route53_zone.existing_route53_zone.name}"
  type    = "CNAME"
  ttl     = 30
  records = [module.app_runner.custom_domain_association_dns_target]
  
  depends_on = [
    module.app_runner
  ]
}