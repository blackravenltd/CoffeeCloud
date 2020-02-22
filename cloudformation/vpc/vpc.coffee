module.exports =
  Name: "VPC"
  Stack: 'network'
  CloudFormation: (env) ->
    Resources:
      # The Environment VPC.
      VPC:
        Type: 'AWS::EC2::VPC'
        Properties:
          CidrBlock:          env.VPCCIDR
          EnableDnsSupport:   true
          EnableDnsHostnames: true
          InstanceTenancy:    'default'
          Tags: [ { Key: 'Name', Value: 'VPC'} ]
