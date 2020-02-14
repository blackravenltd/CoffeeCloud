module.exports =
  Name: "Services Tier"
  CloudFormation: (env,h) ->
    Resources:
      # Route Table & Route

      ServicesRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: h.ref('VPC')
          Tags: [ { Key: 'Name', Value: 'NACL'} ]

      # Subnets
      
      ServicesSubnetA:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailibilityZones[0]
          CidrBlock:            env.ServicesTierCIDR[0]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Services A'} ]

      ServicesSubnetB:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId: Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailibilityZones[1]
          CidrBlock:            env.ServicesTierCIDR[1]
          MapPublicIpOnLaunch: false
          Tags: [ { Key: 'Name', Value: 'Services B'} ]

      # Subnet ACL Associations

      ServicesSubnetANetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('ServicesSubnetA')
          NetworkAclId: Ref: h.ref('NACL')

      ServicesSubnetBNetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('ServicesSubnetB')
          NetworkAclId: Ref: h.ref('NACL')

      # Subnet Route Table Associations

      ServicesSubnetARouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('ServicesSubnetA')
          RouteTableId: Ref: h.ref('ServicesRouteTable')

      ServicesSubnetBRouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('ServicesSubnetB')
          RouteTableId: Ref: h.ref('ServicesRouteTable')