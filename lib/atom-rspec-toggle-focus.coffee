AtomRspecToggleFocusView = require './atom-rspec-toggle-focus-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomRspecToggleFocus =
  atomRspecToggleFocusView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomRspecToggleFocusView = new AtomRspecToggleFocusView(state.atomRspecToggleFocusViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomRspecToggleFocusView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-rspec-toggle-focus:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomRspecToggleFocusView.destroy()

  serialize: ->
    atomRspecToggleFocusViewState: @atomRspecToggleFocusView.serialize()

  toggle: ->
    console.log 'AtomRspecToggleFocus was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
