WallJumper = (I, self) ->
  $.reverseMerge I,
    wallJump: true
    wallClass: ["Wall"]
    canJump: false

  I.wallClass = [I.wallClass] if typeof I.wallClass is "string"

  self.bind "collision", (other, contact) ->
    return if not I.wallJump
    I.canJump or= contact.GetManifold().m_localPlaneNormal.y == 1

    # Wall Jump
    if $.inArray(other.I.class, I.wallClass) isnt -1
      I.canJump or= contact.GetManifold().m_localPlaneNormal.x == 1 or
        contact.GetManifold().m_localPlaneNormal.x == -1
