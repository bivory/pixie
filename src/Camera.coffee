Camera = (I) ->
  I ||= {}

  $.extend I,
    x: 0
    y: 0
    camera: true
    solid: false
    width: 320
    height: 240
    scale: 1/2

    debugText: false
    debugDraw: false

  self = GameObject(I).extend
    draw: (canvas) ->

    drawHUD: (canvas) ->
      if I.debugDraw or I.debugText or I.debugged = true
        canvas.clearRect(0, 0, canvas.width(), canvas.height())
        I.debugged = false
      else
        return

      I.debugged = true        

      if I.debugDraw
        bounds = self.viewPortBounds()
        log bounds if I.age < 5
        canvas.fillColor "rgba(255, 0, 0, 0.5)"
        canvas.fillRect(bounds.topLeft.x, bounds.topLeft.y,
                        bounds.bottomRight.x, bounds.bottomRight.y)
      if I.debugText
        bounds = self.viewPortBounds()
        canvas.fillColor "rgba(255, 255, 255, 1)"
        canvas.fillText "Camera width: #{bounds.width} height: #{bounds.height}", 0,10
        canvas.fillText "tx: #{bounds.topLeft.x} ty: #{bounds.topLeft.y}", 0, 20
        canvas.fillText "bx: #{bounds.bottomRight.x} by: #{bounds.bottomRight.y}", 0, 30


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

    ###
      Get the bounding rectangle of the view port.
      NOTE: it does not take into account camera rotations
    ###
    viewPortBounds: () ->
      transform = self.cameraTransform()
      inverse = transform.inverse()
      topLeft = inverse.transformPoint Point(0,0)
      bottomRight = inverse.transformPoint Point(I.width, I.height)
      width = bottomRight.x - topLeft.x
      height = bottomRight.y - topLeft.y
      {topLeft: topLeft, bottomRight: bottomRight, width: width.round(), height: height.round()}
      #Vector3 topLeftCorner = Vector3.Transform(new Vector3(0,0,0),inverseTransform);
      #Vector3 bottomRightCorner = Vector3.Transform(new Vector3(viewport.Width,viewport.Height,0),inverseTransform);
