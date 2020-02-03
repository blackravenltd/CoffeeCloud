module.exports =
  Name: "Public Network"
  Stack: 'dmz'
  CloudFormation: (env, h) ->

    template =
      # Single Public Route Table
      PublicRouteTable:
        Type: "AWS::EC2::RouteTable"
        Properties:
          VpcId: Ref: h.ref("VPC")
          Tags: [ { Key: "Name", Value: env.ProjectName+env.Name+"-public-route-table" } ]

      # Internal Route
      PublicRoute:
        Type: "AWS::EC2::Route"
        Properties:
          RouteTableId:         Ref: h.ref("PublicRouteTable")
          DestinationCidrBlock: env.PublicCIDR
          GatewayId:            Ref: h.ref("InternetGateway")

    for cidr, i in env.PublicTierCIDR
      # Subnets
      template["PublicSubnet"+i] =
        Type: "AWS::EC2::Subnet"
        Properties:
          VpcId:                Ref: h.ref("VPC")
          AvailabilityZone:     env.AvailibilityZones[i]
          CidrBlock:            env.PublicTierCIDR[i]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: "Name", Value: env.ProjectName+env.Name+"-public-subnet-"+i} ]

      # Subnet ACL Associations
      template["PublicSubnetNACLAssociation"+i] =
        Type: "AWS::EC2::SubnetNetworkAclAssociation"
        Properties:
          SubnetId:     Ref: h.ref("PublicSubnet"+i)
          NetworkAclId: Ref: h.ref("NACL")


      # Subnet Route Table Associations
      template["PublicSubnetRouteTableAssociation"+i] =
        Type: "AWS::EC2::SubnetRouteTableAssociation"
        Properties:
          SubnetId:     Ref: h.ref("PublicSubnet"+i)
          RouteTableId: Ref: h.ref("PublicRouteTable")

    return { Resources: template }
