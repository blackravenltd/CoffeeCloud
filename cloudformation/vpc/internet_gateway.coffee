module.exports =
  Name: "Internet Gateway"
  CloudFormation: (params) ->
    Resources:
      # The Environment Internet Gateway.
      TestInternetGateway:
        Type: "AWS::EC2::InternetGateway"
        Properties:
          Tags: [ { Key: 'Name', Value: 'Test Internet Gateway' } ]

      # Attach the Internet Gateway to the VPC.
      TestInternetGatewayVPCAttachment:
        Type: "AWS::EC2::VPCGatewayAttachment"
        Properties:
          InternetGatewayId:  Ref: "TestInternetGateway"
          VpcId:              Ref: "TestVPC"

