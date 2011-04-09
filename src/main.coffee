window.engine = Engine
  ambientLight: 0.5
  canvas: $("canvas").powerCanvas()
  includedModules: ['Box2D']

# Add a red square to the scene
engine.add
  class: "Light"
  x: 50
  y: 50
  color: "#F00"
  width: 100
  height: 100

engine.add
  class: 'Actor'
  opaque: true
  x: 50
  y: 100
  color: "#F00"
  width: 100
  height: 100

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

engine.add
  class: "Wall"
  x: 0
  y: 480 - 16
  width: 640

engine.start()
