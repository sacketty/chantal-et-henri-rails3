window.CH =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  time: 6000
  pics: [
    "ch1_240x180.jpg"
    "ch1_240x180.jpg"
    "baie_somme_2010 053.jpg"
    "baie_somme_2010 144.jpg"
    "baie_somme_2010 059.jpg"
    "baie_somme_2010 176.jpg"
    "p1010363.jpg"
    "p1010363.jpg"
    "p1010387.jpg"
    "p1010391.jpg"
    "p1010391.jpg"
    "p1010505.jpg"
    "p1010505.jpg"
    "vlg-003-001.jpg"
  ]
  test: ->
    console.log "this is the test function"
  showImage: (img) ->
    src = "/assets/cycle/#{img}"
    console.log "Showing image -> #{src}"
    $("#img_holder").html("<img src='#{src}' alt=''/>")
  rotateImage: ->
    num=Math.floor(Math.random()*CH.pics.length);
    if(num==CH.temp)
      CH.rotateImage(CH.temp)
    else
      CH.temp=num
      CH.showImage(CH.pics[num])
      setTimeout =>
        CH.rotateImage()
      , CH.time
  init2: ->
    CH.router = new CH.Routers.Users()
    Backbone.history.start()

$(document).ready ->
  CH.rotateImage()
#  CH.init()
