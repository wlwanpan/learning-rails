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

    <div class="subbers-container small-8 small-centered columns">
      <form>
        <input type="text" class="search-form" placeholder="Search server">
      </form>
      <div class="small-8 small-centered chart-custom-scroll subbers-placeholder button-group"></div>
    </div>
    <div class="canvas-container small-11 small-centered columns">
      <div class="row">
        <div class="chart-option-bar small-11 small-centered">
          <p> Linear Graph of Active Users </p>
          <i class="ci fi-graph-bar"></i>
        </div>
      </div>
      <canvas class="chart-canvas"></canvas>
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

    @reRender()

    @listenTo @collection, 'add remove', =>
      @_render_subbers_selection()

  _updateSearchText: ->
    @searchText = @$(".search-form").val()

  _updateChartType: ->
    # @chart_type = @$("select option:selected").val()
    if @chart_type == 'bar'
      @chart_type = 'line'
    else
      @chart_type = 'bar'

    @lineChart.clear()
    @_render_chart()

  _render_chart: () ->
    @$canvas = @$(".chart-canvas")

    @lineChart = new Chart @$canvas,
      type: @chart_type
      options: ChartOptions.line
      data:
        labels: _.range(15)
        datasets: []

  _add_to_chart: (subberModel) ->
    # Create New Chart with data
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
    @lineChart.update()
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

  reRender: ->

    @_render()
    @_position()
    @_render_subbers_selection()
    @_render_chart()
