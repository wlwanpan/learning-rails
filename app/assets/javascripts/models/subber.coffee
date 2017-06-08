
class Main.Models.Subber extends Backbone.Model

  urlRoot: '/subbers' # Set route to Rails.application.routes

  defaults:

    subber_name: ""
    subber_location: ""
    subber_alias: ""
    created_at: ""

  initialize: (options) ->

    @stats_collection =
      new Main.Collections.Stats
        model: Main.Models.Stat

    @populate_stats_collection()

  populate_stats_collection: ->
    @stats_collection.reset @get "stats"
    @set 'stats', ''

  toJSON: ->
    statData = @stats_collection.toJSON()
    output = super
    output.stats = statData
    output
