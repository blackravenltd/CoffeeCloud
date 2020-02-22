module.exports =
  Name: "Data Tier"
  Stack: 'data'
  CloudFormation: (env, h) ->
    Resources:
      # Route Table & Route

      DataRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: h.ref('VPC')
          Tags: [ { Key: 'Name', Value: 'NACL'} ]

      # Subnets 
      
      DataSubnetA:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailibilityZones[0]
          CidrBlock:            env.DataTierCIDR[0]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Data A'} ]

      DataSubnetB:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailibilityZones[1]
          CidrBlock:            env.DataTierCIDR[1]
          MapPublicIpOnLaunch: false
          Tags: [ { Key: 'Name', Value: 'Data B'} ]

      # Subnet ACL Associations

      DataSubnetANetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('DataSubnetA')
          NetworkAclId: Ref: h.ref('NACL')

      DataSubnetBNetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('DataSubnetB')
          NetworkAclId: Ref: h.ref('NACL')

      # Subnet Route Table Associations

      DataSubnetARouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('DataSubnetA')
          RouteTableId: Ref: h.ref('DataRouteTable')

      DataSubnetBRouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('DataSubnetB')
          RouteTableId: Ref: h.ref('DataRouteTable')