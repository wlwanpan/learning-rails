
class Main.Views.ChartSubber extends Backbone.View

  tagName: "div"
  template: _.template '''

    <button class="chart-subber-button primary hollow button">
      <%- server_alias %>
    </button>

  '''
  events:
    'click button': "_selected"
  initialize: (options) ->
    {@model, @$wrapper} = options

    @_render()
    @_position()

  _selected: ->
    #console.log "#{@model.get("server_alias")} is #{@$("input").is(':checked')}"
    @trigger 'checked'

  _render: ->
    @$el.html @template @model.toJSON()

  _position: ->
    @$wrapper.append @el
