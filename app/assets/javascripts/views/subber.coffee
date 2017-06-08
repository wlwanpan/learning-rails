
class Main.Views.Subber extends Backbone.View
  tagName: 'tr'
  className: 'edit-subber-placeholder'
  template:  _.template '''
    <td><a class="server-edit-button" href="#"><i class="fi-pencil"></i></a></td>
    <td><%- subber_name %></td>
    <td><%- subber_location %></td>
    <td><%- subber_alias %></td>
    <td class="light"><%- moment(created_at).format('MMMM Do YYYY') %></td>
    <td class="light"><%- stats.length %></td>
  '''
  initialize: (options) ->
    { @$wrapper, @model } = options

    @_render()
    @_position()
    @listenTo @model, 'change', => @_render()

  events:
    'click .server-edit-button': "_popEditModal"

  _popEditModal: (e) ->
    e.preventDefault()
    @trigger "edit"

  _render: ->
    # console.log @model.toJSON()
    @$el.html @template @model.toJSON()

  _position: ->
    @$wrapper.append @el
