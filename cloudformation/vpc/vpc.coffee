module.exports =
  Name: "VPC"
  CloudFormation: (params) ->
    Resources:
      # The Environment VPC.
      TestVPC:
        Type: 'AWS::EC2::VPC'
        Properties:
          CidrBlock:          params.VPCCIDR
          EnableDnsSupport:   true
          EnableDnsHostnames: true
          InstanceTenancy:    'default'
          Tags: [ { Key: 'Name', Value: 'Test VPC' } ]
