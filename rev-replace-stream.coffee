through   = require('through2')
frep      = require('frep')

# TODO: break this out into external module
module.exports = ->
  patterns  = []
  files     = []

  through.obj(((file, enc, cb) ->
    this.push(file)
    files.push(file)

    oPath = file.revOrigPath
    nPath = file.path

    if !oPath || !nPath
      return cb()

    oPathSplit = oPath.split(file.base)
    nPathSplit = nPath.split(file.base)

    if oPathSplit.length > 1
      oPath = oPathSplit[1]

    if nPathSplit.length > 1
      nPath = nPathSplit[1]

    patterns.push({
      pattern:     oPath
      replacement: nPath
    })

    cb()
  ), ((cb) ->
    patterns = patterns.filter((item) -> typeof(item) == 'object')
    files.forEach (file) ->
      try
        if Array.isArray(opts)
          file.contents = new Buffer(frep.strWithArr(String(file.contents), patterns))
        else
          file.contents = new Buffer(frep.strWithObj(String(file.contents), patterns))
      catch err
        console.warn('Error caught from frep: ' + err.message + '.')
    cb()
  ))
