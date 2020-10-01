resource "aws_key_pair" "katharina" {
  key_name   = "katharinas_key"
  public_key = var.public_key
}
