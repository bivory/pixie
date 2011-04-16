Terrain = (I) ->
  I ||= {}

  $.extend I,
    color: "blue"
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
      canvas.fillColor "rgba(0, 255, 255, 0.25)"
      canvas.fillRect(0, 0, I.width, I.height)

    bounds: (b) ->
