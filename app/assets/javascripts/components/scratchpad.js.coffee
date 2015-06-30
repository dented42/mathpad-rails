{ div, p, h2, h3, table, thead, tbody, th, td, tr, input, button,
  form } = React.DOM

@Scratchpad = React.createClass
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
  propTypes:
    id: React.PropTypes.number.isRequired
    initialOrder: React.PropTypes.number.isRequired
    initialContent: React.PropTypes.string.isRequired
  getInitialState: ->
    editing: false
    content: @props.initialContent
    order: @props.initialOrder
  handleClick: (event) ->
    if !@state.editing
      @setState editing: @state.content, () -> @focusInput()
  focusInput: ->
    React.findDOMNode(this.refs.editField).focus()
  # beginEditing: (component) ->
  #   if @state.editing == true
  #     React.findDOMNode(component).focus()
  #     @setState editing: @state.content
  handleEditing: (event) ->
    @setState editing: event.target.value
  resetEditing: (event) ->
    event.preventDefault()
    @setState editing: false
  submitEditing: (event) ->
    event.preventDefault()
    @setState content: @state.editing
    @setState editing: false
  render: ->
    tr
      className: "scratchpad-line"
      onClick: @handleClick
      td
        key: "td-" + @props.id
        className: "scratchpad-line-content"
        if @state.editing
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
          @state.content        
