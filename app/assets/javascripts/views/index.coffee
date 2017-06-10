class Main.Views.Index extends Backbone.View

  updateTickRate: 1500
  tagName: "div"
  className: "row"
  template: _.template '''

    <div class="register-subber-placeholder"></div>
    <div class="index-main-container medium-12 medium-centered">
      <table class="unstriped table-scroll">
        <thead>
          <tr>
            <th width="2"></th>
            <th width="250"><i class="fa fi-torso"/><span class="fa">  Server name</span></th>
            <th width="250"><i class="fa fi-marker"/><span class="fa">  Server location</span></th>
            <th width="250"><i class="fa fi-results-demographics"/><span class="fa">  Server alias</span></th>
            <th><i class="fa fi-clock"/><span class="fa">  Registered on</span></th>
            <th witdh="5"><i class="fa fi-male-female"/><span class="fa">  Count</span></th>
          </tr>
        </thead>
        <tbody class="place-subber-here"></tbody>
      </table>
    </div>

  '''

  initialize: (options) ->
    { @$wrapper, @collection } = options
    #@$register_subber_placeholder = @$(".register-subber-placeholder")
    @_initTick()
    @listenTo @collection, 'add remove', =>
      @_update_display()

  reRender: ->
    @_update_display()
    @_position()

  _update_display: ->
    @_render()
    @_render_items()
    new Main.Views.RegisterSubber
      collection: @collection
      $wrapper: @$(".register-subber-placeholder")

  _render: ->
    @$el.html @template(size: @collection.length)

  _render_items: ->
    @collection.each (model) =>
      @_render_item model

  _render_item: (model) ->
    subber_view = new Main.Views.Subber
      model: model
      $wrapper: @$(".place-subber-here")

    @listenTo subber_view, "edit", () =>
      model = subber_view.model
      index = @collection.indexOf model
      @_edit_subber
        index: index
        model: subber_view.model

  _position: ->
    @$wrapper.html @el

  _initTick: ->

    @_render()
    @_render_items()
    @_position()

    @updateTick = setInterval () =>

      prevCollection = @collection.clone()
      @collection.fetch success: =>
        @collection.populate_children()
    , @updateTickRate

  _edit_subber: (options) ->
    {index, model} = options

    if @modalPopUp?
      @modalPopUp.unbind().remove()

    @modalPopUp = new Main.Views.EditSubber
      model: model
      $wrapper: @$(".place-subber-here > tr:nth-child("+(index+1)+")")
