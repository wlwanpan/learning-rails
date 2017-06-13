
class Main.Views.Home extends Backbone.View

  tagName: 'div'
  className: "row align-middle"
  template: _.template '''

  <div class="main-summary-container medium-9 medium-centered columns">
    <div class="row small-up-2 medium-up-3">
      <div class="summary-container column column-block">
        <div><i class="home-i fi-mountains"></i></div>
        <div>Servers Registered: <%- serverRegistered %></div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-torsos"></i></div>
        <div>Total Active Users: <%- totalActiveUsers %></div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-database"></i></div>
        <div>Database Collection: <%- databaseCollection %></div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-loop"></i></div>
        <div>Total Queries: <%- totalQueries %> </div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-trash"></i></div>
        <div>Total Entries Deleted: <%- totalEntriesDeleted %> </div>
      </div>
      <div class="summary-container column column-block">
        <div><i class="home-i fi-calendar"></i></div>
        <div>Last Fetch Called: <%- lastFetchCalled %> </div>
      </div>
    </div>
  </div>

  '''

  initialize: (options) ->
    {@$wrapper, @collection} = options
    @global_store =
      serverRegistered: 0
      totalActiveUsers: 0
      databaseCollection: 0
      totalQueries: 0
      totalEntriesDeleted: 0
      lastFetchCalled: ""

    @_render()

    @listenTo @collection, 'add remove change', =>
      @_update_global_data()
      @_render()

  _get_database_collection: ->
    # get total user_count from all subbers
    return @collection.length + _.reduce @collection.models, (accumulator, subber) ->
      accumulator += subber.statistics.length
      accumulator
    , 0

  _get_user_count: (stats) ->
    return _.reduce stats, (accumulator, stat) ->
      accumulator += stat.user_count
      accumulator
    , 0

  _get_total_active_users: ->

    return _.reduce @collection.models, (accumulator, subber) =>
      if subber.statistics
        accumulator += @_get_user_count subber.statistics.models
        # console.log @_get_user_count subber.statistics.models 
      accumulator
    , 0

  _update_global_data: ->

    @global_store.serverRegistered = @collection.length
    @global_store.databaseCollection = @_get_database_collection()
    @global_store.totalActiveUsers = @_get_total_active_users()

  reRender: ->
    @_render()
    @_position()

  _render: ->
    @$el.html @template @global_store

  _position: ->
    @$wrapper.html @el
