output "xwiki_public_ip" {
  description = "The XWiki instance public ip"
  value       = "${module.xwiki_service.xwiki_public_ip}"
}
