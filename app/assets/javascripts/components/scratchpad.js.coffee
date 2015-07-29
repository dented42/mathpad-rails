{ div, p, h2, h3, table, thead, tbody, th, td, tr, input,
   button, form, span, col } = React.DOM

t = require('tcomb-form')
Form = t.form.Form

##############
# Scratchpad #
##############

@ScratchpadEditor = React.createClass
  displayName: "Scratchpad"

  getInitialState: ->
    title: @props.scratchpad.title
    description: @props.scratchpad.description
    lines: @props.scratchpad.lines.join("\n")

  formType: ->
    t.struct
      title: t.Str
      description: t.Str
      lines: t.Str

  formOptions: ->
    fields:
      description:
        type: 'textarea'
      lines:
        type: 'textarea'

  render: ->
    React.createElement Form,
      type: @formType()
      options: @formOptions()
      value: @state

module.exports = {
  Scratchpad: @Scratchpad
}
