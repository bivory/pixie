Player = (I) ->
  I ||= {}

  $.reverseMerge I, Actor()

  I.controller = CONTROLLERS[I.player] if I.player

  mass = I.width * I.height
  canJump = false

  physics = ->
    if I.controller?.actionDown "A"
      self.applyImpulse(Point(0, -mass/10)) if canJump
    if I.controller?.actionDown "right"
      self.applyImpulse(Point(mass/10, 0))
    if I.controller?.actionDown "left"
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

