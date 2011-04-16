block = 
  color: "#CB8"
  width: 32
  height: 32
  solid: true
  opaque: true
  includedModules: ["Physical"]
  excludedModules: ["Movable"]

developer = false

objectToUpdate = null
window.updateObjectProperties = (newProperties) ->
  if objectToUpdate
    $.extend objectToUpdate, engine.construct(newProperties)

$(document).bind "contextmenu", (event) ->
  event.preventDefault()

$(document).mousedown (event) ->
  if developer
    console.log event.which

    p = Point event.pageX, event.pageY
    p = engine.cameraTransform().inverse().transformPoint p

    if event.which == 3
      if object = engine.objectAt(p.x, p.y)
        parent.editProperties(object.I)

        objectToUpdate = object

      console.log object
    else if event.which == 2 || keydown.shift    
      engine.add $.extend(
        x: p.x.snap(32)
        y: p.y.snap(32)
      , block)

hotkeys =
  esc: ->
    developer = !developer

    if developer
      engine.pause()
    else
      engine.play()
  f3: ->
    Local.set("level", engine.saveState())
  f4: ->
    engine.loadState(Local.get("level"))
  f5: ->
    engine.reload()

for key, fn of hotkeys
  $(document).bind "keydown", key, (event) ->
    event.preventDefault()
    fn()