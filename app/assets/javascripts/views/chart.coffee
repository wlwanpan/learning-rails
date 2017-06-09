
class Main.Views.Charts extends Backbone.View

  tagName: "div"
  className: "charts-view row"
  template: _.template '''

    <div class="subbers-container small-4 medium-3 columns">
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
      <canvas class="chart-canvas" width="600px" height="400px"></canvas>
      <div class="test-stat-placeholder"></div>
    </div>

  '''
  events:
    'change .search-form': "_updateSearchText"

  initialize: (options) ->
    {@collection, @$wrapper} = options

    @$form = @$(".search-form")
    @modelArrToDisplay = []
    @searchText = ""

    @_render()
    @_position()
    @_render_subbers_selection()
    # @_render_subber_data()
    @_render_chart()

    @listenTo @collection, 'add', =>
      @_render_subbers_selection()

  _updateSearchText: ->
    @searchText = @$(".search-form").val()

  _render_chart: () ->
    temp_x_axis = _.range(10)
    @$canvas = @$(".chart-canvas")
    @$canvas.width  = @$canvas.offsetWidth;
    @lineChart = new Chart @$canvas,
      type: 'line'
      options:
        tooltipYPadding: 16
        tooltipCornerRadius: 0
        animationEasing: "easeOutBounce"
        responsive: true
        scaleFontSize: 50
        scales:
          xAxes: [{
            gridLines:
              display:true
          }]
          yAxes: [{
            gridLines:
              display:true
          }]
      data:
        labels: temp_x_axis
        fill: false
        borderDash: []
        datasets: [{
          label: 'TEST1'
          fill: false
          borderColor: '#000000'
          data: [20, 30, 80, 20, 40, 10]
        }, {
          label: 'TEST2'
          fill: false
          data: [60, 10, 40, 30, 80, 30]
        }]

  _add_to_chart: (subberModel) ->

    # Create New Chart with data
    label = subberModel.get('server_alias')
    color = @_randomHex()
    user_count_data = @_get_user_stat subberModel.statistics.toJSON()

    dataset =
      label: label
      fill: false
      borderColor: color
      data: user_count_data
    # @lineChart.data.datasets[0].data.push Math.floor((Math.random() * 100));
    @lineChart.data.datasets.push dataset
    # console.log dataset

    @lineChart.update()

  _get_user_stat: (stats) ->
    return _.reduce stats, (accumulator, stat) ->
      accumulator.push stat.user_count
      accumulator
    , []

  _randomHex: ->
    return _.reduce _.range(6), (accumulator, colorCode) ->
      accumulator += '0123456789ABCDEF'[Math.floor(Math.random() * 16)]
      accumulator
    , "#"

  _render: ->
    @$el.html @template()

  _position: ->
    @$wrapper.html @el

  _render_subbers_selection: ->
    subbersPlaceholder = @$(".subbers-placeholder")
    subbersPlaceholder.html ""
    @collection.each (sub) =>
      # if sub.get('server_name').indexOf(@searchText) > 0
      subber_selected = new Main.Views.ChartSubber
        $wrapper: subbersPlaceholder
        model: sub

      # Add listen event to update subber chart to display
      @listenTo subber_selected, 'checked', () =>

        indexModel = @modelArrToDisplay.indexOf(subber_selected.model)
        if indexModel > -1
          @modelArrToDisplay.splice indexModel, 1
        else
          @modelArrToDisplay.push subber_selected.model
          @_add_to_chart(subber_selected.model)


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
