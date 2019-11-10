module.exports = 
  Name: 'Staging Environment'
  Description: 'CloudFormation Template for Staging Environment, AWS ap-southeast-2'
  LogicalNamePrefix:    'Staging'

  VPCCIDR: '10.1.0.0/16'

  AvailibilityZones:  [ 'ap-southeast-2a',  'ap-southeast-2b' ]

  PublicTierCIDR:     [ '10.1.0.0/24',  '10.1.1.0/24' ]
  WebTierCIDR:        [ '10.1.10.0/24', '10.1.11.0/24' ]
  ServicesTierCIDR:   [ '10.1.20.0/24', '10.1.21.0/24' ]
  DataTierCIDR:       [ '10.1.30.0/24', '10.1.31.0/24' ]

