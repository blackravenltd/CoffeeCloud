module.exports =
  Name: "Network Access Control List (NACL)"
  CloudFormation: (params) ->
    Resources:
      # The Environment Network ACL. We only use one, open ACL, security is handled by 
      # Security Groups.
      TestNACL:
        Type: 'AWS::EC2::NetworkAcl'
        Properties:
          VpcId: Ref: 'TestVPC'
          Tags: [ { Key: 'Name', Value: 'TestNACL' } ]

      # Allow-all Ingress Entry
      TestNACLIngress:
        Type: 'AWS::EC2::NetworkAclEntry'
        Properties:
          NetworkAclId: Ref: 'TestNACL'
          RuleNumber: '100'
          Protocol: '-1'
          RuleAction: 'allow'
          Egress: true
          CidrBlock: params.VPCCIDR
          Icmp:
            Code: '-1'
            Type: '-1'
      
      # Allow-all Egress Entry
      TestNACLEgress:
        Type: 'AWS::EC2::NetworkAclEntry'
        Properties:
          NetworkAclId: Ref: 'TestNACL'
          RuleNumber: '100'
          Protocol: '-1'
          RuleAction: 'allow'
          Egress: false
          CidrBlock: params.VPCCIDR
          Icmp:
            Code: '-1'
            Type: '-1'