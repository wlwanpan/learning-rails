
class Main.Views.Home extends Backbone.View

  tagName: 'div'
  className: "row"
  template: _.template '''

  <div class="main-summary-container medium-6 medium-centered columns">
    <div class="row">
      <div class="summary-container small-4 columns">
        <h3>Servers Registered: <%- size %></h3>
      </div>
      <div class="summary-container small-4 columns">
        <h3>Total Active Users: </h3>
      </div>
      <div class="summary-container small-4 columns">
        <h3>Avg Users per Server: </h3>
      </div>
    </div>
    <div class="row">
      <div class="summary-container small-4 columns"> <h3>DATA SUMMARY</h3> </div>
      <div class="summary-container small-4 columns"> <h3>DATA SUMMARY</h3> </div>
      <div class="summary-container small-4 columns"> <h3>DATA SUMMARY</h3> </div>
    </div>
  </div>

  '''

  initialize: (options) ->
    {@$wrapper, @collection} = options
    @_render()

    @listenTo @collection, 'add remove change', =>
      @_render()

  reRender: ->
    @_render()
    @_position()

  _render: ->
    @$el.html @template(size: @collection.length)

  _position: ->
    @$wrapper.html @el
