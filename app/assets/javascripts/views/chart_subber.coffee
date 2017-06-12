
class Main.Views.ChartSubber extends Backbone.View

  tagName: "div"
  template: _.template '''

    <button name="select" class="chart-subber-button primary hollow button">
      <div><i class="bi fi-torso"></i><span class="bi-label"><%- server_alias %></span></div>
      <div class="bi-label"><%- server_location %></div>
    </button>

  '''
  events:
    'click button': "_selected"
  initialize: (options) ->
    {@model, @$wrapper} = options

    @_render()
    @_position()
    @$button = @$('.chart-subber-button')

  _selected: ->
    #console.log "#{@model.get("server_alias")} is #{@$("input").is(':checked')}"
    if @$button.hasClass 'success'
      @$button.removeClass 'success'
    else
      @$button.addClass 'success'

    @trigger 'checked'

  _render: ->
    @$el.html @template @model.toJSON()

  _position: ->
    @$wrapper.append @el
