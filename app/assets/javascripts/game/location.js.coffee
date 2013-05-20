class Location
  constructor: (params) ->
    @defaults()
    @elements = {}
    params ||= {}
    for key of params
      if params[key]
        @[key] = params[key]
    @states ||= {}
    if params.activeState
      @activeState = false
      @state(params.activeState)

  defaults: ->
    @img = "/assets/game/f1.png"
    @active = false
    @text = "lorem ipsum"
    @sound = null

  bindGame: (@game, @id) ->
  
  state: (activeState) ->
    #return @activeState if @activeState == activeState
    @states[@activeState].disable() if @activeState
    @disableSound()
    @activeState = activeState
    params = @states[@activeState].enable()
    if params.text
      @text = params.text
    if params.img
      @img = params.img
    if params.sound or params.sound == null
      @sound = params.sound

  select: ->
    e = $('<img>').attr({src: @img})
    
    $('.location')
      .html('')
      .append(e)

    $('.subs').html(@text)
    if @sound
      @game.soundSystem.play(@sound)

  deselect: ->
    @disableSound()

  disableSound: ->
    if @sound and @game
      @game.soundSystem.stop(@sound)
  

#make localization public
window.Location = Location
