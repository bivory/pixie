Terrain = (I) ->
  I ||= {}

  $.reverseMerge I,
    color: "green"
    terrain: true
    #opaque: true # Dynamic lights
    x: 0
    y: 0
    width: 320
    height: 240
    includedModules: ["Physical"]
    excludedModules: ["Movable"]
    solid: true
    friction: 0.7
    density: 0.5

  self = GameObject(I).extend
    draw: (canvas) ->
      canvas.fillColor "rgba(0, 255, 255, 1)"
      canvas.fillRect(I.x, I.y, I.width, I.height)

    bounds: (b) ->
