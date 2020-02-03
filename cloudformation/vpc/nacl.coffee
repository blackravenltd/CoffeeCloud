module.exports =
  Name: "Network Access Control List (NACL)"
  Stack: 'network'
  CloudFormation: (env,h) ->
    Resources:
      # The Environment Network ACL. We only use one, open ACL, security is handled by 
      # Security Groups.
      NACL:
        Type: 'AWS::EC2::NetworkAcl'
        Properties:
          VpcId: Ref: h.ref('VPC')
          Tags: [ { Key: 'Name', Value: 'NACL'} ]

      # Allow-all Ingress Entry
      NACLIngress:
        Type: 'AWS::EC2::NetworkAclEntry'
        Properties:
          NetworkAclId: Ref: h.ref('NACL')
          RuleNumber: 100
          Protocol: -1
          RuleAction: 'allow'
          Egress: true
          CidrBlock: env.VPCCIDR
          Icmp:
            Code: -1
            Type: -1
      
      # Allow-all Egress Entry
      NACLEgress:
        Type: 'AWS::EC2::NetworkAclEntry'
        Properties:
          NetworkAclId: Ref: h.ref('NACL')
          RuleNumber: 100
          Protocol: -1
          RuleAction: 'allow'
          Egress: false
          CidrBlock: env.VPCCIDR
          Icmp:
            Code: -1
            Type: -1