{ div, p, h2, h3, table, thead, tbody, th, td, tr, input } = React.DOM

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
    @setState editing: true
  render: ->
    tr className: "scratchpad-line",
      td
        className: "scratchpad-line-content"
        onClick: @handleClick
        if @state.editing
          input
            type: "text"
            value: @state.content
        else
          @state.content        
