module.exports =
  activate: (state) ->
    atom.workspaceView.command 'column-movement:down', => @down()
    atom.workspaceView.command 'column-movement:up',   => @up()
  
  deactivate: ->
  
  serialize: ->
  
  down: ->
    console.log 'moving down'
    
    editor = @getEditor()
    {row} = editor.getCursorBufferPosition()
    lineCount = editor.getScreenLineCount()
    indentation = @getIndentationAt(@lineAt(row))
    
    currentRow = row + 1
    while currentRow < lineCount
      console.log currentRow + 1 if @matches(currentRow, indentation)
      
      currentRow += 1
  
  up: ->
    console.log 'moving up'
  
  getEditor: ->
    atom.workspace.getActiveEditor()
  
  matches: (row, indentation) ->
    line = @lineAt(row)
    @getIndentationAt(line) is indentation and not @lineIsEmpty(line)
  
  lineAt: (row) ->
    @getEditor().lineForBufferRow(row)
  
  getIndentationAt: (line) ->
    /^ */.exec(line)[0].length
  
  lineIsEmpty: (line) ->
    /^\s*$/.test(line)
