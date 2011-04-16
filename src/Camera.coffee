Camera = (I) ->
  I ||= {}

  $.extend I,
    x: 0
    y: 0
    shouldDraw: false
    camera: true
    solid: false
    width: 320
    height: 240
    scale: 1/2

  self = GameObject(I).extend
    draw: (canvas) ->
      return if not I.shouldDraw
      canvas.fillColor "rgba(0, 255, 255, 0.25)"
      canvas.fillRect(0, 0, I.width, I.height)

    aperture: (width, height) ->
      # Getter
      return {width: I.width, height: I.height} if not width? and not height?

      # Passed in something with a width and height?
      if not height?
        canvas = width
        height = canvas.height()
        width = canvas.width()
      I.width = width
      I.height = height

    cameraTransform: ->
      track = I.trackObject?.I
      track or= I
      Matrix.translation(0, 0) # Upper left is the orgin
        .translate(-track.x, -track.y) # To the object being followed
        #.scale(I.scale, I.scale)
        .translate(I.width/2 - track.width/2, I.height/2 - track.height/2) # Center

    zoom: (amount) -> I.scale = amount

    track: (go) ->
      I.trackObject = go
