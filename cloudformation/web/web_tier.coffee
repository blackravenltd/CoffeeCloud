module.exports =
  Name: "Web Tier"
  Stack: 'web'
  CloudFormation: (env,h) ->
    Resources:
      # Route Table & Route

      WebRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: h.ref('VPC')
          Tags: [ { Key: 'Name', Value: 'NACL'} ]

      WebRoute:
        Type: 'AWS::EC2::Route'
        Properties:
          RouteTableId:         Ref: h.ref('WebRouteTable')
          DestinationCidrBlock: '0.0.0.0/0'
          GatewayId:            Ref: h.ref('InternetGateway')

      # Subnets
      WebSubnetA:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailibilityZones[0]
          CidrBlock:            env.WebTierCIDR[0]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Web Subnet A'} ]

      WebSubnetB:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailibilityZones[1]
          CidrBlock:            env.WebTierCIDR[1]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Web Subnet B'} ]

      # Subnet ACL Associations
      WebSubnetANetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('WebSubnetA')
          NetworkAclId: Ref: h.ref('NACL')

      WebSubnetBNetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('WebSubnetB')
          NetworkAclId: Ref: h.ref('NACL')

      # Subnet Route Table Associations

      WebSubnetARouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('WebSubnetA')
          RouteTableId: Ref: h.ref('WebRouteTable')

      WebSubnetBRouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('WebSubnetB')
          RouteTableId: Ref: h.ref('WebRouteTable')

