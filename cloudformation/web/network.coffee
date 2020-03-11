module.exports =
  Name: "Web Tier"
  Stack: 'web'
  CloudFormation: (env, h) ->
    template =
      # Route Table & Route
      WebRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: h.ref('VPC')
          Tags: [ { Key: 'Name', Value: 'NACL'} ]

    # An example of a dynamic template. This code creates a subnet in each configured
    # Availability Zone

    for _, i in env.AvailabilityZones

      # Subnet
      template['WebSubnet'+i] = 
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailabilityZones[i]
          CidrBlock:            env.WebTierCIDR[i]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Web '+i } ]

      # Subnet ACL Associations
      template['WebSubnet'+i+'NetworkACLAssociation'] = 
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('WebSubnet'+i)
          NetworkAclId: Ref: h.ref('NACL')

      # Subnet Route Table Associations
      template['WebSubnet'+i+'RouteTableAssociation'] = 
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('WebSubnet'+i)
          RouteTableId: Ref: h.ref('WebRouteTable')

    return { Resources: template }
