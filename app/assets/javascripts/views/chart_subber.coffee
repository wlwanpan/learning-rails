
class Main.Views.ChartSubber extends Backbone.View

  tagName: "div"
  className: "chart-subber"
  template: _.template '''

    <div>
        <input type="checkbox">
        <%- server_alias %>
    </div>

  '''
  events:
    'change input': "_checked"
  initialize: (options) ->
    {@model, @$wrapper} = options

    @_render()
    @_position()

  _checked: ->
    #console.log "#{@model.get("server_alias")} is #{@$("input").is(':checked')}"
    @trigger 'checked'

  _render: ->
    @$el.html @template @model.toJSON()

  _position: ->
    @$wrapper.append @el
