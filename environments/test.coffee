module.exports = 
  Name: 'Test Environment'
  Description: 'Test CloudFormation Template for DEV Environment, AWS ap-southeast-2'
  LogicalNamePrefix:    'Test'

  VPCCIDR: '10.0.0.0/16'

  AvailibilityZones:  [ 'ap-southeast-2a',  'ap-southeast-2b' ]

  PublicTierCIDR:     [ '10.0.0.0/24',  '10.0.1.0/24' ]
  WebTierCIDR:        [ '10.0.10.0/24', '10.0.11.0/24' ]
  ServicesTierCIDR:   [ '10.0.20.0/24', '10.0.21.0/24' ]
  DataTierCIDR:       [ '10.0.30.0/24', '10.0.31.0/24' ]

