

class Main.Views.ChartSubber extends Backbone.View

  tagName: "div"
  className: "chart-subber"
  template: _.template '''

    <div>
        <input type="checkbox">
        <%- server_alias %>
    </div>

  '''

  initialize: (options) ->
    {@model, @$wrapper} = options

    @_render()
    @_position()


  _render: ->
    @$el.html @template @model.toJSON()

  _position: ->
    @$wrapper.append @el
