
class Main.Models.Statistic extends Backbone.Model

  defaults:
    data_title: "No title"
    date: moment() # tricky bug.
      #Most times will will store attributes as a string
      # because it is something that should be populated from the server.
      # The server can't send a moment object.
      # Then in the iniitalize function you can init the moment form the date  string attirbute
      # initialize: ->
      #    @_init_moments()
      #
    user_count: 0

  # Also try this in your console.
  # x =  new Main.Models.Statistic
  #  ... wait some time...
  # y =  new Main.Models.Statistic
  # x.get('date').toString() == y.get('date').toString()
  # What do you think it will do?