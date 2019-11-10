Handlebars = require("handlebars")
fs = require("fs")
path = require("path")

module.exports =
  base64Template: (fileName, env = this) ->
    content = Handlebars.compile(fs.readFileSync(fileName).toString())
    root = path.join(__dirname,"../build")
    output = content(env)

    return Buffer.from(output).toString('base64')
