Player = (I) ->
  I ||= {}

  $.reverseMerge I,
    color: "red"
    width: 10
    height: 50
    density: 1

    startRunImpulse: 100
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
    # Jump
    if I.controller.actionDown "A"
      self.applyImpulse(Point(0, -I.jumpImpulse)) if canJump

    # Run
    log self.body()#, self.body().GetLocalVector()
    runSpeed = if true then I.runImpulse else I.startRunImpulse
    if I.controller.actionDown "right"
      self.applyImpulse(Point(runSpeed, 0))
    if I.controller.actionDown "left"
      self.applyImpulse(Point(-runSpeed, 0))

  self.bind "collision", (other, contact) ->
    console.log contact
    canJump ||= contact?.GetManifold().m_localPlaneNormal.y == 1

    if other.I.class == "Box"
      other.destroy()

  self

