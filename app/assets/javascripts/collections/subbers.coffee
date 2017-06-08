
class Main.Collections.Subbers extends Backbone.Collection

  model: Main.Models.Subber
  url: "/subbers"

  populate_children: ->
    @each (subber) ->
      subber.populate_stats_collection()
