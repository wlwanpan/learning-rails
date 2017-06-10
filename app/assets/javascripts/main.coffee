
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
    '': '_home'
    'database': '_displayDatabase'
    'charts': '_displayCharts'

  initialize: ->

    @subbers_list = new Main.Collections.Subbers
    @$display_wrapper = $("#display-wrapper")

    @navigation_items = new Main.Views.NavigationItems
      $wrapper: $("#navigation-wrapper")

    @home_display = new Main.Views.Home
      collection: @subbers_list
      $wrapper: @$display_wrapper

    @index_display = new Main.Views.Index
      collection: @subbers_list
      $wrapper: @$display_wrapper

    # @chart_display = new Main.Views.Charts
    #   collection: @subbers_list
    #   $wrapper: @$display_wrapper

  _home: ->
    @_switchWindow () =>
      # console.log @home_display
      @home_display.reRender()

  _displayDatabase: ->
    @_switchWindow () =>
      console.log @index_display
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
      # @chart_display.reRender()

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
