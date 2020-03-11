module.exports = 
  Name: 'Test Environment'
  Description: 'Test CloudFormation Template for DEV Environment, AWS ap-southeast-2'
  LogicalNamePrefix:    'Test'

  VPCCIDR: '10.0.0.0/16'

  # This Test Environment requires only a single Availability Zones

  AvailabilityZones:  [ 'ap-southeast-2a' ]

  PublicTierCIDR:     [ '10.0.0.0/24' ]
  WebTierCIDR:        [ '10.0.10.0/24' ]
  ServicesTierCIDR:   [ '10.0.20.0/24' ]
  DataTierCIDR:       [ '10.0.30.0/24' ]

