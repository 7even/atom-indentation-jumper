IndentationJumper = require './indentation-jumper'

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace',
      'indentation-jumper:down':        => new IndentationJumper('down').jump()
      'indentation-jumper:up':          => new IndentationJumper('up').jump()
      'indentation-jumper:select-down': => new IndentationJumper('down').select()
      'indentation-jumper:select-up':   => new IndentationJumper('up').select()
