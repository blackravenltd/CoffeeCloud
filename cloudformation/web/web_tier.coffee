module.exports =
  Name: "Web Tier"
  CloudFormation: (params) ->
    Resources:
      # Route Table & Route

      TestWebRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: 'TestVPC'
          Tags: [ { Key: 'Name', Value: 'TestNACL' } ]

      TestWebRoute:
        Type: 'AWS::EC2::Route'
        Properties:
          RouteTableId:         Ref: 'TestWebRouteTable'
          DestinationCidrBlock: '0.0.0.0/0'
          GatewayId:            Ref: 'TestInternetGateway'

      # Subnets

      TestWebSubnetA:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: 'TestVPC'
          AvailabilityZone:     params.AvailibilityZones[0]
          CidrBlock:            params.WebTierCIDR[0]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Test Web Subnet A'} ]

      TestWebSubnetB:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: 'TestVPC'
          AvailabilityZone:     params.AvailibilityZones[1]
          CidrBlock:            params.WebTierCIDR[1]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Test Web Subnet B' } ]

      # Subnet ACL Associations

      TestWebSubnetANetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: 'TestWebSubnetA'
          NetworkAclId: Ref: 'TestNACL'

      TestWebSubnetBNetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: 'TestWebSubnetB'
          NetworkAclId: Ref: 'TestNACL'

      # Subnet Route Table Associations

      TestWebSubnetARouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: 'TestWebSubnetA'
          RouteTableId: Ref: 'TestWebRouteTable'

      TestWebSubnetBRouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: 'TestWebSubnetB'
          RouteTableId: Ref: 'TestWebRouteTable'

