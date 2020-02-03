module.exports =
  Name: 'Internet Gateway'
  Stack: 'network'
  CloudFormation: (env,h) ->
    Resources:
      # The Environment Internet Gateway.
      InternetGateway:
        Type: 'AWS::EC2::InternetGateway'
        Properties:
          Tags: [ { Key: 'Name', Value: 'Internet Gateway'} ]

      # Attach the Internet Gateway to the VPC.
      InternetGatewayVPCAttachment:
        Type: 'AWS::EC2::VPCGatewayAttachment'
        Properties:
          InternetGatewayId:  Ref: h.ref('InternetGateway')
          VpcId:              Ref: h.ref('VPC')

