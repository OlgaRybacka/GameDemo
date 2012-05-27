class Game
  constructor: ->
    @soundSystem = new SoundSystem()
    @soundSystem.ready =>
      @ready()
    @ready =>
      @soundSystem.ensure("default")
    @locations = []
    @actions = {}

  ready: (handler)->
    @handlers ||= []
    if @isready == true
      if handler
        handler()
      return
    if handler
      @handlers.push(handler)
    else
      @isready = true
      for handle in @handlers
        handle()

  push: (location) ->
    @locations.push(location)
    location.bindGame(@, @locations.length-1)

  pushAction: (name, action) ->
    @actions[name] = action

  action: (name) ->
    Logger.error("no such action #{name}") if not @actions[name]
    @actions[name]()
  
  state: (location, state) ->
    @locations[location].state(state)

  lactivate: (location) ->
    @locations[location].active = true
    @locations[location].inactiveMiniature.hide()
    @locations[location].activeMiniature.show()
    

  goto: (i) ->
    if @currentLocation
      @currentLocation.deselect()
    @currentLocation = @locations[i]
    @currentLocation.select()

#zmienne globalne
Flagi = {}
window.Flagi = Flagi
Flagi.czy_park = true;
Flagi.czy_teatr = true; 
  
$ ->
  window.game = new Game()

#----------MAPA------------
#-----------1-------------0
  game.push(new Location({
    img: '/assets/game/MAPA.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Dokąd chcesz się udać?<br/><br/><a href="do:MAPApark">1: Do parku</a><br/><a href="do:MAPAteatr">2: Do teatru</a>'
      })
    },
  }))
  game.pushAction "MAPApark", =>
    game.lactivate(1)
    game.goto(1)
  game.pushAction "MAPAteatr", =>
    game.lactivate(100)
    game.goto(100)
    
#----------PARK------------
#-----------1-------------1
  game.push(new Location({
    img: '/assets/game/PARK1.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Stoisz przed bramą Parku Par. To znane miejsce dobre na pierwszą randkę albo romantyczny piknik. Zastanawiasz się, dlaczego Ewa przychodziła tutaj sama, gdy ktoś ciągnie cię za rękaw.<br/><br/><a href="do:park1A">1: [Obejrzyj się]</a>'
      })
    },
  }))
  game.pushAction "park1A", =>
    game.lactivate(2)
    game.goto(2)

#-----------2-------------2
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Widzisz starą cygankę. W jej ciemnej, pomarszczonej twarzy zwracają uwagę oczy – jest w nich coś ze sprytu i coś z naiwno-dziecięcego zaufania. Cyganka: <i>Cyganka prawdę Ci powie, podaj przyszłość, poznaj rękę.</i> <br/><br/><a href="do:park1A">1: [Podaj rękę cygance]</a><br/><a href="do:park1A">2: <i>Nie ze mną te numery!</i></a>'
      })
    },
  }))
  game.pushAction "park2A", =>
    game.lactivate(3)
    game.goto(3)
  game.pushAction "park2B", =>
    game.lactivate(11)
    game.goto(11)
#--------------------------

  game.ready =>
    game.goto(0)
