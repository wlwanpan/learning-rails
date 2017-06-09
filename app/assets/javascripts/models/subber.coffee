
class Main.Models.Subber extends Backbone.Model

  urlRoot: '/subbers' # Set route to Rails.application.routes
  defaults:
    server_name: ""
    server_location: ""
    server_alias: ""
    key: "none"
    created_at: ""

  initialize: (options) ->

    @statistics =
      new Main.Collections.Statistics
        model: Main.Models.Statistic

    @populate_stats()

  populate_stats: ->
    @statistics.reset @get "stats"
    @set 'stats', ''

  toJSON: ->
    statData = @statistics.toJSON()
    output = super
    output.stats = statData
    output
