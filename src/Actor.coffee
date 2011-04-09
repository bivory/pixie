Actor = (I) ->
  I ||= {}

  $.reverseMerge I,
    color: "blue"
    opaque: true # Dynamic lights
    # Collisions:
    density: 0.5
    dynamic: true # Movable Collision
    mobile: true # Updates the sprite to match the x,y of Collision box
    includedModules: ["Physical"]
    excludedModules: ["Movable"]
    width: 100
    height: 100

  self = GameObject I
