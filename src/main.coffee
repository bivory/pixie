window.engine = Engine
  ambientLight: 0.05
  canvas: $("canvas").powerCanvas()
  includedModules: ['Box2D']
  #PHYSICS_DEBUG_DRAW: true

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

# Camera
camera = engine.add
  class: "Camera"

# Player
player1 = engine.add
  class: "Player"
  player: 0
  x: [64, 256, 320, 512].rand()
  y: -16

# Terrain
terrain = engine.add
  class: "Terrain"
  x: 0
  y: window.engine.canvas().height()
  width: window.engine.canvas().width()
  height: 240

camera.track player1
camera.aperture window.engine.canvas() # Size the camera view to the window

engine.start()

engine.bind "update", ->
  # Find the players
  playerInfo = {}
  engine.eachObject (o) ->
    # Controller Input
    playerInfo[o.I.controller] = o.I if o.I.controller? 

    # Camera Tracking
    engine.cameraTransform o.cameraTransform() if o.I.camera

    # Terrain
    o.bounds camera.viewPortBounds() if o.I.terrain



# Debug
hotkeys =
  t: -> camera.I.debugText = not camera.I.debugText
  v: -> camera.I.debugDraw = not camera.I.debugDraw

for key, fn of hotkeys
  $(document).bind "keydown", key, (event) ->
    event.preventDefault()
    fn()
