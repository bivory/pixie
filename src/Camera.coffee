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
      track = I.trackObject 
      track or= self
      screenCenter = self.center()
      Matrix.translation(0, 0) # Upper left is the orgin
        .translate(-track.I.x, -track.I.y) # To the object being followed
        #.scale(I.scale, I.scale)
        .translate(screenCenter.x, screenCenter.y) # Center

    zoom: (amount) -> I.scale = amount

    track: (go) ->
      I.trackObject = go
