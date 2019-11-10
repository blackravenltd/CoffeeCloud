# CoffeeCloud

CoffeeCloud allows you to write [AWS CloudFormation](https://aws.amazon.com/cloudformation) templates with [Coffeescript](http://coffeescript.org).

**Why would I want to do that?**

* CoffeeScript syntax for objects is less likely to melt your brain.
* Multiple source files that build to one template means you can organise subsystems in directories, and easily reuse common components.
* You can use dynamic templates, for a single AWS topology with multiple environments (DEV, UAT, PROD) where the config changes depending on environment.
* You get to do comments. Just do `# <comment_text>`, well, anywhere you like.

## Installation

Requires `nodejs`, `coffee-script` and Python `cfn-lint`.

### Linux (Ubuntu)

```bash
apt-get install nodejs python3 python3-pip
npm install -g coffee-script
npm install && npm link
pip install cfn-lint
```

### MacOSX (Homebrew)

```bash
brew install nodejs python3
npm install -g coffee-script
npm install && npm link
pip install cfn-lint
```

## Building Templates

`coffee-script` is used as a macro language to build environment templates. CD to the directory where your project is, and run:

```bash
  cd <projectdir>/
  coffeecloud
```

### Environments

Each `.coffee` file in the `enviroments` directory represents an environment, **except** files which start with an underscore `_`. Each file represents one environment e.g. `environments/test.coffee`:

```coffeescript
module.exports = 
  Name: 'Test DEV'
  Description: 'Test CloudFormation Template for DEV Environment, AWS ap-southeast-2'

  VPCCIDR: '10.0.0.0/16'

  AvailibilityZones:  [ 'ap-southeast-2a',  'ap-southeast-2b' ]

  WebCIDR:        [ '10.0.1.0/24',  '10.0.2.0/24' ]
  DataCIDR:       [ '10.0.20.0/24', '10.0.21.0/24' ]
```

An environment module **must** declare the `Name` property in order to be processed.

One CloudFormation `<envname>.template` will be build for each environment.

### Environment Common Component(s)

All files in `/enviroments` which start with an underscore are assumed to be common files, and are merged into a single environment object which is included in all other environments. You can define common CIDR/IP ranges, Ports or AMI IDs for all environments, e.g. `environments/_common.coffee`:

```coffeescript
module.exports = 

  # Internet Range
  
  InternetCIDR:       '0.0.0.0/0'
  
  # Ports

  Ports:
    SSH: 22
    MySQL: 3306
```

Anything in these files will be available in all environments. Individual environment files can however override these values by redeclaring them.

### CloudFormation Topology

Each `.coffee` file in the `cloudformation` directory and its subdirectories represents a part of the CloudFormation template. All files are loaded in an arbitary order, `CloudFormation(env, helpers)` is called on each module, and the results merged into the environment template, e.g `cloudformation/vpc/vpc.coffee`:

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

 A `Name` property can also be defined on the module, which is used only for the logging output of the compiler.

### Helpers
Each `.coffee` file in the `helpers` directory and its subdirectories represents part of the helpers object supplied to each `CloudFormation(env, helpers)` call. Here you can define helper functions.

Multiple helpers can be defined in each file.

### Ignoring Directories
You can add an empty `.ignore` file in a directory to skip it and all its subdirectories during a build - this is useful for partial stacks, or when you're testing only a subset of your infrastructure.

## Hints and Tips

* Convert AWS example snippets and existing AWS Cloudformation templates into Coffeescript using the excellent [js2.coffee](http://js2.coffee/).

## Contributing

Contributions, critique, bug notices and fixes are very welcome. Please use github issues / fork and submit a PR.

## Code of Conduct

The CoffeeCloud project is committed to the [Contributor Covenant](http://contributor-covenant.org). Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before making any contributions or comments.


	
