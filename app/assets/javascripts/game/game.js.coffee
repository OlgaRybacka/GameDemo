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
#--------L1-1-------------1
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

#--------L1-2-------------2
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Widzisz starą Cygankę. W jej ciemnej, pomarszczonej twarzy zwracają uwagę oczy – jest w nich coś ze sprytu i coś z naiwno-dziecięcego zaufania. <br/>Cyganka: <i>Cyganka prawdę Ci powie, podaj przyszłość, poznaj rękę.</i> <br/><br/><a href="do:park2A">1: [Podaj rękę Cygance]</a><br/><a href="do:park2B">2: <i>Nie ze mną te numery!</i></a>'
      })
    },
  }))
  game.pushAction "park2A", =>
    game.lactivate(3)
    game.goto(3)
  game.pushAction "park2B", =>
    game.lactivate(11)
    game.goto(11)

#--------L1-3-------------3
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podajesz rękę cygance. Jej dłonie są ciepłe. Przypomina Ci się, jak w dzieciństwie babcia trzymała twoją rękę, gdy zasypiałeś i opowiadała bajki.<br/> Cyganka: <i>Długie życie, piękna żona, śliczne dzieci, daj monetę.</i> <br/><br/><a href="do:park3A">1: [Daj Cygance piątaka i wejdź do parku]</a><br/><a href="do:park3B">2:<i> Ha! Dobre!</i> [wejdź do parku]</a><br/><a href="do:park3C"> 3: <i>Żona, dzieci?!</i> </a>'
      })
    },
  }))
  game.pushAction "park3A", =>
    game.lactivate(11)
    game.goto(11)
  game.pushAction "park3B", =>
    game.lactivate(11)
    game.goto(11)
  game.pushAction "park3C", =>
    game.lactivate(4)
    game.goto(4)

#--------L1-4-------------4
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Cyganka: <i>Synek, ja wiem, że są problemy, ale będzie dobrze. Ta dziewczyna... blondynka..? </i>(patrzy na ciebie badawczo) <i>brunetka, brunetka! Ona piękna jest, daj monetę.</i><br/><br/><a href="do:park4A">1: [Daj Cygance piątaka i wejdź do parku]</a><br/><a href="do:park4B">2:<i> To jakieś brednie, a ty jesteś oszustką.</i> [wejdź do parku] </a><br/><a href="do:park4C">3: <i>Masz tu nawet banknot </i>[daj Cygance dychę]<i>, ale powiedz wszystko, co wiesz. </i></a>'
      })
    },
  }))
  game.pushAction "park4A", =>
    game.lactivate(11)
    game.goto(11)
  game.pushAction "park4B", =>
    game.lactivate(11)
    game.goto(11)
  game.pushAction "park4C", =>
    game.lactivate(5)
    game.goto(5)

#--------L1-5-------------5
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Cyganka: <i>Dobrze. To najpierw coś, żebyś mi uwierzył: dziewczyna ma na imię Ewa, a gdy wzięłam twoją dłoń w moją, pomyślałeś o swojej babci.</i><br/><br/><a href="do:park5A">1:<i> O kurwa... </i>[wyrwij dłoń i uciekaj do parku] </a><br/><a href="do:park5B">2: <i> O kurwa... </i>[słuchaj dalej]</a>'
      })
    },
  }))
  game.pushAction "park5A", =>
    game.lactivate(11)
    game.goto(11)
  game.pushAction "park5B", =>
    game.lactivate(6)
    game.goto(6)

#--------L1-6-------------6
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Cyganka: <i>A teraz wróżba. Będzie żona, piękna będzie, ale nie powiem, czy to Ewa.</i><br/><br/><a href="do:park6A">1: <i>Powiedz...</i> [daj Cygance jeszcze dychę] </a><br/><a href="do:park6B">2: <i>Powiedz...</i> [daj Cygance jeszcze stówę] </a><br/><a href="do:park6C">3: [Słuchaj dalej] </a>'
      })
    },
  }))
  game.pushAction "park6A", =>
    game.lactivate(7)
    game.goto(7)
  game.pushAction "park6B", =>
    game.lactivate(7)
    game.goto(7)
  game.pushAction "park6C", =>
    game.lactivate(8)
    game.goto(8)

#--------L1-7-------------7
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Cyganka:<i> I tak ci nie powiem, ale dzięki. </i><br/><br/><a href="do:park7A">1: [Słuchaj dalej]</a>'
      })
    },
  }))
  game.pushAction "park7A", =>
    game.lactivate(8)
    game.goto(8)

#--------L1-8-------------8
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Cyganka: <i>Śliczne dzieci. Chłopiec, któremu wszystko pokażesz. Dziewczynka, której nigdy nie zawiedziesz.</i><br/><br/><a href="do:park8A">1:<i> To wszystko? </i></a><br/><a href="do:park8B">2: <i> Z tą babcią, to zrobiłaś na mnie wrażenie, ale to? </i></a>'
      })
    },
  }))
  game.pushAction "park8A", =>
    game.lactivate(9)
    game.goto(9)
  game.pushAction "park8B", =>
    game.lactivate(10)
    game.goto(10)

#--------L1-9-------------9
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Cyganka: <i>Wszystko. Idź z Bogiem.</i><br/><br/><a href="do:park9A">1:<i> Dzięki. </i>[Wejdź do 
  parku]</a><br/><a href="do:park9B">2: <i> Z tą babcią, to zrobiłaś na mnie wrażenie, ale to? </i></a>'
      })
    },
  }))
  game.pushAction "park9A", =>
    game.lactivate(11)
    game.goto(11)
  game.pushAction "park9B", =>
    game.lactivate(10)
    game.goto(10)

#--------L1-10-----------10
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Zielone oczy cyganki ciemnieją, ze złością puszcza twoją dłoń. <br/> Cyganka: <i>Nie wszystko. Od dziś przez miesiąc, codziennie między dwunastą a siedemnastą trzydzieści będzi cię bolało prawe kolano.</i></br> Przepowiednia sprawdza się natychmiast.<br/><br/><a href="do:park10A">1: [Czym prędzej umykaj do parku]</a>'
      })
    },
  }))
  game.pushAction "park10A", =>
    game.lactivate(11)
    game.state(36, 'b')
    game.state(38, 'b')
    game.state(41, 'b')
    game.state(11, 'b')
    game.goto(11)

#--------L2-1------------11
  game.push(new Location({
    img: '/assets/game/PARK3.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wchodzisz do parku. Brama zamyka się ze skrzypnięciem. Oglądasz się za siebie. Cyganka po drugiej stronie szepcze: <i>Tak będzie lepiej.</i> Odchodzi. Zostajesz sam. Wszystkie ścieżki wyglądają tak samo. Którą wybierasz? <br/><br/><a href="do:park11A">1: [Idź na wschód]<br/><a href="do:park11B">2: [Idź na zachód] </a><br/><a href="do:park11C">3: [Idź na północ] </a>'
      })
      b: new LocationState({
        text: 'Wchodzisz do parku. Brama zamyka się ze skrzypnięciem. Oglądasz się za siebie. Cyganka po drugiej stronie śmieje się. <br>Cyganka:<i> Boli kolano? Nie przesadzisz bramy?</i><br/>Odchodzi. Zostajesz sam. Wszystkie ścieżki wyglądają tak samo. Którą wybierasz?<br/><br/><a href="do:park11A">1: [Idź na wschód]<br/><a href="do:park11B">2: [Idź na zachód] </a><br/><a href="do:park11C">3: [Idź na północ] </a>'
      })
      c: new LocationState({
        text: 'Brama nadal zamknięta. Cyganki ani śladu. Jesteś skazany na dalsze błądzenie po parku. Gdzie teraz? <br/><br/><a href="do:park11A">1: [Idź na wschód]<br/><a href="do:park11B">2: [Idź na zachód] </a><br/><a href="do:park11C">3: [Idź na północ] </a>'
      })
    },
  }))
  game.pushAction "park11A", =>
    game.state(11, 'c')
    game.lactivate(13)
    game.goto(13)
  game.pushAction "park11B", =>
    game.state(11, 'c')
    game.lactivate(12)
    game.goto(12)
  game.pushAction "park11C", =>
    game.state(11, 'c')
    game.lactivate(16)
    game.goto(16)

#--------L2-2------------12
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park12A">1: [Idź na wschód]</a><br/><a href="do:park12B">2: [Idź na północ]</a>'
      })
    },
  }))
  game.pushAction "park12A", =>
    game.lactivate(11)
    game.goto(11)
  game.pushAction "park12B", =>
    game.lactivate(15)
    game.goto(15)

#--------L2-3------------13
#--------L2-4------------14
#--------L2-5------------15
#--------L2-6------------16
#--------L2-7------------17
#--------L2-8------------18
#--------L2-8------------19
#--------L2-8------------20
#--------L2-8------------21
#--------L2-8------------22
#--------L2-8------------23
#--------L2-8------------24
#--------L2-8------------25

#--------L3-1------------26
#--------L3-2------------27
#--------L3-3------------28
#--------L3-4------------29
#--------L3-5------------30
#--------L3-6------------31
#--------L3-7------------32
#--------L3-8------------33
#--------L3-9------------34
#--------L3-10-----------35
#--------L3-11-----------36
#--------L3-12-----------37
#--------L3-13-----------38
#--------L3-14-----------39
#--------L3-15-----------40
#--------L3-16-----------41
#--------L3-17-----------42
#--------L3-18-----------43
#--------L3-19-----------44
#--------L3-20-----------45
#--------------------------

  $('a').live('click', (e) ->
    href = $(this).attr('href')
    if href.substr(0,3) == "do:"
      e.preventDefault()
      action = href.substr(3)
      game.action(action)
  )
  game.ready =>
    game.goto(0)
