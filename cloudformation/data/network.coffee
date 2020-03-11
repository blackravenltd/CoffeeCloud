module.exports =
  Name: "Data Tier"
  Stack: 'data'
  CloudFormation: (env, h) ->
    t =
      # Route Table & Route
      DataRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: h.ref('VPC')
          Tags: [ { Key: 'Name', Value: 'NACL'} ]

    for az, i in env.AvailibilityZones

      t['DataSubnet'+i] = 
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailibilityZones[i]
          CidrBlock:            env.DataTierCIDR[i]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Data '+i } ]

      # Subnet ACL Associations

      t['DataSubnet'+i+'NetworkACLAssociation'] = 
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('DataSubnet'+i)
          NetworkAclId: Ref: h.ref('NACL')

      # Subnet Route Table Associations

      t['DataSubnet'+i+'RouteTableAssociation'] = 
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('DataSubnet'+i)
          RouteTableId: Ref: h.ref('DataRouteTable')

    return { Resources: t }
