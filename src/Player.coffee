Player = (I) ->
  I ||= {}

  $.reverseMerge I,
    color: "red"
    width: 10
    height: 50
    density: 1

    runImpulse: 10
    jumpImpulse: 30

  I.controller = CONTROLLERS[I.player] if I.player? 

  self = Actor(I).extend
    before:
      update: ->
        physics()
        canJump = false

  canJump = false

  physics = ->
    if I.controller.actionDown "A"
      console.log 'test'
      self.applyImpulse(Point(0, -I.jumpImpulse)) if canJump
    if I.controller.actionDown "right"
      self.applyImpulse(Point(I.runImpulse, 0))
    if I.controller.actionDown "left"
      self.applyImpulse(Point(-I.runImpulse, 0))

  self.bind "collision", (other, contact) ->
    console.log contact
    canJump ||= contact.GetManifold().m_localPlaneNormal.y == 1

    if other.I.class == "Box"
      other.destroy()

  self

