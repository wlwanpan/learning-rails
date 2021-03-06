
webicon = '''
  <a href="#" data-path="charts" class="nav_item"><i class="fi fi-web"></i></a>
'''

class Main.Views.NavigationItems extends Backbone.View

  template: _.template '''

    <a href="#" data-path="" class="nav_item"><i class="fi fi-home"></i></a>
    <a href="#" data-path="database" class="nav_item"><i class="fi fi-list-thumbnails"></i></a>
    <a href="#" data-path="charts" class="nav_item"><i class="fi fi-graph-bar"></i></a>

  '''
  events:
    'click a.nav_item': "action_select"

  action_select: (e) ->

    e.preventDefault()
    $nav_item = @$(e.currentTarget)
    path = $nav_item.data('path')

    Main.Router.navigate path, trigger: true

  initialize: (options) ->

    {@$wrapper} = options

    @_render()
    @_position()

  _render: ->
    @$el.html @template()

  _position: ->
    @$wrapper.html @el
