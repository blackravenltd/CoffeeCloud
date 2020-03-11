module.exports = 
  Name: 'Prod Environment'
  Description: 'CloudFormation Template for Prod Environment, AWS ap-southeast-2'
  LogicalNamePrefix:    'Prod'

  VPCCIDR: '10.2.0.0/16'

  AvailibilityZones:  [ 'ap-southeast-2a',  'ap-southeast-2b',  'ap-southeast-2b' ]

  PublicTierCIDR:     [ '10.2.0.0/24',  '10.2.1.0/24',  '10.2.2.0/24'  ]
  WebTierCIDR:        [ '10.2.10.0/24', '10.2.11.0/24', '10.2.12.0/24' ]
  ServicesTierCIDR:   [ '10.2.20.0/24', '10.2.21.0/24', '10.2.22.0/24' ]
  DataTierCIDR:       [ '10.2.30.0/24', '10.2.31.0/24', '10.2.32.0/24' ]

