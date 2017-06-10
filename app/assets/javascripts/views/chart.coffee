
arrow = '''
  <i class="chart-arrow fi-arrow-left"/>
'''

class Main.Views.Charts extends Backbone.View

  tagName: "div"
  className: "charts-view row"
  template: _.template '''

    <div class="subbers-container small-4 medium-3 columns">
      <h2>CHART</h2>
      <select>
        <option DISABLED> Choose Chart Type </option>
        <option value="line"> Line Chart </option>
        <option value="bar"> Bar Chart </option>
        <option> Some other Chart </option>
      </select>
      <form>
        <input type="text" class="search-form" placeholder="Search server">
      </form>
      <div class="subbers-placeholder"></div>
    </div>
    <div class="canvas-container">
      <h3>DISPLAY DATA HERE</h3>
      <canvas class="chart-canvas" width="800px" height="600px"></canvas>
      <div class="test-stat-placeholder"></div>
    </div>

  '''
  events:
    'change .search-form': "_updateSearchText"
    'change select': "_updateChartType"

  initialize: (options) ->
    {@collection, @$wrapper} = options

    @$form = @$(".search-form")
    @searchText = ""
    @chart_type = 'line'

    # @_render()
    # @_position()
    # @_render_subbers_selection()
    # @_render_chart()
    @reRender()
    console.log @$(".charts-view")

    @listenTo @collection, 'add', =>
      @_render_subbers_selection()

  _updateSearchText: ->
    @searchText = @$(".search-form").val()

  _updateChartType: ->
    @chart_type = @$("select option:selected").val()
    @_render_chart()

  _render_chart: () ->
    temp_x_axis = _.range(15)
    @$canvas = @$(".chart-canvas")
    @$canvas.width  = @$canvas.offsetWidth;
    @lineChart = new Chart @$canvas,
      type: @chart_type
      options:
        title:
          display: true
          text: "Linear chart of active users"
        legend:
          position: 'right'
        animationEasing: 'easeOutElastic'
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
        datasets: [{
          label: 'SAMPLE DATA'
          fill: false
          borderColor: '#000000'
          data: [20, 30, 80, 20, 40, 10]
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

  _get_index_of: (name) ->
    (_.map @lineChart.data.datasets, (set) => set.label).indexOf name

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

        indexModel = @_get_index_of subber_selected.model.get('server_alias')
        if indexModel > -1
          @lineChart.data.datasets.splice indexModel, 1
        else
          @_add_to_chart(subber_selected.model)
        @lineChart.update()

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

  reRender: ->

    @_render()
    @_position()
    @_render_subbers_selection()
    @_render_chart()
