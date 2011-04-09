window.engine = Engine
  ambientLight: 0.05
  canvas: $("canvas").powerCanvas()
  includedModules: ['Box2D']

# Add a light
engine.add
  class: "Light"
  x: 50
  y: 50
  color: "#F00"
  width: 100
  height: 100
  radius: 1000
  intensity: 0.5
  flicker: true
  flickerOffChance: 0.10
  flickerOnChance: 0.30

# Walls
engine.add
  class: "Wall"
  x: 0
  y: 0
  width: 640

engine.add
  class: "Wall"
  x: 0
  y: 480 - 16
  width: 640

engine.add
  class: "Wall"
  x: 0
  y: 0
  height: 480

engine.add
  class: "Wall"
  x: 640 - 16
  y: 0
  height: 480

# Player
engine.add
  class: "Actor"
  player: 0
  x: [64, 256, 320, 512].rand()
  y: -16




engine.start()

engine.bind "update", ->
  # Find the players
  playerInfo = {}
  engine.eachObject (o) ->
    if o.I.controller? 
      playerInfo[o.I.controller] = o.I
