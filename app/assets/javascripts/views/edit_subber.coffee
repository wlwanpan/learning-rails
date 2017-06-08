
class Main.Views.EditSubber extends Backbone.View

  tagName: "tr"
  className: "editing-row"
  template: _.template '''
    <td class="cancel-row">
      <div><a class="remove-button" href="#"><i class="fi-x"></i></a></div>
    </td>
    <td>
      <div><input class="server_name" type="text" placeholder=<%- server_name %>></div>
    </td>
    <td>
      <div><input class="server_location" type="text" placeholder=<%- server_location %>></div>
    </td>
    <td>
      <div><input class="server_alias" type="text" placeholder=<%- server_alias %>></div>
    </td>
    <td>
      <div><a href="#" class="edit-button button hollow expanded"> Submit </a></div>
    </td>
    <td>
      <div><a href="#" class="delete-button button hollow expanded alert"> Delete </a></div>
    </td>
  '''

  events:
    'click a.edit-button': "_submit"
    'click a.delete-button': "_delete"
    'click a.remove-button': "_remove_el"

  _submit: ->

    input_data_hash = @_getData()
    @model.set input_data_hash
    if ! _.isEmpty input_data_hash
      # @model.save @model.as_json_for_save(),
      @model.save input_data_hash, ## <========== TO CHANGE TO ADD COLLECTION DATA SAVE
        wait: true
        success: =>
          console.log "successfully updated: #{@model.get("server_name")}"
          # @model.init_stat_collection()
          @_remove_el()
        error: =>
          alert "Couldnt not save changes to database"
    else
      alert "Invalid Data"

  _delete: ->

    @$el.velocity {
      opacity: 0
    }, {
      duration: 500,
      easing: "easeInSine",
      complete: =>
        @model.destroy
          success: -> alert "Entry successfully destroyed"
          error: -> alert "error in destroying occured"
    }

  _getData: ->
    input_data_field = ["server_name", "server_location", "server_alias"]
    return _.reduce input_data_field, (accumulator, input_tag) ->

      value = @$("input.#{input_tag}").val()
      if value.length != 0
        accumulator[input_tag] = value
      accumulator
    , {}

  initialize: (options) ->
    { @$wrapper, @model } = options
    @_render()
    @_position()
    @_animateEntry()

  _render: ->
    @$el.html @template @model.toJSON()

  _position: ->
    @$wrapper.after @el

  _remove_el: ->
    @$el.velocity {opacity: 0}, {
      duration: 500,
      complete: =>
        @$el.unbind().remove()
    }

  _animateEntry: ->

    @$el.velocity {
      opacity: [1, 0]
    }, {
      duration: 500,
      easing: "easeInSine"
    }
