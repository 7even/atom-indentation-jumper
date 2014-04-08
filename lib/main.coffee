IndentationJumper = require './indentation-jumper'

module.exports =
  activate: (state) ->
    atom.workspaceView.command 'indentation-jumper:down', =>
      new IndentationJumper().jump('down')
    atom.workspaceView.command 'indentation-jumper:up', =>
      new IndentationJumper().jump('up')
