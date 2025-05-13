# Create Peering Connection
resource "aws_vpc_peering_connection" "demo_to_solv" {
  vpc_id        = var.demo_vpc_id
  peer_vpc_id   = var.solv_vpc_id
  auto_accept   = true

  tags = {
    Name = "demo-to-solv-peering"
  }
}

# ROUTES FOR demo-vpc TO solv-india
resource "aws_route" "demo_public_to_solv" {
  route_table_id            = var.demo_public_rt_id
  destination_cidr_block    = var.solv_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.demo_to_solv.id
}

resource "aws_route" "demo_private_to_solv" {
  route_table_id            = var.demo_private_rt_id
  destination_cidr_block    = var.solv_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.demo_to_solv.id
}

# ROUTES FOR solv-india TO demo-vpc
resource "aws_route" "solv_public_to_demo" {
  route_table_id            = var.solv_public_rt_id
  destination_cidr_block    = var.demo_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.demo_to_solv.id
}

resource "aws_route" "solv_private_to_demo" {
  route_table_id            = var.solv_private_rt_id
  destination_cidr_block    = var.demo_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.demo_to_solv.id
}
