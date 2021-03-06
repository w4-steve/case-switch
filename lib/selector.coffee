module.exports =
class Selector
  @editor = null

  constructor: ->
    @editor = atom.workspace.getActivePaneItem()

  toggleSelection: ->
    for selection in @editor.getSelections()
      if @isHyphenCase(selection)
        @hyphenToSnake(selection)
      else if @isSnakeCase(selection)
        @snakeToCamel(selection)
      else if @isCamelCase(selection)
        @camelToSnake(selection)

  convertToCamel: ->
    for selection in @editor.getSelections()
      if @isHyphenCase(selection)
        @hyphenToCamel(selection)
      if @isSnakeCase(selection)
        @snakeToCamel(selection)

  convertToSnake: ->
    for selection in @editor.getSelections()
      if @isHyphenCase(selection)
        @hyphenToSnake(selection)
      if @isCamelCase(selection)
        @camelToSnake(selection)

  isHyphenCase: (selection) ->
    selection.getText().indexOf('-') > -1

  isSnakeCase: (selection) ->
    selection.getText().indexOf('_') > -1

  isCamelCase: (selection) ->
    /[A-Z]/.test(selection.getText())

  snakeToCamel: (selection) ->
    string = selection.getText()
    while string.indexOf('_') >= 0
      index = string.indexOf('_') + 1
      char = string.charAt index
      string = @setCharAt(string, index, char.toUpperCase())
      string = string.replace(/_/, '')

    selection.insertText(string, select: true)

  hyphenToSnake: (selection) ->
    text = selection.getText()
    selection.insertText(text.replace(/([a-zA-Z0-9])(-)([a-zA-Z0-9])/g, "$1_$3"), select: true)

  hyphenToCamel: (selection) ->
    string = selection.getText()
    string = string.replace /(?:-)([a-z])/g, (v) ->
      v.toUpperCase()
    selection.insertText(string.replace(/-/g, ""), select: true)

  camelToSnake: (selection) ->
    string = selection.getText()
    string = string.replace /([a-z0-9])([A-Z])/g, "$1_$2"
    selection.insertText(string.toLowerCase(), select: true)

  setCharAt: (str,index,chr) ->
    str.substr(0,index) + chr + str.substr(index+1)
