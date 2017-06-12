
class Main.Views.Home extends Backbone.View

  tagName: 'div'
  className: "row align-middle"
  template: _.template '''

  <div class="main-summary-container medium-9 medium-centered columns">
    <div class="row small-up-2 medium-up-3">
      <div class="summary-container column column-block">
        <div><i class="home-i fi-mountains"></i></div>
        <div>Servers Registered: <%- size %></div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-torsos"></i></div>
        <div>Total Active Users: <%- totalUsers %></div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-database"></i></div>
        <div>Database Collection: </div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-loop"></i></div>
        <div>Total Queries: </div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-trash"></i></div>
        <div>Total Entries Deleted: </div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-calendar"></i></div>
        <div>Last Fetch Called: </div>
      </div>
    </div>
  </div>

  '''

  initialize: (options) ->
    {@$wrapper, @collection} = options
    @_render()

    @listenTo @collection, 'add remove change', =>
      @_render()

  _get_total_user: ->
    # get total user_count from all subbers
    return _.reduce @collection.models, (accumulator, subber) ->
      accumulator += subber.statistics.length
      accumulator
    , 0

  reRender: ->
    @_render()
    @_position()

  _render: ->
    @$el.html @template(size: @collection.length, totalUsers: @_get_total_user())

  _position: ->
    @$wrapper.html @el
