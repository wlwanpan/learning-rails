
class Main.Models.Subber extends Backbone.Model

  urlRoot: '/subbers' # Set route to Rails.application.routes
  defaults:
    server_name: ""
    server_location: ""
    server_alias: ""
    key: "wonderland"
    created_at: ""

  initialize: (options) ->

    @statistics =
      new Main.Collections.Statistics
        model: Main.Models.Statistic

    @populate_stats()

  populate_stats: ->
    # Populate @statistics collection for each subber
    @statistics.reset @get "statistics"
    # reset statistics object to empty string
    @set 'statistics', ''

  toJSON: ->
    statsData = @statistics.toJSON()
    output = super
    output.statistics = statsData
    output
