Terrain = (I) ->
  I ||= {}

  $.reverseMerge I,
    terrain: true
    color: "green"
    x: 0
    y: 0
    width: 320
    height: 240
    includedModules: ["Physical"]
    excludedModules: ["Movable"]
    solid: true
    friction: 0.7
    density: 0.5

  I.bounds = {
    topLeft: {x: I.x, y: I.y}
    bottomRight: {x: I.x + I.width, y: I.y + I.height}
    width: I.width
    height: I.height
  }

  self = GameObject(I).extend
    draw: (canvas) ->
      canvas.fillColor I.color
      x = I.bounds.topLeft.x
      y = I.bounds.bottomRight.y
      width = I.bounds.width
      height = I.bounds.height
      canvas.fillRect(x, y, width, height)

    bounds: (b) -> I.bounds = b
