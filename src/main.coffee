window.engine = Engine
  ambientLight: 0.05
  canvas: $("canvas").powerCanvas()
  includedModules: ['Box2D']
  PHYSICS_DEBUG_DRAW: true

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
  flicker: false
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

# Camera
camera = engine.add
  class: "Camera"

# Player
player1 = engine.add
  class: "Player"
  player: 0
  x: [64, 256, 320, 512].rand()
  y: -16

camera.track player1
# Size the camera view to the window
camera.aperture window.engine.canvas()

engine.start()

engine.bind "update", ->
  # Find the players
  playerInfo = {}
  engine.eachObject (o) ->
    # Controller Input
    playerInfo[o.I.controller] = o.I if o.I.controller? 

    # Camera Tracking
    engine.cameraTransform o.cameraTransform() if o.I.camera

