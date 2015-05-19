{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-text-editor', 'rspec-focus:toggle': => @toggle()

  toggle: ->
    if editor = atom.workspace.getActiveTextEditor()
      editor.moveToEndOfLine()

      regex = /(?: it|describe|context|feature|scenario).*do$/m
      cr    = editor.getSelectedBufferRange()
      range = [[cr.end.row, cr.end.column], [0, 0]]

      editor.backwardsScanInBufferRange regex, range, ({matchText, stop, replace}) ->
        if matchText.indexOf(', focus: true') == -1
          replacement = matchText.replace(/\sdo$/, ', focus: true do')
          replace(replacement)
        else
          replacement = matchText.replace(', focus: true do', ' do')
          replace(replacement)
