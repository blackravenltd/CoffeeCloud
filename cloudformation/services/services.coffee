module.exports =
  Name: "Services Tier"
  CloudFormation: (params) ->
    Resources:
      # Route Table & Route

      TestServicesRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: 'TestVPC'
          Tags: [ { Key: 'Name', Value: 'TestNACL' } ]

      # Subnets
      
      TestServicesSubnetA:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: 'TestVPC'
          AvailabilityZone:     params.AvailibilityZones[0]
          CidrBlock:            params.ServicesTierCIDR[0]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Test Services A' } ]

      TestServicesSubnetB:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId: Ref: 'TestVPC'
          AvailabilityZone:     params.AvailibilityZones[1]
          CidrBlock:            params.ServicesTierCIDR[1]
          MapPublicIpOnLaunch: false
          Tags: [ { Key: 'Name', Value: 'Test Services B' } ]

      # Subnet ACL Associations

      TestServicesSubnetANetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: 'TestServicesSubnetA'
          NetworkAclId: Ref: 'TestNACL'

      TestServicesSubnetBNetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: 'TestServicesSubnetB'
          NetworkAclId: Ref: 'TestNACL'

      # Subnet Route Table Associations

      TestServicesSubnetARouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: 'TestServicesSubnetA'
          RouteTableId: Ref: 'TestServicesRouteTable'

      TestServicesSubnetBRouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: 'TestServicesSubnetB'
          RouteTableId: Ref: 'TestServicesRouteTable'