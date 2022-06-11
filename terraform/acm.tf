# APIドメイン用の証明書
resource "aws_acm_certificate" "api_cert" {
    domain_name = "***"
    validation_method = "DNS"
}

# 証明書のDNS検証
resource "aws_acm_certificate_validation" "api_cert" {
    certificate_arn = aws_acm_certificate.api_cert.arn
    validation_record_fqdns = [for record in aws_route53_record.api_domain : record.fqdn]
}