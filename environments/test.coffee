module.exports = 
  Name: 'Test DEV'
  Description: 'Test CloudFormation Template for DEV Environment, AWS ap-southeast-2'

  VPCCIDR: '10.0.0.0/16'

  AvailibilityZones:  [ 'ap-southeast-2a',  'ap-southeast-2b' ]

  WebTierCIDR:        [ '10.0.1.0/24',  '10.0.2.0/24' ]
  ServicesTierCIDR:   [ '10.0.10.0/24', '10.0.11.0/24' ]
  DataTierCIDR:       [ '10.0.20.0/24', '10.0.21.0/24' ]

