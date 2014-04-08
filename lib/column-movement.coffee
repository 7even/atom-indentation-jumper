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
    if @matches(currentRow, indentation)
      # search for last adjacent matching row
      while currentRow < lineCount
        if @matches(currentRow, indentation)
          currentRow++
        else
          previousRow = currentRow - 1
          editor.moveCursorDown(previousRow - row)
          break
    else
      # jump to first matching row
      while currentRow < lineCount
        if @matches(currentRow, indentation)
          # console.log currentRow + 1
          editor.moveCursorDown(currentRow - row)
          break
        else
          currentRow++
  
  up: ->
    console.log 'moving up'
    
    editor = @getEditor()
    {row} = editor.getCursorBufferPosition()
    indentation = @getIndentationAt(@lineAt(row))
    
    currentRow = row - 1
    if @matches(currentRow, indentation)
      # search for last adjacent matching row
      while currentRow >= 0
        if @matches(currentRow, indentation)
          currentRow--
        else
          previousRow = currentRow + 1
          editor.moveCursorUp(row - previousRow)
          break
    else
      # jump to first matching row
      while currentRow >= 0
        if @matches(currentRow, indentation)
          # console.log currentRow + 1
          editor.moveCursorUp(row - currentRow)
          break
        else
          currentRow--
  
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
