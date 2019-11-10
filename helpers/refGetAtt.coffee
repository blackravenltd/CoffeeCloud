module.exports =
  refGetAtt: (name, paramName) ->
    return { "Fn::GetAtt": [ this.LogicalNamePrefix+name, paramName ] }