
resource "aws_vpc" "conc_vpc" {
  cidr_block = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}
resource "aws_subnet" "conc_subnet" {
  vpc_id            = aws_vpc.conc_vpc.id
  cidr_block        = var.cidr_subnet

  tags = {
    Name = "${var.prefix}-subnet"
  }
}

# resource "aws_eip" "elb" {
#   instance = aws_elb.web-elb.name
#   vpc      = true
# }

# resource "aws_network_interface" "internet" {
#   subnet_id   = aws_subnet.conc_subnet.id
#   private_ips = ["10.10.10.99"]

#   tags = {
#     Name = "${var.prefix}-primary_network_interface"
#   }
# }

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.conc_vpc.id

  tags = {
    Name = "${var.prefix}-internet_gateway"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.conc_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.conc_subnet.id
  route_table_id = aws_route_table.rtb_public.id
}


# network interface??
# nat gateway?