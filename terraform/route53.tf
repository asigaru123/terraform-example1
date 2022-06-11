# APIドメイン作成
resource "aws_route53_zone" "api_domain" {
    name = "***"
}

# 証明書検証用のCネームレコード
resource "aws_route53_record" "api_domain" {
    for_each = {
        for dvo in aws_acm_certificate.api_cert.domain_validation_options: dvo.domain_name =>{
            name = dvo.resource_record_name
            record = dvo.resource_record_value
            type = dvo.resource_record_type
        }
    }
    allow_overwrite = true
    name = each.value.name
    records = [each.value.record]
    ttl = 60
    type = each.value.type
    zone_id = aws_route53_zone.api_domain.zone_id
}
