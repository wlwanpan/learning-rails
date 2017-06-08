
class Main.Views.Stats extends Backbone.View

  tagName: "div"
  className: "stats-view row"
  template: _.template '''

    <div class="medium-2 columns">
      <h1>DISPLAY CHART HERE</h1>
    </div>
    <div class="medium-10 columns">
      <div class="test-stat-placeholder"></div>
    </div>

  '''

  initialize: (options) ->
    {@collection, @$wrapper} = options

    @_render()
    @_position()
    @_render_subber_list()

  _render: ->
    @$el.html @template()

  _position: ->
    @$wrapper.html @el

  _render_subber_list: ->
    placeholder = @$('.test-stat-placeholder')
    @collection.each (sub) =>
      name = sub.get "subber_name"
      output = "<div>Subber Name: #{name} with "
      sub.stats_collection.each (stat) =>
        count = stat.get "user_count"
        date = stat.get "date"
        output += "<span>| count: #{count}, date: #{date} |</span>"
      placeholder.append output+"</div>"
