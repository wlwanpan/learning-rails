
class Main.Views.Charts extends Backbone.View

  tagName: "div"
  className: "charts-view row"
  template: _.template '''

    <div class="subbers-container medium-3 columns">
      <i class="chart-arrow fi-arrow-left"/>
      <h2>CHART</h2>
      <select>
        <option DISABLED> Choose Chart Type </option>
        <option> Line Chart </option>
        <option> Pie Chart </option>
        <option> Some Chart </option>
      </select>
      <form>
        <input type="text" class="search-form" placeholder="Search server">
      </form>
      <div class="subbers-placeholder"></div>
    </div>
    <div class="canvas-container">
      <h3>DISPLAY DATA HERE</h3>
      <canvas class="chart-canvas" width="400" height="350"></canvas>
      <div class="test-stat-placeholder"></div>
    </div>

  '''
  events:
    'change .search-form': "_updateSearchText"

  initialize: (options) ->
    {@collection, @$wrapper} = options

    @$form = @$(".search-form")
    @searchText = ""

    @_render()
    @_position()
    @_render_subbers_selection()
    @_render_subber_data()
    @_render_chart()

    @listenTo @collection, 'add', =>
      @_render_subbers_selection()

  _updateSearchText: ->
    @searchText = @$(".search-form").val()

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

  _render_subbers_selection: ->
    subbersPlaceholder = @$(".subbers-placeholder")
    @collection.each (sub) =>
      # if sub.get('server_name').indexOf(@searchText) > 0
      subber_selected = new Main.Views.ChartSubber
        $wrapper: subbersPlaceholder
        model: sub

  _render_subber_data: ->
    dataPlaceholder = @$('.test-stat-placeholder')

    @collection.each (sub) =>
      name = sub.get "server_name"
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
