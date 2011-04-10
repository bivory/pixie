Player = (I) ->
  I ||= {}

  $.reverseMerge I,
    color: "red"
    width: 10
    height: 50
    density: 1

    includedModules: ["WallJumper"]
    wallJump = true
    wallClass: "People"

    startRunImpulse: 100
    runImpulse: 10
    jumpImpulse: 150

  I.controller = CONTROLLERS[I.player] if I.player? 
  canJump = false

  self = Actor(I).extend
    before:
      update: ->
        physics()
        canJump = false

  physics = ->
    # Jump
    if I.controller.actionDown "A"
      self.applyImpulse(Point(0, -I.jumpImpulse)) if canJump

    # Run
    lv = self.body().GetLinearVelocity()
    runSpeed = if lv.x isnt 0 then I.runImpulse else I.startRunImpulse
    if I.controller.actionDown "right"
      self.applyImpulse(Point(runSpeed, 0))
    if I.controller.actionDown "left"
      self.applyImpulse(Point(-runSpeed, 0))

  self.bind "collision", (other, contact) ->
    canJump or= contact.GetManifold().m_localPlaneNormal.y == 1

    if other.I.class == "Box"
      other.destroy()

  self

