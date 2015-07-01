{ div, p, h2, h3, table, thead, tbody, th, td, tr, input, button,
  form } = React.DOM

@Scratchpad = React.createClass
  displayName: "ScratchpadComponent"
  propTypes:
    id: React.PropTypes.number.isRequired
  getInitialState: ->
    id: @props.id
    title: @props.title
    author: @props.user
    description: @props.description
    lines: @props.lines
  getDefaultProps: ->
    scratchpad: []
  render: ->
    div className: "scratchpad",
      h2 className: "scratchpad-title", @state.title
      h3 className: "scratchpad-author", "by " + @state.author.username
      p className: "scratchpad-description", @state.description
      table className: "scratchpad-line-container",
        tbody {},
          for line in @state.lines.sort((a, b) -> a.order - b.order)
            React.createElement Line,
              id: line.id,
              key: line.id
              initialContent: line.content,
              initialOrder: line.order

@Line = React.createClass
  displayName: "LineComponent"
  
  propTypes:
    id: React.PropTypes.number.isRequired
    initialOrder: React.PropTypes.number.isRequired
    initialContent: React.PropTypes.string.isRequired

  getInitialState: ->
    dirty: true
    editing: false
    content: @props.initialContent
    order: @props.initialOrder

  componentDidMount: ->
    @queueTypesetting()

  componentDidUpdate: ->
    if (@state.editing == false) && (@state.dirty == true)
      @queueTypesetting()

  handleClick: (event) ->
    if @state.editing == false
      @setState editing: @state.content, () -> @focusInput()

  focusInput: ->
    React.findDOMNode(this.refs.editField).focus()

  endEditing: ->
    @setState editing: false

  queueTypesetting: ->
    if @state.editing == false
      cell = React.findDOMNode(this.refs.mathCell)
      MathJax.Hub.Queue(["Typeset", MathJax.Hub, cell])
      @setState dirty: false

  handleEditing: (event) ->
    @setState editing: event.target.value

  resetEditing: (event) ->
    event.preventDefault()
    @endEditing()

  submitEditing: (event) ->
    event.preventDefault()
    @setState content: @state.editing
    @setState dirty: true
    @endEditing()

  render: ->
    tr
      className: "scratchpad-line"
      onClick: @handleClick
      td
        key: "td-" + @props.id
        ref: "mathCell"
        className: "scratchpad-line-content"
        if !(@state.editing == false)
          form {},
            [button
              type: "reset"
              key: "reset-" + @props.id
              onClick: @resetEditing
              "reset"
            input
              type: "text"
              key: "input-" + @props.id
              onChange: @handleEditing
              ref: "editField"
              value: @state.editing
            button
              type: "submit"
              key: "submit-" + @props.id
              onClick: @submitEditing
              "submit"]
        else
          "\\(" + @state.content + "\\)"
