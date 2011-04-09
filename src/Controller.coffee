Controller = (actions) ->
  actions ||=
    up: "up"
    right: "right"
    down: "down"
    left: "left"
    A: "home"
    B: "end"
    C: "pageup"
    D: "pagedown"

  actionDown: (triggers...) ->
    triggers.inject false, (down, action) ->
      down || keydown[actions[action]]

CONTROLLERS = []
[{
  up: "up"
  right: "right"
  down: "down"
  left: "left"
  A: "a"
  B: "s"
  C: "d"
  D: "f"
}].each (actions, i) ->
  CONTROLLERS[i] = Controller(actions)
