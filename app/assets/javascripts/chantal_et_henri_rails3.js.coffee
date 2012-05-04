window.CH =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    CH.router = new CH.Routers.Users()
    Backbone.history.start()

$(document).ready ->
#  CH.init()
