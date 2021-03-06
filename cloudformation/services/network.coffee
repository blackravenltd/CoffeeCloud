module.exports =
  Name: "Services Tier"
  Stack: 'services'
  CloudFormation: (env, h) ->
    template =
      # Route Table & Route
      ServicesRouteTable:
        Type: 'AWS::EC2::RouteTable'
        Properties:
          VpcId: Ref: h.ref('VPC')
          Tags: [ { Key: 'Name', Value: 'NACL'} ]

    # An example of a dynamic template. This code creates a subnet in each configured
    # Availability Zone

    for _, i in env.AvailabilityZones

      # Subnet
      template['ServicesSubnet'+i] = 
        Type: 'AWS::EC2::Subnet'
        Properties:
          VpcId:                Ref: h.ref('VPC')
          AvailabilityZone:     env.AvailabilityZones[i]
          CidrBlock:            env.ServicesTierCIDR[i]
          MapPublicIpOnLaunch:  false
          Tags: [ { Key: 'Name', Value: 'Services '+i } ]

      # Subnet ACL Associations
      template['ServicesSubnet'+i+'NetworkACLAssociation'] = 
        Type: 'AWS::EC2::SubnetNetworkAclAssociation'
        Properties:
          SubnetId:     Ref: h.ref('ServicesSubnet'+i)
          NetworkAclId: Ref: h.ref('NACL')

      # Subnet Route Table Associations
      template['ServicesSubnet'+i+'RouteTableAssociation'] = 
        Type: 'AWS::EC2::SubnetRouteTableAssociation'
        Properties:
          SubnetId:     Ref: h.ref('ServicesSubnet'+i)
          RouteTableId: Ref: h.ref('ServicesRouteTable')

    return { Resources: template }
