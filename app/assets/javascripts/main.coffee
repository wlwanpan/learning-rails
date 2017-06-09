
window.Main =

  Models: {}
  Collections: {}
  Views: {}
  Routes: {}

  initialize: ->

    @Router = new Main.Router()
    Backbone.history.start
      pushState: true
      root: '/'

class Main.Router extends Backbone.Router

  routes:
    '': 'index'
    'register': '_registerSubberForm'
    'stats': '_displayCharts'

  initialize: ->

    @subbers_list = new Main.Collections.Subbers
    @$display_wrapper = $("#display-wrapper")

    @navigation_items = new Main.Views.NavigationItems
      $wrap: $("#navigation-wrapper")

    @index_display = new Main.Views.Index
      collection: @subbers_list
      $wrap: @$display_wrapper

  index: ->
    @_switchWindow () =>
      @index_display.reRender()

  _registerSubberForm: ->
    # Assign View to Model and Location in index html
    @_switchWindow () =>
      new Main.Views.RegisterSubber
        collection: @subbers_list
        $wrapper: @$display_wrapper

  _displayCharts: ->

    @_switchWindow () =>
      new Main.Views.Charts
        collection: @subbers_list
        $wrapper: @$display_wrapper

  _switchWindow: (func) ->

    @$display_wrapper.velocity {
      opacity: 0
    }, {
      duration: 200,
      easing: "easeInSine",
      complete: =>
        func.call()
        @$display_wrapper.velocity("reverse")
    }

$(document).ready -> Main.initialize()
