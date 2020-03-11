module.exports =
  Name: "Data Tier"
  Stack: 'data'
  CloudFormation: (env, h) ->
    template =
      # Route Table & Route
      DataRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: h.ref('VPC')
          Tags: [ { Key: 'Name', Value: 'NACL'} ]

    # An example of a dynamic template. This code creates a subnet in each configured
    # Availability Zone

    for _, i in env.AvailabilityZones

      # Subnet
      template['DataSubnet'+i] = 
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailabilityZones[i]
          CidrBlock:            env.DataTierCIDR[i]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Data '+i } ]

      # Subnet ACL Associations
      template['DataSubnet'+i+'NetworkACLAssociation'] = 
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('DataSubnet'+i)
          NetworkAclId: Ref: h.ref('NACL')

      # Subnet Route Table Associations
      template['DataSubnet'+i+'RouteTableAssociation'] = 
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('DataSubnet'+i)
          RouteTableId: Ref: h.ref('DataRouteTable')

    return { Resources: template }
