
class Main.Views.Charts extends Backbone.View

  tagName: "div"
  className: "charts-view row"
  template: _.template '''

    <div class="chart-subbers-placeholder medium-2 columns">
      Display Nav Options Here
      <input type="text" placeholder="Search server">
    </div>
    <div class="medium-10 columns">
      <h1>DISPLAY DATA HERE</h1>
      <canvas class="chart-canvas" width="400" height="400"></canvas>
      <div class="test-stat-placeholder"></div>
    </div>

  '''

  initialize: (options) ->
    {@collection, @$wrapper} = options

    @_render()
    @_position()
    @_render_subber_list()
    @_render_chart()

    @listenTo @collection, 'add', =>
      @_render_subber_list()

  _render_chart: () ->
    @chart = @$(".chart-canvas")

    lineChart = new Chart @chart,
      type: 'line',
      data:
        labels: ["January", "Febuary", "March", "April"]
        fill: false
        borderDash: []
        data: [12, 44, 56, 778, 1]

  _render: ->
    @$el.html @template()

  _position: ->
    @$wrapper.html @el

  _render_subber_list: ->
    dataPlaceholder = @$('.test-stat-placeholder')
    subbersPlaceholder = @$('.chart-subbers-placeholder')

    @collection.each (sub) =>
      name = sub.get "server_name"
      subbersPlaceholder.append("<div>#{name}</div>")
      output = "<div>Subber Name: #{name} with "
      sub.statistics.each (stat) =>
        count = stat.get "user_count"
        date = stat.get "date"
        output += "<span>| count: #{count}, date: #{date} |</span>"
      dataPlaceholder.append output+"</div>"

  _reRender: ->
    @_render()
    @_position()
    @_render_subber_list()
    @_render_chart()
