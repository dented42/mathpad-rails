//= require hash

{ div, p, h2, h3, table, thead, tbody, th, td, tr, input, button,
  form, span } = React.DOM

##############
# Scratchpad #
##############

@Scratchpad = React.createClass
  displayName: "Scratchpad"
  
  propTypes:
    id: React.PropTypes.number.isRequired

  getInitialState: ->
    unique: @props.lines.length
    title: @props.title
    author: @props.user
    description: @props.description
    lines: {local_id: idx, math: line} for line, idx in @props.lines

  render: ->
    div className: "scratchpad",
      React.createElement ScratchpadMetadata,
        scratchpad: @props
      h2 className: "title", @state.title
      h3 className: "author", "by " + @state.author.username
      p className: "description", @state.description
      React.createElement Lines,
        initialLines: @state.lines

#########
# Lines #
#########

@Lines = React.createClass
  displayName: "LinesComponent"
  
  propTypes:
    initialLines: React.PropTypes.arrayOf(React.PropTypes.string)

  getInitialState: ->
    lines: @props.initialLines
    dirty: [0...(@props.initialLines.length)]
    editing: []

  componentDidMount: ->
    @processDirty()

  componentDidUpdate: ->
    @processDirty()

  processDirty: ->
    dirty =  @state.dirty
    if dirty.length > 0
      dirt = dirty[0]
      @typesetAt(dirt)
      @setState dirty: dirty[1..]

  typesetAt: (idx) ->
    cell = React.findDOMNode(this.refs.lineHolder).children[idx]
    MathJax.Hub.Queue(["Typeset", MathJax.Hub, cell])

  insert: (p) ->
    dirty = @state.dirty
    editing = @state.editing
    for lineIdx, idx in dirty when lineIdx >= p
      dirty[idx]++
    for editIdx, idx in editing when editIdx >= p
      editing[idx]++
    @setState dirty: dirty, editing: editing

  delete: (p) ->
    dirty = @state.dirty
    editing = @state.editing
    for lineIdx, idx in dirty when lineIdx > p
      dirty[idx]--
    for editIdx, idx in editing when editIdx > p
      editing[idx]--
    @setState dirty: dirty, editing: editing

  handleEditClick: (evt) ->
    idx = @indexForEquation()

  render: ->
    table className: "line-container",
      tbody ref: "lineHolder",
        for line, idx in @state.lines
          tr className: "line-row",
            td className: "line-cell",
               span onClick: @handleEditClick,
                 "\\(" + line + "\\)"


    #     if !(@state.editing == false)
    #       form {},
    #         [button
    #           type: "reset"
    #           key: "reset"
    #           onClick: @resetEditing
    #           "reset"
    #         input
    #           type: "text"
    #           key: "input"
    #           onChange: @handleEditing
    #           ref: "editField"
    #           value: @state.editing
    #         button
    #           type: "submit"
    #           key: "submit"
    #           onClick: @submitEditing
    #           "submit"]
    #     else
    #       "\\(" + @state.content + "\\)"


#      cell = React.findDOMNode(this.refs.mathCell)
#      
