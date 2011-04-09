Actor = (I) ->
  I ||= {}

  $.reverseMerge I,
    color: "blue"
    density: 0.5
    opaque: true # Dynamic lights
    dynamic: true # Collision
    mobile: true # Collision
    width: 48
    height: 48
    includedModules: ["Physical"]
    excludedModules: ["Movable"]
    width: 100
    height: 100

  mass = I.width * I.height
  canJump = false

  physics = ->
    if keydown.space
      self.applyImpulse(Point(0, -mass/10)) if canJump
    if keydown.right
      self.applyImpulse(Point(mass/10, 0))
    if keydown.left
      self.applyImpulse(Point(-mass/10, 0))

  self = GameObject(I).extend
    before:
      update: ->
        physics()
        canJump = false
  ###
  self.bind "collision", (other, contact) ->
    canJump ||= contact.GetManifold().m_localPlaneNormal.y == 1

    if other.I.class == "Box"
      other.destroy()
  ###

  self

