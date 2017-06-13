selectoptions = '''
  <select>
    <option DISABLED> Choose Chart Type </option>
    <option value="line"> Line Chart </option>
    <option value="bar"> Bar Chart </option>
    <option> Some other Chart </option>
  </select>
'''

class Main.Views.Charts extends Backbone.View

  tagName: "div"
  className: "charts-view row"
  template: _.template '''

    <div class="subbers-container small-11 small-centered columns">
      <form>
        <input type="text" class="search-form" placeholder="Search server">
      </form>
      <div class="small-12 small-centered chart-custom-scroll subbers-placeholder button-group"></div>
    </div>
    <div class="canvas-container small-11 small-centered columns">
      <div class="row">
        <div class="chart-option-bar small-11 small-centered">
          <p> Graph of Active Users </p>
          <i class="ci fi-graph-bar"></i>
        </div>
      </div>
      <div class="chart-area chart-custom-scroll">
        <canvas class="chart-canvas"></canvas>
      </div>
    </div>

  '''
  events:
    'change .search-form': "_updateSearchText"
    'click .ci': "_updateChartType"

  initialize: (options) ->
    {@collection, @$wrapper} = options

    @$form = @$(".search-form")
    @searchText = ""
    @chart_type = 'line'
    @subber_ondisplay = {}

    @reRender()

    # we usually pass in the function directly, no need for an extra bind statement
    # @listenTo @collection, 'add remove', @render_subbers_selection

    @listenTo @collection, 'add remove', =>
      @_render_subbers_selection()
    @listenTo @collection, 'change', =>
      @lineChart.update()

  _updateSearchText: ->
    @searchText = @$(".search-form").val()

  _updateChartType: ->
    # Change Chart type bar
    if @chart_type == 'bar'
      @chart_type = 'line'
    else
      @chart_type = 'bar'

    @lineChart.clear()
    @_render_chart()

  _render_chart: ->
    @$canvas = @$(".chart-canvas")

    @lineChart = new Chart @$canvas,
      type: @chart_type
      options: ChartOptions.line
      data:
        # labels: _.range(@chart_buffer_range)
        labels: []
        datasets: []

  _render_to_chart: (subberModel) ->
    # Create New Data Array and push to Chart dataset
    # Change implementation to {...dataPoints: [{x: "date, y: user_count}, ...]}
    label = subberModel.get('server_alias')
    color = @_randomHex()
    user_count_data = @_get_user_stat subberModel.statistics.toJSON()

    dataset_options = _.clone ChartOptions.dataset
    dataset = _.extend dataset_options,
      label: label
      borderColor: color
      backgroundColor: color
      data: user_count_data

    @lineChart.data.datasets.push dataset
    @lineChart.data.labels = @_get_chart_label subberModel.statistics.toJSON()
    @lineChart.update()

    @listenTo subberModel.statistics, 'change', =>
      console.log "#{subberModel.statistics} has new statistics added!!"

  _get_index_of: (name) ->
    (_.map @lineChart.data.datasets, (set) => set.label).indexOf name

  _get_user_stat: (stats) ->
    return _.reduce stats, (accumulator, stat) ->
      accumulator.push stat.user_count
      accumulator
    , []

  _get_chart_label: (stats) ->
    return _.reduce stats, (accumulator, stat) ->
      accumulator.push moment(stat.date).format('LTS')
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
    # _render_subbers_selection this method is 2 long. Try and split it up into smaller parts
    # If you look at our code base most times you will find functions do very littel i.e _render and _position. We could have done that logic in the same function but we chose to split them up.

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
          @_render_to_chart(subber_selected.model)


  reRender: ->

    @_render()
    @_position()
    @_render_subbers_selection()
    @_render_chart()
