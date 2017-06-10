
class Main.Views.Home extends Backbone.View

  tagName: 'div'
  className: "row"
  template: _.template '''

  <div class="main-summary-container medium-9 medium-centered columns">
    <div class="row small-up-3 medium-up-3">
      <div class="summary-container column column-block">
        <p>Servers Registered: <%- size %></p>
      </div>
      <div class="summary-container column column-block">
        <p>Total Active Users: </p>
      </div>
      <div class="summary-container column column-block">
        <p>Avg Users per Server: </p>
      </div>
      <div class="summary-container column column-block"> <p>DATA SUMMARY</p> </div>
      <div class="summary-container column column-block"> <p>DATA SUMMARY</p> </div>
      <div class="summary-container column column-block"> <p>DATA SUMMARY</p> </div>
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
