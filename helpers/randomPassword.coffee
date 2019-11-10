module.exports =
  randomString: (len = 10, outputName = "randomString Value") ->
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    out = ""
    out += chars[Math.round(Math.random()*chars.length)] for x in [0..len]
    console.error("> "+this.Name+" "+outputName+" = "+out)
    return out