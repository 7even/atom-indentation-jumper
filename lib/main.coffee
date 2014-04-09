IndentationJumper = require './indentation-jumper'

module.exports =
  activate: (state) ->
    atom.workspaceView.command 'indentation-jumper:down', =>
      new IndentationJumper('down').jump()
    atom.workspaceView.command 'indentation-jumper:up', =>
      new IndentationJumper('up').jump()
    atom.workspaceView.command 'indentation-jumper:select-down', =>
      new IndentationJumper('down').select()
    atom.workspaceView.command 'indentation-jumper:select-up', =>
      new IndentationJumper('up').select()
