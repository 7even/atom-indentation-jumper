module.exports =
  activate: (state) ->
    atom.workspaceView.command 'column-movement:down', => @down()
    atom.workspaceView.command 'column-movement:up',   => @up()
  
  deactivate: ->
  
  serialize: ->
  
  down: ->
    console.log 'moving down'
  
  up: ->
    console.log 'moving up'
