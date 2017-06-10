
<<<<<<< HEAD

=======
>>>>>>> renaming-mode
class Main.Views.ChartSubber extends Backbone.View

  tagName: "div"
  className: "chart-subber"
  template: _.template '''

    <div>
        <input type="checkbox">
        <%- server_alias %>
    </div>

  '''
<<<<<<< HEAD

=======
  events:
    'change input': "_checked"
>>>>>>> renaming-mode
  initialize: (options) ->
    {@model, @$wrapper} = options

    @_render()
    @_position()

<<<<<<< HEAD
=======
  _checked: ->
    #console.log "#{@model.get("server_alias")} is #{@$("input").is(':checked')}"
    @trigger 'checked'
>>>>>>> renaming-mode

  _render: ->
    @$el.html @template @model.toJSON()

  _position: ->
    @$wrapper.append @el
