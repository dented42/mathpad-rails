{ div, p, h2, h3, table, thead, tbody, th, td, tr } = React.DOM

@Scratchpad = React.createClass
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
      table {},
        tbody {},
          for line in @state.lines.sort((a, b) -> a.order - b.order)
            React.createElement Line, line: line

@Line = React.createClass
  render: ->
    tr {},
    td {}, @props.line.content
        
