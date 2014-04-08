module.exports =
  activate: (state) ->
    atom.workspaceView.command 'column-movement:down', => @down()
    atom.workspaceView.command 'column-movement:up',   => @up()
  
  deactivate: ->
  
  serialize: ->
  
  down: ->
    console.log 'moving down'
    @jump('down')
  
  up: ->
    console.log 'moving up'
    @jump('up')
  
  jump: (direction) ->
    editor = @getEditor()
    {row, column} = editor.getCursorBufferPosition()
    indentation = @getIndentationAt(@lineAt(row))
    
    [firstRow, lastRow] = [0, editor.getScreenLineCount() - 1]
    lastMatchingRow = currentRow
    
    currentRow = @next(row, direction)
    if @matches(currentRow, indentation)
      # searching the last of adjacent matching lines
      while firstRow <= currentRow <= lastRow
        if @matches(currentRow, indentation)
          lastMatchingRow = currentRow
          currentRow = @next(currentRow, direction)
        else
          editor.setCursorBufferPosition([lastMatchingRow, column])
          break
    else
      # simply searching for the first matching row
      while firstRow <= currentRow <= lastRow
        if @matches(currentRow, indentation)
          editor.setCursorBufferPosition([currentRow, column])
          break
        else
          currentRow = @next(currentRow, direction)
  
  next: (row, direction) ->
    if direction is 'down'
      row + 1
    else
      row - 1
  
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
