module.exports =
class IndentationJumper
  constructor: (@direction) ->
    @editor  = atom.workspace.getActiveEditor()
    @lastRow = @editor.getScreenLineCount() - 1
    
    {@row, @column} = @editor.getCursorBufferPosition()
    @indentation = @getIndentationAt(@lineAt(@row))
  
  jump: ->
    @advance(@row)
    
    if @matches()
      # searching the last of adjacent matching lines
      lastMatchingRow = @currentRow
      while @rowIsValid()
        if @matches()
          lastMatchingRow = @currentRow
          @advance()
        else
          break
      
      # always jump to last found row
      # (even if adjacent lines continued to the very beginning/end of file)
      @editor.setCursorBufferPosition([lastMatchingRow, @column])
    else
      # simply searching for the first matching row
      while @rowIsValid()
        if @matches()
          @editor.setCursorBufferPosition([@currentRow, @column])
          break
        else
          @advance()
  
  rowIsValid: ->
    0 <= @currentRow <= @lastRow
  
  advance: (row = @currentRow) ->
    if @direction is 'down'
      @currentRow = row + 1
    else
      @currentRow = row - 1
  
  matches: ->
    line = @lineAt(@currentRow)
    @getIndentationAt(line) is @indentation and not @lineIsEmpty(line)
  
  lineAt: (row) ->
    @editor.lineForBufferRow(row)
  
  getIndentationAt: (line) ->
    /^ */.exec(line)[0].length
  
  lineIsEmpty: (line) ->
    /^\s*$/.test(line)
