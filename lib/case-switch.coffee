CaseSwitchView = require './case-switch-view'
Selector = require './selector'
{CompositeDisposable} = require 'atom'

module.exports = CaseSwitch =
  caseSwitchView: null
  modalPanel: null
  subscriptions: null

  activate: ->
    atom.commands.add 'atom-workspace', "toggle-snake-camel:toggle", => @toggle()
    atom.commands.add 'atom-workspace', "toggle-snake-camel:convert-to-camel-case", => @convertToCamelCase()
    atom.commands.add 'atom-workspace', "toggle-snake-camel:convert-to-snake-case", => @convertToSnakeCase()

  toggle: ->
    @getSelector().toggleSelection()

  convertToCamelCase: ->
    @getSelector().convertToCamel()

  convertToSnakeCase: ->
    @getSelector().convertToSnake()

  getSelector: ->
    selector = new Selector
