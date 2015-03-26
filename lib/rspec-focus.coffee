{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-text-editor', 'rspec-focus:add': => @add()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'rspec-focus:clear': => @clear()

  add: ->
    if editor = atom.workspace.getActiveTextEditor()
      regex = /(?:it|describe|context|feature|scenario).*do$/m
      cr = editor.getSelectedBufferRange()
      range = [[cr.end.row, cr.end.column], [0, 0]]

      editor.backwardsScanInBufferRange regex, range, ({matchText, stop, replace}) ->
        if matchText.indexOf(', focus: true') == -1
          replacement = matchText.replace(/\sdo$/, ', focus: true do')
          replace(replacement)

  clear: ->
    if editor = atom.workspace.getActiveTextEditor()
      editor.scan /, focus: true/g, (result) ->
        result.replace('')
