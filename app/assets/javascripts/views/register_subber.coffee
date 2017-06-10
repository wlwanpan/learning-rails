
class Main.Views.RegisterSubber extends Backbone.View

  tagName: 'form'
  className: "register-subber-form custom"
  template: _.template '''

    <div class="row align-middle">
      <div class="medium-4 medium-centered">
        <input class="server_name" type="text" placeholder="Enter server name [min: 5 char]">
        <input class="server_location" type="text" placeholder="Enter server location [min: 5 char]">
        <input class="server_alias" type="text" placeholder="Enter server alias [min: 5 char]">
        <select class="server_key">
          <option DISABLED> Choose server domain </option>
          <option value="us"> US </option>
          <option value="ca"> CA </option>
          <option value="ubc"> UBC </option>
        </select>
        <a class="form-submit button expanded hollow" href="#"> REGISTER NEW SERVER </a>
      </div>
    </div>

  '''
  # Set User Events to View
  events:
    'click a.form-submit': "_sendRegisterSubber"
  # Ref and Hash data to POST to back-end
  _sendRegisterSubber: ->
    # Returns a hash if input is not empty else {}
    serverKeySelected = @$(".server_key option:selected").val()
    input_data_hash = @_getInputData()
    # Check if datahash not empty and adds the entry AT index 0
    if ! _.isEmpty input_data_hash
      input_data_hash.key = serverKeySelected
      @collection.create input_data_hash,
        wait: true
        at: 0
        success: => @_successHandler()
        error: => @_errorHandler()
    else
      alert "NO DATA ADDED"

  _getInputData: ->
    input_data_field = ["server_name", "server_location", "server_alias"]

    return _.reduce input_data_field, (accumulator, input_tag) ->

      value = @$("input.#{input_tag}").val()
      if value.length != 0
        accumulator[input_tag] = value
        @$("input.#{input_tag}").val("")

      accumulator
    , {}

  initialize: (options) ->
    {@$wrapper} = options

    @_render()
    @_position()

  _render: ->
    @$el.html @template()

  _position: ->
    @$wrapper.html @el

  _successHandler: ->
    alert "Data successfully saved"

  _errorHandler: ->
    alert "Error adding new subber to Db"
