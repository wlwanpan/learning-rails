
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
    '': '_home' # home
    'database': '_displayDatabase' # Our own convention, but when the function is tirggered by an event we consider it public so we don't prefix _
    'charts': '_displayCharts' # display_charts

  initialize: ->

    @subbers_list = new Main.Collections.Subbers
    @$display_wrapper = $("#display-wrapper")

    # even small lines of code like this I would split into their own functions.
    # In a big code base it is easier to read method names vs. logic
    #
    #  @_render_nav_items()
    #  @_render_home_screen()
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
      @home_display.reRender() # we use snake case to stay consistent with ruby reRender vs. re_render: ->

  _displayDatabase: ->
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
      # @chart_display.reRender()

  _switchWindow: (func) ->
    #  rather than func, id like to see a name that is more descriptive of what the callback does.
    # In your case it would be something like `after_complete`

    @$display_wrapper.velocity(
      { opacity: 0 },
      duration: 200,
      easing: "easeInSine",
      complete: =>
        func.call() # usually I will only use .call or .apply if I want to change the functions context

        @$display_wrapper.velocity("reverse")
    )



$(document).ready -> Main.initialize()
