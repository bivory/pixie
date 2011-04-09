Wall = (I) ->
  I ||= {}

  $.reverseMerge I,
    color: Color("beige")
    width: 16
    height: 16
    includedModules: ["Physical"]
    excludedModules: ["Movable"]

  self = GameObject(I)