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
    user_count_data = @_get_user_stat subberModel

    dataset_options = _.clone ChartOptions.dataset
    dataset = _.extend dataset_options,
      label: label
      borderColor: color
      backgroundColor: color
      data: user_count_data

    @lineChart.data.datasets.push dataset
    @lineChart.data.labels = @_get_chart_label subberModel
    @lineChart.update()

  _get_user_stat: (subberModel) ->
    stats = @_model_stats_tojson subberModel
    if stats
      return _.reduce stats, (accumulator, stat) ->
        accumulator.push stat.user_count
        accumulator
      , []

  _get_chart_label: (subberModel) ->
    stats = @_model_stats_tojson subberModel
    if stats
      return _.reduce stats, (accumulator, stat) ->
        accumulator.push moment(stat.date).format('LTS')
        accumulator
      , []

  _model_stats_tojson: (subberModel) ->
    if subberModel && subberModel.statistics
      subberModel.statistics.toJSON()

  _randomHex: ->
    return _.reduce _.range(6), (accumulator, colorCode) ->
      accumulator += '0123456789ABCDEF'[Math.floor(Math.random() * 16)]
      accumulator
    , "#"

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

        indexOfModel = @_get_index_of subber_selected
        if indexOfModel > -1
          @_remove_subber_ondisplay indexOfModel
          @stopListening subber_selected
        else

          @_render_to_chart subber_selected.model
          @listenTo subber_selected, 'reRender', () =>
            newIndex = @_get_index_of subber_selected
            # @_remove_subber_ondisplay indexOfModel
            # @_render_to_chart subber_selected.model
            newDataset = @_get_user_stat subber_selected.model
            oldDataset = @lineChart.getDatasetMeta(newIndex).data
            dataToModify = @lineChart.data.datasets[newIndex].data
            # console.log @lineChart.getDatasetMeta(newIndex).data.length
            diffArr = @_get_diff oldDataset, newDataset
            if diffArr && diffArr.length > 3
              _.each diffArr, (index) =>
                dataToModify.push newDataset[index]
                # Add push new labels
              # @lineChart.data.labels.shift()
              @lineChart.update()
              dataToModify.shift()

  _get_diff: (oldArr, newArr) ->

    if oldArr && newArr
      outArr = []
      oldArrLength = oldArr.length
      newArrLength = newArr.length
      diff = newArrLength - oldArrLength
      if diff > 0
      #   _.range(newArrLength - diff, newArrLength - 1).each (index) =>
      #     outArr.push newArr[index]
        return _.range(newArrLength - diff, newArrLength - 1)

  _get_index_of: (name) ->
    (_.map @lineChart.data.datasets, (set) => set.label).indexOf name.model.get('server_alias')

  _remove_subber_ondisplay: (index) ->
    @lineChart.data.datasets.splice index, 1

  _render: ->
    @$el.html @template()

  _position: ->
    @$wrapper.html @el

  reRender: ->

    @_render()
    @_position()
    @_render_subbers_selection()
    @_render_chart()
