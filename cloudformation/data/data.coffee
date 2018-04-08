module.exports =
  Name: "Data Tier"
  CloudFormation: (params) ->
    Resources:
      # Route Table & Route

      TestDataRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: 'TestVPC'
          Tags: [ { Key: 'Name', Value: 'TestNACL' } ]

      # Subnets 
      
      TestDataSubnetA:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: 'TestVPC'
          AvailabilityZone:     params.AvailibilityZones[0]
          CidrBlock:            params.DataTierCIDR[0]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Test Data A' } ]

      TestDataSubnetB:
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: 'TestVPC'
          AvailabilityZone:     params.AvailibilityZones[1]
          CidrBlock:            params.DataTierCIDR[1]
          MapPublicIpOnLaunch: false
          Tags: [ { Key: 'Name', Value: 'Test Data B' } ]

      # Subnet ACL Associations

      TestDataSubnetANetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: 'TestDataSubnetA'
          NetworkAclId: Ref: 'TestNACL'

      TestDataSubnetBNetworkACLAssociation:
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: 'TestDataSubnetB'
          NetworkAclId: Ref: 'TestNACL'

      # Subnet Route Table Associations

      TestDataSubnetARouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: 'TestDataSubnetA'
          RouteTableId: Ref: 'TestDataRouteTable'

      TestDataSubnetBRouteTableAssociation:
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: 'TestDataSubnetB'
          RouteTableId: Ref: 'TestDataRouteTable'