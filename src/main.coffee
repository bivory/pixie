window.engine = Engine
  ambientLight: 0.5
  canvas: $("canvas").powerCanvas()

# Add a red square to the scene
engine.add
  class: "Light"
  x: 50
  y: 50
  color: "#F00"
  width: 100
  height: 100

engine.start()
