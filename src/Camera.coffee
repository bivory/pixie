Camera = (I) ->
  I ||= {}

  $.reverseMerge I,
    x: 0
    y: 0
    camera: true
    solid: false
    width: 320
    height: 240
    scale: 1
    debugText: false
    debugDraw: false

  self = GameObject(I).extend
    draw: (canvas) -> return

    drawHUD: (canvas) ->
      if I.debugDraw or I.debugText or I.debugged
        canvas.clearRect(0, 0, canvas.width(), canvas.height())
        I.debugged = false
      else
        return

      I.debugged = true        

      if I.debugDraw
        bounds = self.viewPortBounds()
        canvas.fillColor "rgba(255, 0, 0, 0.5)"
        canvas.fillRect(bounds.topLeft.x, bounds.topLeft.y,
                        bounds.bottomRight.x, bounds.bottomRight.y)
      if I.debugText
        bounds = self.viewPortBounds()
        track = I.trackObject 
        canvas.fillColor "rgba(255, 255, 255, 1)"
        canvas.fillText "Camera width: #{bounds.width} height: #{bounds.height}", 0,10
        canvas.fillText "ux: #{bounds.topLeft.x} uy: #{bounds.topLeft.y}", 0, 20
        canvas.fillText "bx: #{bounds.bottomRight.x} by: #{bounds.bottomRight.y}", 0, 30
        canvas.fillText "tx: #{track.I.x} ty: #{track.I.y}", 0, 40
        x = (bounds.bottomRight.x - bounds.topLeft.x) / 2 + bounds.topLeft.x
        y = (bounds.bottomRight.y - bounds.topLeft.y) / 2 + bounds.topLeft.y
        canvas.fillText "cx: #{x} cy: #{y}", 0, 50

      return

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
      t = track.I.transform.inverse().translate(App.width/2, App.height/2)
      console.log t
      t

    zoom: (amount) -> I.scale = amount

    track: (go) -> I.trackObject = go

    #
    # Get the bounding rectangle of the view port.
    # NOTE: it does not take into account camera rotations
    #
    viewPortBounds: () ->
      transform = self.cameraTransform()
      inverse = transform.inverse()
      topLeft = inverse.transformPoint Point(0,0)
      bottomRight = inverse.transformPoint Point(I.width, I.height)
      width = bottomRight.x - topLeft.x
      height = bottomRight.y - topLeft.y
      {topLeft: topLeft, bottomRight: bottomRight, width: width.round(), height: height.round()}

  $.reverseMerge I, {trackObject: self}
  self
