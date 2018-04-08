# CoffeeCloud - How to write modules

## Modules

`.coffee` modules in the `cloudformation` directory and subdirectories are the basic unit for building templates, e.g.:

```coffeescript
module.exports =
  Name: "VPC"
  CloudFormation: (params) ->
    Resources:

      # The Environment VPC.
      
      TestVPC:
        Type: 'AWS::EC2::VPC'
        Properties:
          CidrBlock:          params.VPCCIDR
          EnableDnsSupport:   true
          EnableDnsHostnames: true
          InstanceTenancy:    'default'
          Tags: [ { Key: 'Name', Value: 'Test VPC' } ]

```

Typically, a module will contain entities from [The AWS Template Reference](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html). The whole object is merged with the template, hence the need for the `Resources:` key. Other types can be included also, for instance [AWS Template Parameters](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/parameters-section-structure.html):

```coffeescript
module.exports = 
  Parameters: 
    InstanceTypeParameter:
      Type: 'String'
      Default: 't1.micro'
      AllowedValues: [
        't1.micro'
        'm1.small'
        'm1.large'
      ]
      Description: 'Enter t1.micro, m1.small, or m1.large. Default is t1.micro.'
```

Usually, many modules will make up a complete template. Each module exports an object with the following properties:

| Name            | Description                                                    |
|:----------------|:---------------------------------------------------------------|
| Name            | The name of the module - only used for display in the compiler |
| CloudFormation  | A function that returns a JS object                            |

The `CloudFormation` function is called with two parameters `CloudFormation(params, context)`, where `params` is the environment. Environments are loaded from modules in the `environments` directory, e.g.:

## Environment Files

```coffeescript
module.exports = 
  Name: 'Test DEV'
  Description: 'Test CloudFormation Template for DEV Environment, AWS ap-southeast-2'

  VPCCIDR: '10.0.0.0/16'

  AvailibilityZones:  [ 'ap-southeast-2a',  'ap-southeast-2b' ]

  WebTierCIDR:        [ '10.0.1.0/24',  '10.0.2.0/24' ]
  ServicesTierCIDR:   [ '10.0.10.0/24', '10.0.11.0/24' ]
  DataTierCIDR:       [ '10.0.20.0/24', '10.0.21.0/24' ]
```

The entire enviroment export object is supplied as `param`, so you can define your own functions and helpers in the environment.