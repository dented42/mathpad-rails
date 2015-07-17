//= require hash
//= require queue

{ div, p, h2, h3, table, thead, tbody, th, td, tr, input,
   button, form, span, col } = React.DOM

##############
# Scratchpad #
##############

@Scratchpad = React.createClass
  displayName: "Scratchpad"

  mixins: [React.addons.LinkedStateMixin]
  
  propTypes:
    scratchpad: React.PropTypes.shape(
      {
        id: React.PropTypes.number
      }).isRequired
    meta: React.PropTypes.shape(
      {
        editable: React.PropTypes.boolean
      }).isRequired

  getInitialState: ->
    scratchpad: @props.scratchpad
    editing: false
    newChanges: new Queue() # new changes not yet sent to the server go here
    unsyncedChanges: [] # and are put here when sent, and removed when the changes has been confirmed.

  queueChange: (change) ->
    @setState newChanges

  render: ->
    div className: "scratchpad",
      React.createElement ScratchpadMetadata,
        editable: @props.meta.editable
        

        author: @state.scratchpad.user

        titleLink: @linkState "scratchpad.title"
        initialDescription: @state.scratchpad.description

      React.createElement Lines,
        editable: @props.meta.editable
        
        initialLines: @state.scratchpad.lines

######################
# ScratchpadMetadata #
######################

@ScratchpadMetadata = React.createClass
  displayName: "ScratchpadMetadata"

  getInitialState: ->
    title: @props.initialTitle
    description: @props.initialDescription
    

  render: ->
    div className: "pad-metadata",
      h2 className: "title", @state.title
      h3 className: "author", "by " + @props.author.username
      p className: "description", @state.description

#########
# Lines #
#########

@Lines = React.createClass
  displayName: "LinesComponent"
  
  propTypes:
    lines: React.PropTypes.arrayOf(React.PropTypes.string)

  getInitialState: ->
    unique: @props.initialLines.length
    lines: ({local_id: idx, math: line} for line, idx in @props.initialLines)
    changed: false

  getUnique: ->
    n = @state.unique
    @setState unique: (n+1)
    n

  render: ->
    table className: "line-container",
      col className: "leading-gutter",
      col className: "content",
      col className: "trailing-gutter,"
      thead {},
        tr {},
          th {} #, "Drag thing"
          th {} #, "Line"
          th {} #, "Edit"
      tbody {},
        React.createElement MathLineProxy,
          key: "proxy-" + 0
          idx: 0
        for line, idx in @state.lines
          [
            React.createElement MathLine,
              key: "line-" + line.local_id
              id: line.local_id
              math: line.math
            React.createElement MathLineProxy,
              key: "proxy-" + (idx+1)
              idx: idx+1
          ]

#################
# MathLineProxy #
#################

@MathLineProxy = React.createClass
  displayName: "InsertionLine"

  render: ->
    tr className: "line proxy",
      td className: "leading-gutter-cell",
      td className: "content-cell",
        "insertion proxy " + @props.idx
      td className: "trailing-gutter-cell",

############
# MathLine #
############

@MathLine = React.createClass
  displayName: "MathLineComponent"

  # How server updates will work:
  #   The changed state variable indicates whether or not there are any
  # changes that the component has not attempted to send to the server.
  # if this is set to true, then the change is set off to the server, the
  # variable is set to false, and the change ID is added to the pendingChanges
  # list. Once there is confirmation that the change has been commited on the
  # server, it is removed from the pending changes list.

  getInitialState: ->
    math: @props.math
    dirty: true
    changed: false
    pendingChanges: []
    editing: false
  
  componentDidMount: ->
    @queueTypesetting()

  componentDidUpdate: ->
    if @state.dirty && (@state.editing == false)
      @queueTypesetting()
      @setState dirty: false
    # else if changed
    #   alert "server update"
    #   # push change to server
    #   # add change to pendingChanges
    #   @setState changed: false
  
  startEditing: ->
    @setState editing: @state.math
  
  handleEditing: (evt) ->
    @setState editing: evt.target.value
  
  resetEditing: (evt) ->
    evt.preventDefault()
    @setState { editing: false, dirty: true }
  
  acceptEditing: (evt) ->
    evt.preventDefault()
    eqn = @state.editing
    @setState {editing: false, dirty: true, changed: true, math: eqn}
  
  queueTypesetting: ->
    cell = React.findDOMNode(this.refs.cell)
    MathJax.Hub.Queue(["Typeset", MathJax.Hub, cell])
  
  render: ->
    tr className: "line",
      td className: "leading-gutter-cell", "drag"
      if (@state.editing == false)
        td className: "content-cell",
          "\\(" + @state.math + "\\)"
      else
        form {},
          [button
            type: "reset"
            key: "reset"
            onClick: @resetEditing
            "reset"
          input
            type: "text"
            key: "input"
            onChange: @handleEditing
            ref: "editField"
            value: @state.editing
          button
            type: "submit"
            key: "submit"
            onClick: @acceptEditing
            "submit"]
      td className: "trailing-gutter-cell",
        button onClick: @startEditing, "edit"
