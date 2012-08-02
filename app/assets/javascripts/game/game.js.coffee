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
Flagi.czy_park = true
Flagi.czy_teatr = true
Flagi.temp_points = 0
Flagi.points = 0
Flagi.temp = 0
  
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
        text: 'Dokąd chcesz się udać?<br/><br/><a href="do:MAPApark">1: Do parku</a><br/><a href="do:MAPAuczelnia">2: Na uczelnię</a><br/><a href="do:MAPArestauracja">3: Do restauracji</a>'
      })
    },
  }))
  game.pushAction "MAPApark", =>
    game.lactivate(1)
    game.goto(1)
  game.pushAction "MAPAuczelnia", =>
    game.lactivate(57)
    game.goto(57)
  game.pushAction "MAPArestauracja", =>
    game.lactivate(152)
    game.goto(152)
    
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
    game.state(36, 'b')
    game.state(38, 'b')
    game.state(41, 'b')
    game.state(11, 'b')
    game.lactivate(11)
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
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park13A">1: [Idź na wschód]</a><br/><a href="do:park13B">2: [Idź na zachód]</a><br/><a href="do:park13C">3: [Idź na północ]</a>'
      })
    },
  }))
  game.pushAction "park13A", =>
    game.lactivate(14)
    game.goto(14)
  game.pushAction "park13B", =>
    game.lactivate(11)
    game.goto(11)
  game.pushAction "park13C", =>
    game.lactivate(17)
    game.goto(17)

#--------L2-4------------14
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park14A">1: [Idź na zachód]</a><br/><a href="do:park14B">2: [Idź na północ]</a>'
      })
    },
  }))
  game.pushAction "park14A", =>
    game.lactivate(13)
    game.goto(13)
  game.pushAction "park14B", =>
    game.lactivate(18)
    game.goto(18)

#--------L2-5------------15
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park15A">1: [Idź na wschód]</a><br/><a href="do:park15B">2: [Idź na północ]</a><br/><a href="do:park15C">3: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park15A", =>
    game.lactivate(16)
    game.goto(16)
  game.pushAction "park15B", =>
    game.lactivate(19)
    game.goto(19)
  game.pushAction "park15C", =>
    game.lactivate(12)
    game.goto(12)


#--------L2-6------------16
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park16A">1: [Idź na wschód]</a><br/><a href="do:park16B">2: [Idź na zachód]</a><br/><a href="do:park16C">3: [Idź na północ]</a><br/><a href="do:park16D">4: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park16A", =>
    game.lactivate(17)
    game.goto(17)
  game.pushAction "park16B", =>
    game.lactivate(15)
    game.goto(15)
  game.pushAction "park16C", =>
    game.lactivate(20)
    game.goto(20)
  game.pushAction "park16D", =>
    game.lactivate(11)
    game.goto(11)

#--------L2-7------------17
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park17A">1: [Idź na wschód]</a><br/><a href="do:park17B">2: [Idź na zachód]</a><br/><a href="do:park17C">3: [Idź na północ]</a><br/><a href="do:park17D">4: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park17A", =>
    game.lactivate(18)
    game.goto(18)
  game.pushAction "park17B", =>
    game.lactivate(16)
    game.goto(16)
  game.pushAction "park17C", =>
    game.lactivate(26)
    game.goto(26)
  game.pushAction "park17D", =>
    game.lactivate(13)
    game.goto(13)

#--------L2-8------------18
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park18A">1: [Idź na zachód]</a><br/><a href="do:park18B">2: [Idź na północ]</a><br/><a href="do:park18C">3: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park18A", =>
    game.lactivate(17)
    game.goto(17)
  game.pushAction "park18B", =>
    game.lactivate(21)
    game.goto(21)
  game.pushAction "park18C", =>
    game.lactivate(14)
    game.goto(14)

#--------L2-8------------19
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park19A">1: [Idź na wschód]</a><br/><a href="do:park19B">2: [Idź na północ]</a><br/><a href="do:park19C">3: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park19A", =>
    game.lactivate(20)
    game.goto(20)
  game.pushAction "park19B", =>
    game.lactivate(22)
    game.goto(22)
  game.pushAction "park19C", =>
    game.lactivate(15)
    game.goto(15)

#--------L2-8------------20
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park20A">1: [Idź na wschód]</a><br/><a href="do:park20B">2: [Idź na zachód]</a><br/><a href="do:park20C">3: [Idź na północ]</a><br/><a href="do:park20D">4: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park20A", =>
    game.lactivate(26)
    game.goto(26)
  game.pushAction "park20B", =>
    game.lactivate(19)
    game.goto(19)
  game.pushAction "park20C", =>
    game.lactivate(23)
    game.goto(23)
  game.pushAction "park20D", =>
    game.lactivate(16)
    game.goto(16)

#--------L2-8------------21
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park21A">1: [Idź na zachód]</a><br/><a href="do:park21B">2: [Idź na północ]</a><br/><a href="do:park21C">3: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park21A", =>
    game.lactivate(26)
    game.goto(26)
  game.pushAction "park21B", =>
    game.lactivate(25)
    game.goto(25)
  game.pushAction "park21C", =>
    game.lactivate(18)
    game.goto(18)

#--------L2-8------------22
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park22A">1: [Idź na wschód]</a><br/><a href="do:park22B">2: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park22A", =>
    game.lactivate(23)
    game.goto(23)
  game.pushAction "park22B", =>
    game.lactivate(19)
    game.goto(19)

#--------L2-8------------23
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park23A">1: [Idź na wschód]</a><br/><a href="do:park23B">2: [Idź na zachód]</a><br/><a href="do:park23C">3: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park23A", =>
    game.lactivate(24)
    game.goto(24)
  game.pushAction "park23B", =>
    game.lactivate(22)
    game.goto(22)
  game.pushAction "park23C", =>
    game.lactivate(20)
    game.goto(20)

#--------L2-8------------24
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park24A">1: [Idź na wschód]</a><br/><a href="do:park24B">2: [Idź na zachód]</a><br/><a href="do:park24C">3: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park24A", =>
    game.lactivate(25)
    game.goto(25)
  game.pushAction "park24B", =>
    game.lactivate(23)
    game.goto(23)
  game.pushAction "park24C", =>
    game.lactivate(26)
    game.goto(26)

#--------L2-8------------25
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Gdzie teraz?</i><br/><br/><a href="do:park25A">1: [Idź na zachód]</a><br/><a href="do:park25B">2: [Idź na południe]</a>'
      })
    },
  }))
  game.pushAction "park25A", =>
    game.lactivate(24)
    game.goto(24)
  game.pushAction "park25B", =>
    game.lactivate(21)
    game.goto(21)

#--------L3-1------------26
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'W końcu coś innego niż drzewa. Jesteś na placu zabaw. Znów przypomina ci się babcia, lato, ty biegasz po drabinkach, babcia rozwiązuje krzyżówki na ławce. Tutaj nie ma nikogo. <br/><br/><a href="do:park26A">1: [Podejdź do huśtawki]</a>'
      })
    },
  }))
  game.pushAction "park26A", =>
    game.lactivate(27)
    game.goto(27)

#--------L3-2------------27
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Chcesz usiąść na huśtawce, ale miejsce jest już zajęte. Na huśtawce siedzi laleczka w niebieskiej sukience. Na szyi ma zawieszony klucz.<br/><br/><a href="do:park27A">1: [Podnieś laleczkę]</a>'
      })
    },
  }))
  game.pushAction "park27A", =>
    game.lactivate(28)
    game.goto(28)

#--------L3-3------------28
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Nie wiesz – mrugnąłeś, czy straciłeś przytomność, ale jest noc. Huśtawka znów zajęta. Siedzi na niej dziewczynka, na oko dziesięcioletnia i uważnie ci się przypatruje. Wygląda znajomo. Najpierw myślisz, że to kwestia sukienki i klucza na szyi, ale nie, to nie to... 
<br/><br/><a href="do:park28A">1: <i>Nie powinnaś być o tej porze w domu?</i></a><br/><a href="do:park28B">2: <i>Jak masz na imię?</i></a><br/><a href="do:park28C">3: <i>Pohuśtać cię?</i></a>'
      })
    },
  }))
  game.pushAction "park28A", =>
    game.lactivate(29)
    game.goto(29)
  game.pushAction "park28B", =>
    game.lactivate(30)
    game.goto(30)
  game.pushAction "park28C", =>
    game.lactivate(31)
    game.goto(31)

#--------L3-4------------29
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Dziewczynka uśmiecha się tylko.<br/><br/><a href="do:park29A">1: <i>Jak masz na imię?</i></a><br/><a href="do:park29B">2: <i>Pohuśtać cię?</i></a>'
      })
    },
  }))
  game.pushAction "park29A", =>
    game.lactivate(30)
    game.goto(30)
  game.pushAction "park29B", =>
    game.lactivate(31)
    game.goto(31)

#--------L3-5------------30
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Dziewczynka: <i>Ewa.</i><br/>Nie wiesz co powiedzieć. Chciałbyś spytać ją o tyle rzeczy, ale to przecież dziecko. Może jest tylko do niej podobna?<br/><br/><a href="do:park30A">1: <i>Rodzice pewnie się o ciebie martwią. Może odprowadzę cię do domu?</i></a>'
      })
    },
  }))
  game.pushAction "park30A", =>
    game.lactivate(33)
    game.goto(33)

#--------L3-6------------31
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Dziewczynka: <i>Poproszę.</i><br/>Lekko popychasz huśtawkę. Dziewczynka mocniej chwyta się
 sznurów. <br/>Dziewczynka: <i>Wyżej!</i><br/><br/><a href="do:park31A">1: [Mocniej popychasz huśtawkę]</a>'
      })
    },
  }))
  game.pushAction "park31A", =>
    game.lactivate(32)
    game.goto(32)

#--------L3-7------------32
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Dziewczynka śmieje się. Poznajesz ten śmiech. Mało komu udaje się przenieść ten rodzaj radości w dorosłość, ale Ewie zdarzały się chwile zapomnienia, gdy śmiała się jak mała dziewczynka, całą sobą.<br/><br/><a href="do:park32A">1: <i>Ewa?</i></a>'
      })
    },
  }))
  game.pushAction "park32A", =>
    game.lactivate(30)
    game.goto(30)

#--------L3-8------------33
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ewa: <i>Nikt się o mnie nie martwi, bo to nie dzieje się naprawdę. Wyjdźmy stąd razem, dobrze?</i><br/>Ewa zeskakuje z huśtawki i chwyta cię za rękę. Patrzy ci prosto w oczy.<br/>Ewa: <i>Idziemy?</i><br/><br/><a href="do:park33A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "park33A", =>
    game.lactivate(34)
    game.goto(34)

#--------L3-9------------34
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Robicie kilka kroków i nagle do waszych uszu docierają niepokojące dźwięki.Ewa mocniej ściska twoją rękę. <br/><br/><a href="do:park34A">1: <i>Rozdzielmy się. Zostań tutaj, a ja pójdę zobaczyć, co to za hałasy.</i></a><br/><a href="do:park34B">2: <i>Chodźmy zobaczyć, co to.</i></a><br/><a href="do:park34C">3: <i>Nie bój się.</i>[Idźcie w przeciwnym kierunku]</a>'
      })
    },
  }))
  game.pushAction "park34A", =>
    game.lactivate(37)
    game.goto(37)
  game.pushAction "park34B", =>
    game.lactivate(39)
    game.goto(39)
  game.pushAction "park34C", =>
    game.lactivate(35)
    game.goto(35)

#--------L3-10-----------35
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Park wygląda dość upiornie. Sam masz stracha, ale cały czas powtarzasz Ewie, że wszystko będzie dobrze, a brama jest już blisko. W końcu faktycznie do niej docieracie. Klucz Ewy pasuje do zamka. W zasadzie moglibyście już wyjść, ale z lewej strony dostrzegasz mroczną, opuszczoną szopę w pajęczynach. Przed nią studnia. W szopie szepty. <br/><br/><a href="do:park35A">1: [Postanawiasz, że zajrzycie do szopy]</a><br/><a href="do:park35B">2: [Opuszczacie park]</a>'
      })
    },
  }))
  game.pushAction "park35A", =>
    game.lactivate(45)
    game.goto(45)
  game.pushAction "park35B", =>
    game.lactivate(36)
    game.goto(36)

#--------L3-11-----------36
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Za bramą Ewa puszcza twoją dłoń. Uśmiecha się, odwraca na pięcie i odchodzi w podskokach, podśpiewując
coś pod nosem. Opierasz się o mur parku i zamykasz oczy. Gdy je otwierasz, znów jest jasno. <br/><br/><a href="do:park36A">1: [MAPA]</a>'
      })
      b: new LocationState({
        text: 'Za bramą Ewa puszcza twoją dłoń. Uśmiecha się, odwraca na pięcie i odchodzi w podskokach, podśpiewując
coś pod nosem. Opierasz się o mur parku i zamykasz oczy. Gdy je otwierasz, znów jest jasno. Kolano boli.<br/><br/><a href="do:park36A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "park36A", =>
    game.lactivate(0)
    game.goto(0)

#--------L3-12-----------37
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Idziesz w kierunku hałasów, ale szybko cichną. Oglądasz się za siebie. Ewy nie ma tam, gdzie ją zostawiłeś. Wracasz biegiem w to miejsce. Dziewczynki nie ma, na ziemi leży laleczka, którą wcześniej znalazłeś na huśtawce. Ktoś pozbawił ją oczu. <br/><br/><a href="do:park37A">1: [Podnieś laleczkę]</a>'
      })
    },
  }))
  game.pushAction "park37A", =>
    game.lactivate(38)
    game.goto(38)

#--------L3-13-----------38
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Znów jest jasno. Stoisz przed bramą Parku Par. W kieszeni znajdujesz oczy laleczki.<br/><br/><a href="do:park37A">1: [MAPA]</a>'
      })
      b: new LocationState({
        text: 'Znów jest jasno. Stoisz przed bramą Parku Par. W kieszeni znajdujesz oczy laleczki. Kolano boli.<br/><br/><a href="do:park37A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "park38A", =>
    game.lactivate(0)
    game.goto(0)

#--------L3-14-----------39
  game.push(new Location({
    img: '/assets/game/PARK4.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Robicie kilka kroków i nagle do waszych uszu docierają niepokojące dźwięki.Ewa mocniej ściska twoją rękę. <br/><br/><a href="do:park39A">1: [Wyrzuć dwie szóstki]</a><br/><a href="do:park39B">2: [Wyrzuć piątkę i dwójkę]</a><br/><a href="do:park39C">3: [Podaj kości Ewie]</a><br/><a href="do:park39D">4: [Zaproponuj Ewie, że każde z was wykona po rzucie]</a>'
      })
    },
  }))
  game.pushAction "park39A", =>
    game.lactivate(40)
    game.goto(40)
  game.pushAction "park39B", =>
    game.lactivate(42)
    game.goto(42)
  game.pushAction "park39C", =>
    game.lactivate(43)
    game.goto(43)
  game.pushAction "park39D", =>
    game.lactivate(44)
    game.goto(44)

#--------L3-15-----------40
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Naprawdę myślałeś, że to się uda? Że wystarczy bardzo chcieć? Wyrzucasz szóstkę i jedynkę. Wszystko dzieje się bardzo szybko. Tajemnicza postać chwyta Ewę za włosy i zanim zdążysz cokolwiek zrobić, na ścieżce nie ma nikogo.<br/><br/><a href="do:park40A">1: [Szukaj wyjścia]</a>'
      })
    },
  }))
  game.pushAction "park40A", =>
    game.lactivate(41)
    game.goto(41)

#--------L3-16-----------41
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Długo kluczysz po parku, ale w końcu znajdujesz bramę. W chwili, gdy przez nią przechodzisz wszystko wraca do normalności. Znów jest jasno. W parku śpiewają ptaki. <br/><br/><a href="do:park41A">1: [MAPA]</a>'
      })
      b: new LocationState({
        text: 'Długo kluczysz po parku, ale w końcu znajdujesz bramę. W chwili, gdy przez nią przechodzisz wszystko wraca do normalności. Znów jest jasno. W parku śpiewają ptaki.<br/> Boli cię kolano.<br/><br/><a href="do:park41A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "park41A", =>
    game.lactivate(0)
    game.goto(0)

#--------L3-17-----------42
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wyrzucasz piątkę i dwójkę. Wszystko dzieje się bardzo szybko. Tajemnicza postać chwyta Ewę za włosy i zanim
zdążysz cokolwiek zrobić, na ścieżce nie ma nikogo.<br/><br/><a href="do:park42A">1: [Szukaj wyjścia]</a>'
      })
    },
  }))
  game.pushAction "park42A", =>
    game.lactivate(41)
    game.goto(41)

#--------L3-18-----------43
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ewa bierze głęboki wdech. Niechętnie puszcza twoją dłoń i sięga po kostki. Wyrzuca szóstkę i jedynkę. Ze
smutkiem patrzy Ci w oczy.<br/>Ewa: <i>Przepraszam...</i><br/>Od tej chwili wszystko dzieje się bardzo szybko. Tajemnicza postać chwyta Ewę za włosy i zanim zdążysz cokolwiek zrobić, na ścieżce nie ma nikogo.<br/><br/><a href="do:park43A">1: [Szukaj wyjścia]</a>'
      })
    },
  }))
  game.pushAction "park43A", =>
    game.lactivate(41)
    game.goto(41)

#--------L3-19-----------44
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Nie puszczając ręki Ewy chwytasz jedną kostkę. Dziewczynka bierze drugą. Chucha na szczęście i ty robisz to samo. Rzucacie. Wypadają dwie szóstki. Ewa śmieje się głośno. Tajemnicza postać odchodzi, co chwila potykając się o skraj długiej szaty. <br/><br/><a href="do:park44A">1: [Dalej szukajcie wyjścia]</a>'
      })
    },
  }))
  game.pushAction "park44A", =>
    game.lactivate(35)
    game.goto(35)

#--------L3-20-----------45
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Na palcach podchodzicie do szopy. Nagle drzwi otwierają się, plątanina rąk wciąga Ewę do środka. Drzwi zamykają się z trzaskiem, szepty cichną. Naciskasz na klamkę. W środku nie ma nikogo. Na podłodze szopy leży laleczka, którą wcześniej znalazłeś na huśtawce. Ktoś pozbawił ją oczu.<br/><br/><a href="do:park45A">1: [Podnieś laleczkę]</a>'
      })
    },
  }))
  game.pushAction "park45A", =>
    game.lactivate(38)
    game.goto(38)


#---MIESZKANIE-CHŁOPAKA----

#-----------M-CH-1-------46
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: '<br/><br/><a href="do:mie_ch46A">...</a>'
      })
    },
  }))
  game.pushAction "mie_ch46A", =>
    game.lactivate(47)
    game.goto(47)

#-----------M-CH-2-------47
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: '<br/><br/><a href="do:mie_ch47A">...</a>'
      })
    },
  }))
  game.pushAction "mie_ch47A", =>
    game.lactivate(48)
    game.goto(48)

#-----------M-CH-3-------48
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: '<br/><br/><a href="do:mie_ch48A">...</a>'
      })
    },
  }))
  game.pushAction "mie_ch48A", =>
    game.lactivate(49)
    game.goto(49)

#-----------M-CH-4-------49
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Budzi cię telefon.<br/><br/><a href="do:mie_ch49A">1: <i>Halo?</i></a>'
      })
    },
  }))
  game.pushAction "mie_ch49A", =>
    game.lactivate(50)
    game.goto(50)

#-----------M-CH-5-------50
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Głos w słuchawce: <i>Cześć, tu Alicja.  Jestem przyjaciółką Ewy. Mam twój numer od jednej znajomej.</i><br/><br/><a href="do:mie_ch50A">1: <i>OK, a o co chodzi?</i></a>'
      })
    },
  }))
  game.pushAction "mie_ch50A", =>
    game.lactivate(51)
    game.goto(51)

#-----------M-CH-6-------51
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Alicja: <i>Wiem, że nie jesteś już z Ewą…</i><br/><br/><a href="do:mie_ch51A">1: <i>Trochę się zmieniło ostanio. </i></a><br/><a href="do:mie_ch51B">2: <i>Brawo za spostrzegawczość.</i></a>'
      })
    },
  }))
  game.pushAction "mie_ch51A", =>
    Flagi.temp_points = Flagi.temp_points + 1
    game.lactivate(52)
    game.goto(52)
  game.pushAction "mie_ch51B", =>
    Flagi.temp_points = Flagi.temp_points - 1
    game.lactivate(52)
    game.goto(52)

#-----------M-CH-7-------52
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Alicja: <i>Ale czy nie mógłbyś mi pomóc mimo to? Nie wiesz, gdzie jest Ewa? Miała mnie odebrać z dworca, ale nie pojawiła się, nie mogę się też do niej dodzwonić. Coś się z nią dzieje?</i><br/><br/><a href="do:mie_ch52A">1: <i>Pojęcia nie mam, to już dwa tygodnie, jak się rozstaliśmy. Dzwoniłaś do kogoś innego?</i></a>'
      })
    },
  }))
  game.pushAction "mie_ch52A", =>
    game.lactivate(53)
    game.goto(53)

#-----------M-CH-8-------53
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Alicja: <i>Do Izy tylko, ale ona też nie wie, co się dzieje.</i><br/><br/><a href="do:mie_ch51A">1: <i>To wydaje się dziwne. </i></a><br/><a href="do:mie_ch51B">2: <i>Gdzie ją posiało?</i></a>'
      })
    },
  }))
  game.pushAction "mie_ch51A", =>
    Flagi.temp_points = Flagi.temp_points + 1
    game.lactivate(54)
    game.goto(54)
  game.pushAction "mie_ch51B", =>
    Flagi.temp_points = Flagi.temp_points - 1
    game.state(54, 'b')
    game.lactivate(54)
    game.goto(54)

#-----------M-CH-9-------54
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Alicja: <i>No właśnie, coś się musiało stać.Pomóż mi, znajdź ją. Proszę. Możesz to zrobić?</i><br/><br/><a href="do:park54A">1: <i>OK, poszukam jej. Pewnie coś musiało ją zatrzymać i zgubiła telefon przy okazji, ot. </i></a>'
      })
      b: new LocationState({
        text: 'Alicja: <i>Nie wiem, nic nie wiem. Pomóż mi, znajdź ją. Proszę. Możesz to zrobić?</i><br/><br/><a href="do:park54A">1: <i>OK, poszukam jej. Pewnie coś musiało ją zatrzymać i zgubiła telefon przy okazji, ot. </i></a>'
      })
    },
  }))
  game.pushAction "park54A", =>
    game.lactivate(55)
    game.goto(55)

#-----------M-CH-10------55
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Alicja: <i>Gdybyś czegoś się dowiedział, daj mi znać od razu, jestem pod tym numerem.</i><br/><br/><a href="do:mie_ch55A">1: <i>No dobra, popytam u niej w pracy, tam może być, albo na wydziale. Bądź dobrej myśli.</i></a>'
      })
    },
  }))
  game.pushAction "mie_ch55A", =>
    game.lactivate(56)
    game.goto(56)

#-----------M-CH-11------56
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Alicja: <i>OK, powodzenia.</i><br/><br/><a href="do:mie_ch56A">1: <i>Co się mogło tam stać?...  </i></a><br/><a href="do:mie_ch56B">2: <i>Nie jestem już z nią, ale wciąż muszę robić coś za nią...</i></a>'
      })
    },
  }))
  game.pushAction "mie_ch56A", =>
    Flagi.temp_points = Flagi.temp_points + 1
    if Flagi.temp_points > 0
      Flagi.points = Flagi.points + 1
    Flagi.temp_points = 0
    game.lactivate(0)
    game.goto(0)
  game.pushAction "mie_ch56B", =>
    Flagi.temp_points = Flagi.temp_points - 1
    if Flagi.temp_points > 0
      Flagi.points = Flagi.points + 1
    Flagi.temp_points = 0
    game.lactivate(0)
    game.goto(0)

#-----------UCZELNIA-------
#-----------U-1A---------57
  game.push(new Location({
    img: '/assets/game/uczelnia1.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Nie bez problemu udaje ci się otworzyć ciężkie i ogromne drzwi prowadzące do wnętrza Collegium Maius. Znajdujesz się w przestronnym holu, po swojej prawej stronie widzisz portiernię. Rozglądasz się chwilę po pustej przestrzeni aż w końcu dostrzegasz stojącego kawałek przed tobą Profesora. Poznajesz go! To promotor Ewy. Zaprasza cię gestem ręki do siebie.<br/><br/><a href="do:uczelnia57A">1: [Podejdź do profesora]</a>'
      })
    },
  }))
  game.pushAction "uczelnia57A", =>
    game.lactivate(58)
    game.goto(58)

#-----------U-1B---------58
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor: <i>Witam serdecznie szanownego prelegenta! Tak się wspaniale składa, że konferencja już się zaczęła, a pan, jak widzę, punktualny! Zapraszam, zapraszam ze mną na górę!</i><br/>Patrzysz przez chwilę na Profesora, który gestem wskazuje schody.<br/><br/><a href="do:uczelnia58A">1: [Pójdź za Profesorem]</a><br/><a href="do:uczelnia58B">2: [Przyznaj się, że pomylił cię z kimś]</a>'
      })
    },
  }))
  game.pushAction "uczelnia58A", =>
    game.lactivate(59)
    game.goto(59)
  game.pushAction "uczelnia58B", =>
    game.lactivate(60)
    game.goto(60)

#-----------U-1C---------59
  game.push(new Location({
    img: '/assets/game/uczelnia1.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Tak, oczywiście, chodźmy w takim razie do sali.</i><br/>Wchodzicie po szerokich, ale krętych schodach. Profesor pokonuje je bez wysiłku, pod tobą jednak uginają się kolana – kto wie, ze zmęczenia, ze strachu? Błądzicie chwilę po korytarzach i ostatecznie trafiacie do właściwej sali. Profesor otwiera przed tobą drzwi i oboje wchodzicie do środka.<br/><br/><a href="do:uczelnia59A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia59A", =>
    game.lactivate(61)
    game.goto(61)

#-----------U-1D---------60
  game.push(new Location({
    img: '/assets/game/uczelnia1.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Niestety, ale pan Profesor pomylił mnie z kimś. Szukam Ewy, zna ją pan. Wiem, że studiowała tutaj. Wydaje mi się, że zaginęła. Może mi pan pomóc?</i><br/>Profesor zastanawia się chwilę, po czym potakująco kiwa głową i zaprasza cię gestem na górę. Wchodzicie po szerokich, ale krętych schodach. Profesor pokonuje je bez wysiłku, pod tobą jednak uginają się kolana – kto wie, ze zmęczenia, ze strachu? Błądzicie chwilę po korytarzach i ostatecznie trafiacie do właściwego gabinetu. Profesor otwiera przed tobą drzwi i oboje wchodzicie do środka.<br/><br/><a href="do:uczelnia60A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia60A", =>
    game.lactivate(84)
    game.goto(84)

#-----------U-2A---------61
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Sala pełna jest gości. Część z nich to zapewne sami prelegenci, reszta zaś to goście, którzy pojawili się, by wysłuchać referatów. Profesor patrzy na ciebie i wskazuje gestem mównicę. <br/><br/><a href="do:uczelnia61A">1: [Podejdź do Profesora i spróbuj wyjaśnić tę pomyłkę.]</a><br/><a href="do:uczelnia61B">2: [Podejdź to mównicy tak, jakbyś chciał wygłosić referat.]</a><br/><a href="do:uczelnia61C">3: [Podejdź do mównicy i spróbuj opowiedzieć słuchaczom o Ewie. ]</a>'
      })
    },
  }))
  game.pushAction "uczelnia61A", =>
    game.lactivate(62)
    game.goto(62)
  game.pushAction "uczelnia61B", =>
    game.lactivate(63)
    game.goto(63)
  game.pushAction "uczelnia61C", =>
    Flagi.temp = 0
    game.lactivate(64)
    game.goto(64)

#-----------U-2B---------62
  game.push(new Location({
    img: '/assets/game/uczelnia1.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podchodzisz do Profesora i prosisz go szeptem, by odszedł z tobą na bok.<br/>Ty: <i>Panie Profesorze, obawiam się, że zaszła pomyłka. Tak naprawdę nie jestem jedną z osób, które miały wygłaszać tutaj referat. Szukam Ewy. Sądzę, że zaginęła.</i><br/><br/><a href="do:uczelnia62A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia62A", =>
    game.lactivate(65)
    game.goto(65)

#-----------U-2C---------63
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podchodzisz do mównicy. Lekko trzęsą ci się ręce. Nie masz pojęcia, co teraz zrobić.<br/><br/><a href="do:uczelnia63A">1: [Powiedz profesorowi, że w roztargnieniu zostawiłeś wydruk referatu na dworcu PKP]</a><br/><a href="do:uczelnia63B">2: [Opowiedz dowcip]</a>'
      })
    },
  }))
  game.pushAction "uczelnia63A", =>
    game.lactivate(70)
    game.goto(70)
  game.pushAction "uczelnia63B", =>
    game.lactivate(71)
    game.goto(71)

#-----------U-2D---------64
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podchodzisz do mównicy. Nie masz żadnego referatu, ale chcesz opowiedzieć o Ewie. Może ktoś wie, co się z nią stało...<br/>Ty: <i>Nie wygłoszę dziś referatu, bo mam do przekazania ważniejszą wiadomość. Zaginęła Ewa. Może ktoś z was wie, co się z nią stało?</i><br/><br/><a href="do:uczelnia64A">1: [Powiedz, że to do niej niepodobne]</a><br/><a href="do:uczelnia64B">2: [Powiedz, że wiedziałeś, że może się to kiedyś zdarzyć]</a>'
      })
    },
  }))
  game.pushAction "uczelnia64A", =>
    Flagi.temp = Flagi.temp + 1
    game.lactivate(76)
    game.goto(76)
  game.pushAction "uczelnia64B", =>
    game.lactivate(77)
    game.goto(77)

#-----------U-2E---------65
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor wygląda na wzburzonego. Chwilę milczy, ale zaraz zasypuje cię pytaniami. <br/>PROFESOR: <i>Ale jak to, okłamał mnie pan? Co z referatem? Co to za historia z Ewą? Proszę to natychmiast wyjaśnić!</i><br/><br/><a href="do:uczelnia65A">1: [Spróbuj przekonać Profesora, że Ewa jest ważniejsza od jakiegoś tam referatu.]</a><br/><a href="do:uczelnia65B">2: [Przeproś i opowiedz o zaginięciu Ewy.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia65A", =>
    game.lactivate(66)
    game.goto(66)
  game.pushAction "uczelnia65B", =>
    game.lactivate(67)
    game.goto(67)

#-----------U-2F---------66
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty: <i>Żaden referat mnie nie obchodzi, zaginęła Ewa i przyszedłem tutaj, bo sądziłem, że ktoś może wiedzieć, co się z nią stało. To pan mnie z kimś pomylił!</i><br/><br/><a href="do:uczelnia66A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia66A", =>
    game.lactivate(68)
    game.goto(68)

#-----------U-2G---------67
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty: <i>Przepraszam, zrobiłem to tylko dlatego, żeby dowiedzieć się czegoś o Ewie. Zaginęła i próbuję ją odnaleźć!</i><br/><br/><a href="do:uczelnia67A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia67A", =>
    game.lactivate(69)
    game.goto(69)

#-----------U-2H---------68
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor: <i>Ależ co to za bezczelność! Pan podszywa się pod prelegenta i opowiada tu jakieś brednie! Proszę stąd natychmiast wyjść!</i><br/><br/><a href="do:uczelnia68A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "uczelnia68A", =>
    game.lactivate(0)
    game.goto(0)

#-----------U-2I---------69
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor patrzy na ciebie podejrzliwie, ale po chwili wyraz zdumienia znika z jego twarzy.<br/>Profesor: <i>To dopiero historia… Zaginęła, mówi pan? Zapraszam do swojego gabinetu, tam będziemy mogli o tym porozmawiać.</i><br/><br/><a href="do:uczelnia69A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia69A", =>
    game.lactivate(84)
    game.goto(84)

#-----------U-2J---------70
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor patrzy na ciebie z rozbawieniem.<br/><br/><a href="do:uczelnia70A">1: <i>Panie Profesorze, zdaje się, że z wrażenia zostawiłem swoją kopię referatu na dworcu. Czy nie wysyłałem może kopii referatu na skrzynkę mailową konferencji?</i></a>'
      })
    },
  }))
  game.pushAction "uczelnia70A", =>
    game.lactivate(72)
    game.goto(72)

#-----------U-2K---------71
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty: <i>Na polonistyce UAM było czterech bardzo dobrych studentów, którzy radzili sobie świetnie na wszystkich egzaminach i testach. Zbliżał się egzamin z historii doktryn literackich, miał być w poniedziałek o 8.00, wszystkim z ocen wychodziła 5. Byli tak pewni siebie, że przed egzaminem zdecydowali się poimprezować u kolegów z uniwersytetu w Krakowie. Było super, ale przesadzili i kiedy zasnęli w niedzielę po południu, to obudzili się w poniedziałek około 12.00.</i><br/><br/><a href="do:uczelnia71A">1: [Opowiadaj dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia71A", =>
    game.lactivate(82)
    game.goto(82)

#-----------U-2L---------72
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor: <i>Tak się szczęśliwie składa, że wydrukowaliśmy dziś wszystkie przesłane nam referaty. Proszę, oto pański!</i><br/><br/><a href="do:uczelnia72A">1: [Odczytaj referat.]</a><br/><a href="do:uczelnia72B">2: [Przyznaj się, że nastąpiła pomyłka.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia72A", =>
    game.lactivate(73)
    game.goto(73)
  game.pushAction "uczelnia72B", =>
    game.lactivate(62)
    game.goto(62)

#-----------U-2M---------73
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Starasz się rozumieć to, co czytasz, ale szybko gubisz wątek. Nigdy byś czegoś takiego nie napisał. Ze wszystkich wymienionych nazwisk kilka kojarzy ci się z prezenterami telewizyjnymi i piłkarzami, może czasem przypomina ci się coś, o czym mówiła ci kiedyś Ewa. Kiedy kończysz czytać referat, słuchacze zaczynają zadawać pytania.<br/><br/><a href="do:uczelnia73A">1: [Spróbuj odpowiedzieć.]</a><br/><a href="do:uczelnia73B">2: [Poproś o chwilę przerwy i ucieknij.]</a><br/><a href="do:uczelnia73C">3: [Przyznaj się, że nastąpiła pomyłka.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia73A", =>
    game.lactivate(74)
    game.goto(74)
  game.pushAction "uczelnia73B", =>
    game.lactivate(75)
    game.goto(75)
  game.pushAction "uczelnia73C", =>
    game.lactivate(68)
    game.goto(68)

#-----------U-2N---------74
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor: <i>Tak, to był ciekawy referat, niech się pan nie przejmuje pytaniami. Rozumiem, że to pewnie efekt męczącej podróży. W każdym razie, to już koniec konferencji, zapraszam za rok!</i><br/><br/><a href="do:uczelnia74A">1: [Spróbuj wyjaśnić Profesorowi, że szukasz Ewy.]</a><br/><a href="do:uczelnia74B">2: [Wyjdź z uniwersytetu.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia74A", =>
    game.lactivate(62)
    game.goto(62)
  game.pushAction "uczelnia74B", =>
    game.lactivate(0)
    game.goto(0)

#-----------U-2O---------75
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wymawiasz się chwilową niedyspozycją i obiecujesz wrócić za chwilę. Zbiegasz schodami w dół, byle tylko szybko stąd uciec.<br/><br/><a href="do:uczelnia75A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "uczelnia75A", =>
    game.lactivate(0)
    game.goto(0)


#-----------U-2P---------76
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ludzie patrzą na ciebie zdumieni, ale wciąż słuchają.<br/>Ty: <i>To do niej zupełnie niepodobne, nie odzywa się, nie odbiera telefonów.  Boję się, że coś się z nią stało.</i><br/><br/><a href="do:uczelnia76A">1: [Powiedz, że jest zagubiona.]</a><br/><a href="do:uczelnia76B">2: [Powiedz, że jest bezmyślna.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia76A", =>
    Flagi.temp = Flagi.temp + 1
    game.lactivate(78)
    game.goto(78)
  game.pushAction "uczelnia76B", =>
    game.lactivate(79)
    game.goto(79)

#-----------U-2R---------77
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ludzie patrzą na ciebie zdumieni, ale wciąż słuchają.<br/>Ty: <i>Ewa była zawsze bardzo dziwna i skryta, bałem się, że kiedyś może zrobić coś tak głupiego. Teraz trzeba ją przede wszystkim znaleźć!</i><br/><br/><a href="do:uczelnia77A">1: [Powiedz, że jest zagubiona.]</a><br/><a href="do:uczelnia77B">2: [Powiedz, że jest bezmyślna.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia77A", =>
    Flagi.temp = Flagi.temp + 1
    game.lactivate(78)
    game.goto(78)
  game.pushAction "uczelnia77B", =>
    game.lactivate(79)
    game.goto(79)

#-----------U-2S---------78
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Na sali widać poruszenie.<br/>Ty: <i>Musi być teraz zdezorientowana i zagubiona! Może nawet ma jakieś kłopoty, o jakich nie chciała nikomu powiedzieć?</i><br/><br/><a href="do:uczelnia78A">1: [Powiedz, że będziesz jej szukał dalej.]</a><br/><a href="do:uczelnia78B">2: [Powiedz, że masz dość.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia78A", =>
    Flagi.temp = Flagi.temp + 1
    game.lactivate(80)
    game.goto(80)
  game.pushAction "uczelnia78B", =>
    game.lactivate(81)
    game.goto(81)

#-----------U-2T---------79
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Na sali widać poruszenie.<br/>Ty: <i>Ewa jest zupełnie bezmyślna! Jak można w ten sposób zniknąć! To przecież szczyt idiotyzmu!</i><br/><br/><a href="do:uczelnia79A">1: [Powiedz, że będziesz jej szukał dalej.]</a><br/><a href="do:uczelnia79B">2: [Powiedz, że masz dość.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia79A", =>
    Flagi.temp = Flagi.temp + 1
    game.lactivate(80)
    game.goto(80)
  game.pushAction "uczelnia79B", =>
    game.lactivate(81)
    game.goto(81)

#-----------U-2U---------80
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Niektórzy zaczynają wychodzić, inni tracą zainteresowanie tym, co mówisz.<br/>Ty: <i>Będę jej szukał dalej, ale jeżeli możecie mi pomóc, dajcie znać! Może ktoś z was widział ją dziś albo z nią rozmawiał?</i><br/><br/><a href="do:uczelnia80A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia80A", =>
    if Flagi.temp > 1
      Flagi.temp = 0
      game.lactivate(69)
      game.goto(69)
    else
      Flagi.temp = 0
      game.lactivate(68)
      game.goto(68)

#-----------U-2W---------81
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Niektórzy zaczynają wychodzić, inni tracą zainteresowanie tym, co mówisz.<br/>Ty: <i>Mam już dość tych poszukiwań. Nie wiem, czy chce mi się dalej biegać po tych wszystkich miejscach, gdzie mogłaby być.</i><br/><br/><a href="do:uczelnia81A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia81A", =>
    if Flagi.temp > 1
      Flagi.temp = 0
      game.lactivate(69)
      game.goto(69)
    else
      Flagi.temp = 0
      game.lactivate(68)
      game.goto(68)

#-----------U-2K'--------82
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Na egzamin oczywiście nie zdążyli. Postanowili zabajerować profesora. Tłumaczyli się, że w weekend pojechali do kolegów do Krakowa, żeby pogłębić wiedzę i wymienić doświadczenia. Niestety, w drodze powrotnej gdzieś w lasach złapali gumę, nie mieli koła zapasowego i długo nie mogli znaleźć nikogo do pomocy. Dlatego, niestety, przyjechali dopiero około południa. Profesor przemyślał to i powiedział:<br/>- Dobrze, możecie przystąpić do egzaminu jutro rano.</i><br/><br/><a href="do:uczelnia82A">1: [Opowiadaj dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia82A", =>
    game.lactivate(83)
    game.goto(83)

#-----------U-2K''-------83
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Studenci zadowoleni, że się udało go zbajerować, pouczyli się jeszcze trochę w nocy i na drugi dzień przyszli jak zwykle pewni siebie. Profesor posadził ich w czterech osobnych pokojach, zamknął drzwi, a asystenci rozdali pytania. Cały test był za 100 punktów. Na pierwszej stronie było zadanie za 5 punktów – rola retoryki w poezji od starożytności do oświecenia. Studenci rozwiązali je bez problemu. Na drugiej stronie było tylko jedno pytanie za 95 punktów:<br/>- Które koło?</i><br/><br/><a href="do:uczelnia83A">1: [Czekaj na reakcję publiczności]</a>'
      })
    },
  }))
  game.pushAction "uczelnia83A", =>
    game.lactivate(68)
    game.goto(68)



#-----------U-3A---------84
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Pokój Profesora jest niewielki. Stół, biurko, kilka krzeseł i półki zawalone książkami. <br/>Profesor: <i>A więc Ewa zaginęła? To naprawdę niespotykana sprawa. Jestem w szoku! Skąd pan w ogóle wie o tym? To pana znajoma?</i><br/><br/><a href="do:uczelnia84A">1: [Powiedz, że to twoja dziewczyna. ]</a><br/><a href="do:uczelnia84B">2: [Powiedz, że to twoja współlokatorka. ]</a><br/><a href="do:uczelnia84C">3: [Powiedz, że to twoja siostra. ]</a>'
      })
    },
  }))
  game.pushAction "uczelnia84A", =>
    game.lactivate(85)
    game.goto(85)
  game.pushAction "uczelnia84B", =>
    game.state(100, 'b')
    game.lactivate(86)
    game.goto(86)
  game.pushAction "uczelnia84C", =>
    game.state(100, 'b')
    game.lactivate(87)
    game.goto(87)

#-----------U-3B---------85
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wolisz powiedzieć Profesorowi prawdę i przejść do dalszych wyjaśnień.<br/>Ty:<i> Jesteśmy ze sobą od jakiegoś czasu. Dziś Ewa nagle zniknęła.</i><br/><br/><a href="do:uczelnia85A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia85A", =>
    game.lactivate(88)
    game.goto(88)

#-----------U-3C---------86
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor nie musi wiedzieć wszystkiego. Wystarczy, że powie coś, co pomoże ci w poszukiwaniach.<br/>Ty:<i> Od jakiegoś czasu mieszkamy razem. Dziś Ewa nagle zniknęła.</i><br/><br/><a href="do:uczelnia86A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia86A", =>
    game.lactivate(89)
    game.goto(89)

#-----------U-3D---------87
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor nie musi wiedzieć wszystkiego. Wystarczy, że powie coś, co pomoże ci w poszukiwaniach.<br/>Ty:<i> Ewa jest moją siostrą. Dziś nagle zniknęła.</i><br/><br/><a href="do:uczelnia87A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia87A", =>
    game.lactivate(89)
    game.goto(89)

#-----------U-3E---------88
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor: <i>Tak, tak, rozumiem. Wszystko jasne. A jak pan sądzi, co mogło sprawić, że Ewa tak nagle zniknęła?</i><br/><br/><a href="do:uczelnia88A">1: [Powiedz ogólnie, że miała jakieś problemy.]</a><br/><a href="do:uczelnia88B">2: [Powiedz, że nie wiesz.]</a><br/><a href="do:uczelnia88C">3: [Powiedz, że między wami coś się stało.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia88A", =>
    game.lactivate(90)
    game.goto(90)
  game.pushAction "uczelnia88B", =>
    game.lactivate(91)
    game.goto(91)
  game.pushAction "uczelnia88C", =>
    game.lactivate(92)
    game.goto(92)

#-----------U-3F---------89
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor: <i>Tak, tak, rozumiem. Wszystko jasne. A jak pan sądzi, co mogło sprawić, że Ewa tak nagle zniknęła?</i><br/><br/><a href="do:uczelnia89A">1: [Powiedz ogólnie, że miała jakieś problemy.]</a><br/><a href="do:uczelnia89B">2: [Powiedz, że nie wiesz.]</a><br/><a href="do:uczelnia89C">3: [Powiedz, że między wami coś się stało.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia89A", =>
    game.lactivate(90)
    game.goto(90)
  game.pushAction "uczelnia89B", =>
    game.lactivate(91)
    game.goto(91)
  game.pushAction "uczelnia89C", =>
    game.lactivate(92)
    game.goto(92)

#-----------U-3G---------90
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Wiem, że miała jakieś problemy, nie bardzo chciała o tym mówić. Myślę, że dlatego gdzieś zniknęła. </i><br/><br/><a href="do:uczelnia90A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia90A", =>
    game.lactivate(95)
    game.goto(95)

#-----------U-3H---------91
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor: <i>Naprawdę nic nie przychodzi panu do głowy? To mogłoby nam bardzo pomóc!</i><br/><br/><a href="do:uczelnia91A">1: [Powiedz ogólnie, że miała jakieś problemy.]</a><br/><a href="do:uczelnia91B">2: [Powiedz, że nie wiesz.]</a><br/><a href="do:uczelnia91C">3: [Powiedz, że między wami coś się stało.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia91A", =>
    game.lactivate(90)
    game.goto(90)
  game.pushAction "uczelnia91B", =>
    game.lactivate(93)
    game.goto(93)
  game.pushAction "uczelnia91C", =>
    game.lactivate(92)
    game.goto(92)

#-----------U-3I---------92
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Myślę, że to mogło się stać przeze mnie. Szukam jej teraz wszędzie, potrzebuję wskazówek, gdzie mogła się udać. </i><br/><br/><a href="do:uczelnia92A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia92A", =>
    game.lactivate(99)
    game.goto(99)

#-----------U-3J---------93
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Przykro mi, ale wiem tylko, że Ewa zaginęła. Nie myślałem prawie w ogóle o tym, jak to się stało.</i><br/><br/><a href="do:uczelnia93A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia93A", =>
    game.lactivate(94)
    game.goto(94)

#-----------U-3K---------94
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor rozkłada bezradnie ręce.<br/>Profesor:<i> No cóż, nie jestem w stanie panu w żaden sposób pomóc. Niech pan lepiej zgłosi sprawę na policję, oni powinni się tym zająć!</i><br/><br/><a href="do:uczelnia94A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "uczelnia94A", =>
    game.lactivate(0)
    game.goto(0)

#-----------U-3L---------95
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor wygląda na zmartwionego i zaciekawionego zarazem.<br/>Profesor: <i>Problemy? Z pewnością? Ale czy pan się domyśla, co to mogło być? To by nam bardzo pomogło!</i><br/><br/><a href="do:uczelnia95A">1: [Powiedz, że nie masz pojęcia, o co mogło chodzić.]</a><br/><a href="do:uczelnia95B">2: [Powiedz, że między wami coś się stało.]</a><br/><a href="do:uczelnia95C">3: [Powiedz, że boisz się, że Ewa nie do końca zdaje sobie sprawę z tego, co zrobiła.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia95A", =>
    game.lactivate(93)
    game.goto(93)
  game.pushAction "uczelnia95B", =>
    game.lactivate(92)
    game.goto(92)
  game.pushAction "uczelnia95C", =>
    game.lactivate(96)
    game.goto(96)

#-----------U-3M---------96
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> To zabrzmi brutalnie, ale myślę, że ona ma teraz ograniczoną poczytalność. Krótko mówiąc, odbiło jej. Nie rozumiem tego w ogóle.</i><br/><br/><a href="do:uczelnia96A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia96A", =>
    game.lactivate(97)
    game.goto(97)

#-----------U-3N---------97
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor wygląda na wzbudzonego twoimi słowami.<br/>Profesor: <i>Naprawdę sądzi pan, że to wyłącznie jej wina? To znaczy – uroiła coś sobie, nie myśli racjonalnie?</i><br/><br/><a href="do:uczelnia97A">1: [Powiedz, że Ewa musiała zwariować.]</a><br/><a href="do:uczelnia97B">2: [Powiedz, że między wami coś się stało.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia97A", =>
    game.lactivate(98)
    game.goto(98)
  game.pushAction "uczelnia97B", =>
    game.lactivate(92)
    game.goto(92)

#-----------U-3O---------98
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Ewie odbiło. Nikt przy zdrowych zmysłach nie robi czegoś takiego, nie ucieka tak po prostu, nie dając znaku życia.</i><br/><br/><a href="do:uczelnia98A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia98A", =>
    game.lactivate(94)
    game.goto(94)

#-----------U-3P---------99
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor wygląda na zaskoczonego twoimi słowami.<br/>Profesor: <i>Hm, to ciekawe, co pan mówi. Powoli się to zaczyna układać, ta cała ucieczka. Jest pan pewien, że to przez pana?</i><br/><br/><a href="do:uczelnia99A">1: [Powiedz, że nie masz pojęcia, o co mogło chodzić.]</a><br/><a href="do:uczelnia99B">2: [Powiedz, że Ewa musiała zwariować.]</a><br/><a href="do:uczelnia99C">3: [Powiedz, że miała odebrać koleżankę, ale nie pojawiła się na dworcu.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia99A", =>
    game.lactivate(93)
    game.goto(93)
  game.pushAction "uczelnia99B", =>
    game.lactivate(98)
    game.goto(98)
  game.pushAction "uczelnia99C", =>
    game.lactivate(100)
    game.goto(100)

#-----------U-3R---------100
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Rano dzwoniła koleżanka, którą Ewa miała odebrać z dworca. Od tamtej pory jej szukam.</i><br/><br/><a href="do:uczelnia100A">1: [Dalej]</a>'
      }),
      b: new LocationState({
        text: 'Ty:<i> Rano dzwoniła koleżanka, którą Ewa miała odebrać z dworca. Od tamtej pory jej szukam.</i><br/><br/><a href="do:uczelnia100B">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia100A", =>
    game.lactivate(101)
    game.goto(101)
  game.pushAction "uczelnia100B", =>
    game.lactivate(104)
    game.goto(104)

#-----------U-3S---------101
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor znów marszczy brwi, wydaje się chwilę zastanawiać, a gdy wreszcie odzywa się, w jego głosie pobrzmiewa nuta rezygnacji.<br/>Profesor: <i>Wszystko się chyba wyjaśniło. Nie mogę panu niestety pomóc. Ewa to jedna z moich bardziej błyskotliwych studentek. Proszę szukać jej dalej. Mam coś jednak dla pana. Gdyby pan ją znalazł, proszę dać jej tę książkę, bardzo chciała ją ode mnie ostatnio pożyczyć. To Logika sensu Gillesa Deleuze’a.</i><br/><br/><a href="do:uczelnia101A">1: [Odmów]</a><br/><a href="do:uczelnia101B">2: [Weź książkę.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia101A", =>
    game.lactivate(102)
    game.goto(102)
  game.pushAction "uczelnia101B", =>
    game.lactivate(103)
    game.goto(103)

#-----------U-3T---------102
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Dziękuję, ale w tej chwili i tak książka nie przyda się żadnemu z nas.</i><br/><br/><a href="do:uczelnia102A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia102A", =>
    game.lactivate(94)
    game.goto(94)

#-----------U-3U---------103
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Dziękuję, przekażę Ewie tę książkę, jak tylko uda mi się ją znaleźć.</i><br/><br/><a href="do:uczelnia103A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia103A", =>
    game.lactivate(108)
    game.goto(108)

#-----------U-3W---------104
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor wygląda na zmęczonego twoją opowieścią.<br/>Profesor: <i>Tak, rozumiem, to wszystko rzeczywiście nie wygląda dobrze. Nie do końca wiem, jak mógłbym panu pomóc. Cz chciałby pan powiedzieć coś jeszcze?</i><br/><br/><a href="do:uczelnia104A">1: [Powiedz, że to wszystko.]</a><br/><a href="do:uczelnia104B">2: [Powiedz, że tak naprawdę jesteście razem z Ewą.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia104A", =>
    game.lactivate(105)
    game.goto(105)
  game.pushAction "uczelnia104B", =>
    game.lactivate(106)
    game.goto(106)

#-----------U-3X---------105
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> To chyba cała historia. Czy nie mógłby mi pan Profesor pomóc?</i><br/><br/><a href="do:uczelnia105A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia105A", =>
    game.lactivate(94)
    game.goto(94)

#-----------U-3Y---------106
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ty:<i> Panie Profesorze, w jednej kwestii nie byłem szczery – tak naprawdę jesteśmy z Ewą razem. Nie chciałem o tym mówić, bałem się, że to skomplikuje naszą rozmowę.</i><br/><br/><a href="do:uczelnia106A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia106A", =>
    game.lactivate(107)
    game.goto(107)

#-----------U-3Z---------107
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Profesor wygląda na zaskoczonego twoimi słowami.<br/>Profesor:<i> Naprawdę nie rozumiem, po co uciekać się do takich wybiegów. Trzeba było prosto z mostu, że to pana dziewczyna. Ech…</i><br/><br/><a href="do:uczelnia107A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia107A", =>
    game.lactivate(101)
    game.goto(101)

#--------------------------
#---UNIWERSYTET-ONIRYCZNY--
#----------UO-1A---------108
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Otwierasz oczy i z trudem przyzwyczajasz się do oślepiającej bieli otoczenia. Wszędzie wokół ciebie pustka. Dopiero gdy otrząsasz się z szoku dostrzegasz kilkanaście kroków przed sobą coś w kształcie szpitalnego łóżka. Co więcej, wydaje się, że ktoś na nim leży. Chcesz dokładniej się temu przyjrzeć, więc podchodzisz kilka kroków do przodu.<br/><br/><a href="do:uczelnia108A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia108A", =>
    game.lactivate(109)
    game.goto(109)

#----------UO-1B---------109
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kiedy podchodzisz, ze zdziwieniem stwierdzasz, że na szpitalnym łóżku leży Ewa. W twojej ręce nieoczekiwanie materializuje się skalpel – nabierasz pewności, że musisz rozciąć jej ciało, by cała sytuacja nabrała SENSU.<br/><br/><a href="do:uczelnia109A">1: [Spróbuj płytkiego poziomego, wręcz naskórkowego nacięcia.]</a><br/><a href="do:uczelnia109B">2: [Spróbuj silnego głębokiego cięcia.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia109A", =>
    game.lactivate(110)
    game.goto(110)
  game.pushAction "uczelnia109B", =>
    game.state(120, 'b')
    game.lactivate(134)
    game.goto(134)

#----------UO-2A---------110
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Tniesz bardzo płytko, ledwie nacinasz naskórek, ale pewnie prowadzisz skalpel przez całe ciało dziewczyny. Kiedy łapiesz za obydwa brzegi rany i delikatnie je rozchylasz, masz wrażenie, jakbyś przed chwilą potknął się i spadał w czeluść bezdennej jamy lub nory. Na moment miga ci twarz poważnego dżentelmena, który wydaje się kiwać potakująco głową, ale nie jesteś pewny, czy się to nie było tylko przewidzenie.<br/><br/><a href="do:uczelnia110A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia110A", =>
    Flagi.temp = 6
    game.lactivate(111)
    game.goto(111)

#----------UO-2B---------111
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Lądujesz w pomieszczeniu z niewielkimi drzwiami, nie większymi niż jedna stopa. Nie ma możliwości, byś dał radę przejść przez te drzwi – masz jakiś sążeń wzrostu! Na stoliku dostrzegasz dwa ciasteczka z karteczkami. Podchodzisz i bierzesz je do ręki.<br/><br/><a href="do:uczelnia111A">1: [Ugryź mniejsze ciasteczko (na karteczce napis – malejesz o łokieć)]</a><br/><a href="do:uczelnia111B">2: [Ugryź większe ciasteczko (na karteczce napis – rośniesz o stopę)]</a>'
      })
    },
  }))
  game.pushAction "uczelnia111A", =>
    game.state(112, 'a')
    game.state(113, 'a')
    Flagi.temp = Flagi.temp - 2
    game.lactivate(112)
    game.goto(112)
  game.pushAction "uczelnia111B", =>
    game.state(112, 'a')
    game.state(113, 'a')
    Flagi.temp = Flagi.temp + 1
    game.lactivate(113)
    game.goto(113)

#----------UO-2C---------112
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'aMalejesz o łokieć.<br/><br/><a href="do:uczelnia112A">1: [Ugryź mniejsze ciasteczko (na karteczce napis – malejesz o łokieć)]</a><br/><a href="do:uczelnia112B">2: [Ugryź większe ciasteczko (na karteczce napis – rośniesz o stopę)]</a>'
      }),
      b: new LocationState({
        text: 'bMalejesz o łokieć.<br/><br/><a href="do:uczelnia112C">1: [Ugryź mniejsze ciasteczko (na karteczce napis – malejesz o łokieć)]</a><br/><a href="do:uczelnia112D">2: [Ugryź większe ciasteczko (na karteczce napis – rośniesz o stopę)]</a>'
      }),
      c: new LocationState({
        text: 'cMalejesz o łokieć.<br/><br/><a href="do:uczelnia112E">1: [Ugryź mniejsze ciasteczko (na karteczce napis – malejesz o łokieć)]</a><br/><a href="do:uczelnia112F">2: [Ugryź większe ciasteczko (na karteczce napis – rośniesz o stopę)]</a>'
      })
    },
  }))
  game.pushAction "uczelnia112A", =>
    Flagi.temp = Flagi.temp - 2
    if Flagi.temp == 1
      game.lactivate(114)
      game.goto(114)
    else
      if Flagi.temp > 0
        game.lactivate(112)
        game.goto(112)
      else
        Flagi.temp = 0
        game.lactivate(116)
        game.goto(116)      
  game.pushAction "uczelnia112B", =>
    Flagi.temp = Flagi.temp + 1
    if Flagi.temp == 1
      game.lactivate(114)
      game.goto(114)
    else
      if Flagi.temp < 18
        game.lactivate(113)
        game.goto(113)
      else
        Flagi.temp = 0
        game.lactivate(117)
        game.goto(117)
  game.pushAction "uczelnia112C", =>
    Flagi.temp = Flagi.temp - 2
    if Flagi.temp > 11 and Flagi.temp < 18
      game.lactivate(115)
      game.goto(115)
    else
      if Flagi.temp > 0
        game.lactivate(112)
        game.goto(112)
      else
        Flagi.temp = 0
        game.lactivate(116)
        game.goto(116)      
  game.pushAction "uczelnia112D", =>
    Flagi.temp = Flagi.temp + 1
    if Flagi.temp > 11 and Flagi.temp < 18
      game.lactivate(115)
      game.goto(115)
    else
      if Flagi.temp < 18
        game.lactivate(113)
        game.goto(113)
      else
        Flagi.temp = 0
        game.lactivate(117)
        game.goto(117)
  game.pushAction "uczelnia112E", =>
    Flagi.temp = Flagi.temp - 2
    if Flagi.temp == 1
      game.lactivate(119)
      game.goto(119)
    else
      if Flagi.temp > 0
        game.lactivate(112)
        game.goto(112)
      else
        Flagi.temp = 0
        game.lactivate(116)
        game.goto(116)      
  game.pushAction "uczelnia112F", =>
    Flagi.temp = Flagi.temp + 1
    if Flagi.temp == 1
      game.lactivate(119)
      game.goto(119)
    else
      if Flagi.temp < 18
        game.lactivate(113)
        game.goto(113)
      else
        Flagi.temp = 0
        game.lactivate(117)
        game.goto(117)   

#----------UO-2D---------113
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'aRośniesz o stopę. <br/><br/><a href="do:uczelnia113A">1: [Ugryź mniejsze ciasteczko (na karteczce napis – malejesz o łokieć)]</a><br/><a href="do:uczelnia113B">2: [Ugryź większe ciasteczko (na karteczce napis – rośniesz o stopę)]</a>'
      }),
      b: new LocationState({
        text: 'bRośniesz o stopę. <br/><br/><a href="do:uczelnia113C">1: [Ugryź mniejsze ciasteczko (na karteczce napis – malejesz o łokieć)]</a><br/><a href="do:uczelnia113D">2: [Ugryź większe ciasteczko (na karteczce napis – rośniesz o stopę)]</a>'
      }),
      c: new LocationState({
        text: 'cRośniesz o stopę. <br/><br/><a href="do:uczelnia113E">1: [Ugryź mniejsze ciasteczko (na karteczce napis – malejesz o łokieć)]</a><br/><a href="do:uczelnia113F">2: [Ugryź większe ciasteczko (na karteczce napis – rośniesz o stopę)]</a>'
      })
    },
  }))
  game.pushAction "uczelnia113A", =>
    Flagi.temp = Flagi.temp - 2
    if Flagi.temp == 1
      game.lactivate(114)
      game.goto(114)
    else
      if Flagi.temp > 0
        game.lactivate(112)
        game.goto(112)
      else
        Flagi.temp = 0
        game.lactivate(116)
        game.goto(116)      
  game.pushAction "uczelnia113B", =>
    Flagi.temp = Flagi.temp + 1
    if Flagi.temp == 1
      game.lactivate(114)
      game.goto(114)
    else
      if Flagi.temp < 18
        game.lactivate(113)
        game.goto(113)
      else
        Flagi.temp = 0
        game.lactivate(117)
        game.goto(117)
  game.pushAction "uczelnia113C", =>
    Flagi.temp = Flagi.temp - 2
    if Flagi.temp > 11 and Flagi.temp < 18
      game.lactivate(115)
      game.goto(115)
    else
      if Flagi.temp > 0
        game.lactivate(112)
        game.goto(112)
      else
        Flagi.temp = 0
        game.lactivate(116)
        game.goto(116)      
  game.pushAction "uczelnia113D", =>
    Flagi.temp = Flagi.temp + 1
    if Flagi.temp > 11 and Flagi.temp < 18
      game.lactivate(115)
      game.goto(115)
    else
      if Flagi.temp < 18
        game.lactivate(113)
        game.goto(113)
      else
        Flagi.temp = 0
        game.lactivate(117)
        game.goto(117)
  game.pushAction "uczelnia113E", =>
    Flagi.temp = Flagi.temp - 2
    if Flagi.temp == 1
      game.lactivate(119)
      game.goto(119)
    else
      if Flagi.temp > 0
        game.lactivate(112)
        game.goto(112)
      else
        Flagi.temp = 0
        game.lactivate(116)
        game.goto(116)      
  game.pushAction "uczelnia113F", =>
    Flagi.temp = Flagi.temp + 1
    if Flagi.temp == 1
      game.lactivate(119)
      game.goto(119)
    else
      if Flagi.temp < 18
        game.lactivate(113)
        game.goto(113)
      else
        Flagi.temp = 0
        game.lactivate(117)
        game.goto(117)

#----------UO-2E---------114
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Hurra! Masz wreszcie około stopy wzrostu, uda ci się przejść przez drzwi. Podchodzisz i szarpiesz za klamkę, ale okazuje się, że są zamknięte. Spoglądasz w górę i dostrzegasz zawieszony na sznurku klucz. Niestety, co najmniej na wysokości dwóch sążni!<br/><br/><a href="do:uczelnia114A">1: [Ugryź mniejsze ciasteczko (na karteczce napis – malejesz o łokieć)]</a><br/><a href="do:uczelnia114B">2: [Ugryź większe ciasteczko (na karteczce napis – rośniesz o stopę)]</a>'
      })
    },
  }))
  game.pushAction "uczelnia114A", =>
    Flagi.temp = 0
    game.lactivate(116)
    game.goto(116)
  game.pushAction "uczelnia114B", =>
    Flagi.temp = 2
    game.state(112, 'b')
    game.state(113, 'b')
    game.lactivate(113)
    game.goto(113)

#----------UO-2F---------115
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Udało ci się dosięgnąć klucza. Teraz trzeba znów się zmniejszyć.<br/><br/><a href="do:uczelnia115A">1: [Ugryź mniejsze ciasteczko (na karteczce napis – malejesz o łokieć)]</a><br/><a href="do:uczelnia115B">2: [Ugryź większe ciasteczko (na karteczce napis – rośniesz o stopę)]</a>'
      })
    },
  }))
  game.pushAction "uczelnia115A", =>
    Flagi.temp = Flagi.temp - 2
    game.state(112, 'c')
    game.state(113, 'c')
    game.lactivate(112)
    game.goto(112)
  game.pushAction "uczelnia115B", =>
    Flagi.temp = Flagi.temp + 1
    game.state(112, 'c')
    game.state(113, 'c')
    game.lactivate(113)
    game.goto(113)

#----------UO-2G---------116
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'O nie! Zmalałeś do zera! Świat wokół ciebie wiruje ci przed oczami.<br/><br/><a href="do:uczelnia116A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia116A", =>
    game.lactivate(118)
    game.goto(118)

#----------UO-2H---------117
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'O nie! Jesteś już tak wysoki, ze przebijasz głową sufit! Świat wokół ciebie wiruje ci przed oczami.<br/><br/><a href="do:uczelnia117A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia117A", =>
    game.lactivate(118)
    game.goto(118)

#----------UO-2I---------118
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wizja powoli się kończy, czujesz narastający w głowie szum, przez chwilę mrugasz oczami, by przyzwyczaić się do światła.<br/><br/><a href="do:uczelnia118A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "uczelnia118A", =>
    game.lactivate(0)
    game.goto(0)

#----------UO-2J---------119
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Przechodzisz przez drzwi, za którymi spodziewasz się odnaleźć SENS tego wszystkiego.Przechodzisz przez drzwi, za którymi spodziewasz się odnaleźć SENS tego wszystkiego.<br/><br/><a href="do:uczelnia119A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia119A", =>
    game.lactivate(120)
    game.goto(120)

#----------UO-2K/3B------120
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Przy wielkim, nakrytym białym obrusem stole siedzą Zając,  Suseł i Kapelusznik. Ilość naczyń na stole świadczy o tym, że muszą czekać na ciebie już od dłuższego czasu.<br/><br/><a href="do:uczelnia120A">1: [Podejdź do Zająca.]</a><br/><a href="do:uczelnia120B">2: [Podejdź do Susła.]</a><br/><a href="do:uczelnia120C">3: [Podejdź do Kapelusznika.]</a>'
      }),
      b: new LocationState({
        text: 'Znajdujesz się teraz w niewielkim, ale zapełnionym po brzegi TYM i OWYM sklepiku. Za ladą stoi Elegancko Wyglądająca Owca.<br/>Elegancko Wyglądająca Owca: <i>Proszę, zapraszam, niech się szanowny dobrodziej rozejrzy! Jestem do usług.</i><br/><br/><a href="do:uczelnia120D">1: [Obejrzyj towar na półkach.]</a><br/><a href="do:uczelnia120E">2: [Obejrzyj towar w głębi sklepu.]</a><br/><a href="do:uczelnia120F">3: [Podejdź do lady.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia120A", =>
    game.lactivate(121)
    game.goto(121)
  game.pushAction "uczelnia120B", =>
    game.lactivate(122)
    game.goto(122)
  game.pushAction "uczelnia120C", =>
    game.lactivate(123)
    game.goto(123)
  game.pushAction "uczelnia120D", =>
    game.lactivate(135)
    game.goto(135)
  game.pushAction "uczelnia120E", =>
    game.lactivate(136)
    game.goto(136)
  game.pushAction "uczelnia120F", =>
    game.lactivate(137)
    game.goto(137)

#----------UO-2L---------121
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podchodzisz do Zająca, choć nie jesteś przekonany, czy to było SENSOWNE posunięcie.<br/>Zając: <i>Tak, tak! Dobrze, mam TO, czego szukasz! Wiem, mam! Zagramy w grę, dobrze? Wkładam TO pod filiżankę, a ty znajdujesz lub nie znajdujesz! Masz trzy próby!</i><br/><br/><a href="do:uczelnia121A">1: [Zagraj z Zającem]</a><br/><a href="do:uczelnia121B">2: [Nie graj z Zającem]</a>'
      })
    },
  }))
  game.pushAction "uczelnia121A", =>
    game.lactivate(124)
    game.goto(124)
  game.pushAction "uczelnia121B", =>
    game.lactivate(120)
    game.goto(120)

#----------UO-2M---------122
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podchodzisz do Susła, który wydaje się drzemać na stole. Trzyma przy tym w łapce pękniętą filiżankę, z której, jakimś cudem, nie wylewa się herbata. Nie jesteś pewien, czy to bezsensowne, czy absurdalne.<br/><br/><a href="do:uczelnia122A">1: [Zostaw Susła w spokoju.]</a><br/><a href="do:uczelnia122B">2: [Spróbuj obudzić Susła.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia122A", =>
    game.lactivate(120)
    game.goto(120)
  game.pushAction "uczelnia122B", =>
    game.lactivate(127)
    game.goto(127)

#----------UO-2N---------123
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podchodzisz do Kapelusznika, który dosypuje właśnie kawy do filiżanki wypełnionej cukrem. Nie zauważa cię od razu, gdy podchodzisz, ale kiedy odzywa się wreszcie, odnosisz wrażenie, że po prostu nie podszedłeś od razu, gdy cię zauważył.<br/>Kapelusznik: <i>Dobrze się składa, bo jestem już po słowie z TYM, więc wypada świętować! Dobrodzieju, proponuję, co następuje: odstąpię ci TO, jeżeli tylko chcesz lub opowiem o TYM i wyjdziesz z TEGO obronną ręką.</i><br/><br/><a href="do:uczelnia123A">1: [Weź TO.]</a><br/><a href="do:uczelnia123B">2: [Posłuchaj o TYM.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia123A", =>
    game.lactivate(132)
    game.goto(132)
  game.pushAction "uczelnia123B", =>
    game.lactivate(133)
    game.goto(133)

#----------UO-2O---------124
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Zając wkłada TO szybkim ruchem pod jedną z filiżanek. Następnie wielokrotnie przestawia je, tak, by cię zmylić. Na początku udaje ci się śledzić jego ruchy – interesowała cię środkowa filiżanka, która następnie przesunęła się na lewo, potem na prawo, by wreszcie znowu znaleźć się na środku, ale po chwili ruchy Zająca stały się tak szybkie, że zupełnie straciłeś orientację.<br/><br/><a href="do:uczelnia124ABC">1: [Wybierz filiżankę stojącą po lewej.]</a><br/><a href="do:uczelnia124ABC">2: [Wybierz filiżankę stojącą po prawej.]</a><br/><a href="do:uczelnia124ABC">3: [Wybierz filiżankę stojącą na środku.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia124ABC", =>
    game.lactivate(125)
    game.goto(125)

#----------UO-2P---------125
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wybierasz filiżankę, ale pod spodem niczego nie ma. Zając patrzy na ciebie z zaciekawieniem.<br/><br/><a href="do:uczelnia125ABC">1: [Wybierz filiżankę stojącą po lewej.]</a><br/><a href="do:uczelnia125ABC">2: [Wybierz filiżankę stojącą po prawej.]</a><br/><a href="do:uczelnia125ABC">3: [Wybierz filiżankę stojącą na środku.]</a>'
      })
      b: new LocationState({
        text: 'Wybierasz filiżankę, ale pod spodem niczego nie ma. Zając patrzy na ciebie z zaciekawieniem.<br/><br/><a href="do:uczelnia125DEF">1: [Wybierz filiżankę stojącą po lewej.]</a><br/><a href="do:uczelnia125DEF">2: [Wybierz filiżankę stojącą po prawej.]</a><br/><a href="do:uczelnia125DEF">3: [Wybierz filiżankę stojącą na środku.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia125ABC", =>
    game.state(125, 'b')
    game.lactivate(125)
    game.goto(125)
  game.pushAction "uczelnia125DEF", =>
    game.state(125, 'a')
    game.lactivate(126)
    game.goto(126)

#----------UO-2R---------126
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wybierasz filiżankę, ale pod spodem niczego nie ma. Jesteś tak zły, że przetrząsasz wszystkie leżące na stole naczynia w poszukiwaniu TEGO, co ukrył Zając. Nie znajdujesz TEGO jednak ani w imbryczkach, ani pod filiżankami i talerzami pełnymi herbatników. Dajesz Zającowi spokój.<br/><br/><a href="do:uczelnia126A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia126A", =>
    game.lactivate(120)
    game.goto(120)

#----------UO-2S---------127
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Potrząsasz Susłem, by choć na chwilę się obudził.<br/>Suseł: <i>Hm, mrugaj, mrugaj, mrugaj… Tak? A, tak! Wiem, wiem, przyśniło mi się TO przed chwilą. Zaczekaj, zmrużę na chwilę oczy, przypomnę TO sobie i zaraz ci opowiem!</i><br/><br/><a href="do:uczelnia127A">1: [Odejdź od Susła.]</a><br/><a href="do:uczelnia127B">2: [Pozwól mu zdrzemnąć się chwilę.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia127A", =>
    game.lactivate(120)
    game.goto(120)
  game.pushAction "uczelnia127B", =>
    game.lactivate(128)
    game.goto(128)

#----------UO-2SA--------128
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Czekasz chwilę, ale gdy słyszysz, że Suseł zaczyna chrapać w najlepsze, znów nim potrząsasz.<br/>Suseł: <i>Tak, tak, TO było całkiem SENSOWNE! Zaczekaj jeszcze chwilę, wpadnę w głębszy sen i już na pewno wszystko zrozumiem!</i><br/><br/><a href="do:uczelnia128A">1: [Odejdź od Susła.]</a><br/><a href="do:uczelnia128B">2: [Pozwól mu zdrzemnąć się chwilę.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia128A", =>
    game.lactivate(120)
    game.goto(120)
  game.pushAction "uczelnia128B", =>
    game.lactivate(129)
    game.goto(129)

#----------UO-2SB--------129
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Czekasz chwilę, ale gdy słyszysz, że Suseł zaczyna chrapać w najlepsze, znów nim potrząsasz.<br/>Suseł: <i>Czekaj, czekaj, TO brzmiało całkiem sensownie, ale kiedy się budzę, ciężko mi TO wytłumaczyć… Pozwól mi zmrużyć oczy jeszcze na chwilę, a tym razem na pewno się uda!</i><br/><br/><a href="do:uczelnia129A">1: [Odejdź od Susła.]</a><br/><a href="do:uczelnia129B">2: [Pozwól mu zdrzemnąć się chwilę.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia129A", =>
    game.lactivate(120)
    game.goto(120)
  game.pushAction "uczelnia129B", =>
    game.lactivate(130)
    game.goto(130)

#----------UO-2SC--------130
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Czekasz chwilę, ale gdy słyszysz, że Suseł zaczyna chrapać w najlepsze, znów nim potrząsasz.<br/>Suseł: <i>TO nie do wiary! Prawie TO miałem. TO jednak nie takie proste. Może przyśni mi się TO raz jeszcze. Zaczekaj chwilkę…</i><br/><br/><a href="do:uczelnia130A">1: [Odejdź od Susła.]</a><br/><a href="do:uczelnia130B">2: [Pozwól mu zdrzemnąć się chwilę.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia130A", =>
    game.lactivate(120)
    game.goto(120)
  game.pushAction "uczelnia130B", =>
    game.lactivate(131)
    game.goto(131)

#----------UO-2SD--------131
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Czekasz chwilę, ale gdy słyszysz, że Suseł zaczyna chrapać w najlepsze, znów nim potrząsasz.<br/>Suseł: <i>Ciężko TO wytłumaczyć… Chyba muszę przespać się z TYM, może później ci pomogę.</i><br/><br/><a href="do:uczelnia131A">1: [Odejdź od Susła.]</a><br/><a href="do:uczelnia131B">2: [Pozwól mu zdrzemnąć się chwilę.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia131A", =>
    game.lactivate(120)
    game.goto(120)
  game.pushAction "uczelnia131B", =>
    game.lactivate(131)
    game.goto(131)

#----------UO-2T---------132
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Decydujesz się wziąć TO. Kapelusznik kiwa głową i wręcza ci niewielki pakunek. Kiedy rozrywasz papier, okazuje się, że w środku znajduje się intrygująco wyglądająca kurtka z wężowej skóry.<br/><br/><a href="do:uczelnia132A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia132A", =>
    game.lactivate(146)
    game.goto(146)

#----------UO-2U---------133
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Decydujesz się, by Kapelusznik opowiedział ci o TYM. Ten dłuższą chwilę milczy i zapisuje coś na kartce, którą następnie Ci wręcza. Odczytujesz zapisane drżącą ręką słowa: „Sowy nie są TYM, czym się wydają.”<br/><br/><a href="do:uczelnia133A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia133A", =>
    game.lactivate(146)
    game.goto(146)

#----------UO-3A---------134
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Tniesz tak głęboko, jakbyś tym cięciem starał się dotrzeć do SENSU tej sytuacji. Skalpel przechodzi przez kolejne warstwy skóry, kości i narządy, a ty masz wrażenie jakbyś przed chwilą potknął się i spadał w czeluść bezdennej jamy lub nory. Na moment miga ci twarz poważnego dżentelmena, który wydaje się kiwać przecząco głową, ale nie jesteś pewny, czy się to nie było tylko przewidzenie.<br/><br/><a href="do:uczelnia134A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia134A", =>
    game.lactivate(111)
    game.goto(111)

#----------UO-3C---------135
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podchodzisz do półek, które wydają się być zapełnione po brzegi. Kątem oka dostrzegasz na jednej z najniższych półek coś, co wygląda SENSOWNIE. Kiedy spoglądasz w tamtą stronę, owo coś znika, ale wydaje ci się, że znajduje się teraz półkę wyżej.<br/><br/><a href="do:uczelnia135A">1: [Odejdź od półek.]</a><br/><a href="do:uczelnia135B">2: [Spójrz wyżej.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia135A", =>
    game.lactivate(120)
    game.goto(120)
  game.pushAction "uczelnia135B", =>
    Flagi.temp = 1
    game.lactivate(138)
    game.goto(138)

#----------UO-3D---------136
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Idziesz w głąb sklepu, w nadziei, że tam znajdziesz coś SENSOWNEGO. Wszędzie znajduje się pełno bibelotów, ale twoją uwagę przyciąga Dżentelmen w Cieniu. Gestem wskazuje ci, byś podszedł bliżej.<br/><br/><a href="do:uczelnia136A">1: [Podejdź do Dżentelmena w Cieniu.]</a><br/><a href="do:uczelnia136B">2: [Cofnij się.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia136A", =>
    game.lactivate(140)
    game.goto(140)
  game.pushAction "uczelnia136B", =>
    game.lactivate(120)
    game.goto(120)

#----------UO-3E---------137
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podchodzisz do lady, przy której stoi Elegancko Wyglądająca Owca. Nie rozmawiałeś nigdy z owcą, która prowadziłaby sklep. Z drugiej strony, w ogóle niewiele rozmawiałeś z owcami, więc po chwili stwierdzasz, że SENSOWNIEJ byłoby powiedzieć, że po prostu słabo znasz owce.<br/>Elegancko Wyglądająca Owca: <i>Panie dobrodzieju, słowo daję, że akurat przed chwilą przyszło do mnie coś SENSOWNEGO, akurat dla pana! Musi pan wybrać – mam przedmiot, którego SENS może panu pomóc albo pytanie, które, gdy na nie odpowiedzieć, może nadać panu SENS!</i><br/><br/><a href="do:uczelnia137A">1: [Wybierz przedmiot.]</a><br/><a href="do:uczelnia137B">2: [Wybierz pytanie.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia137A", =>
    game.lactivate(144)
    game.goto(144)
  game.pushAction "uczelnia137B", =>
    game.lactivate(145)
    game.goto(145)

#----------UO-3F---------138
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Przenosisz wzrok na wyższą półkę, ale błyskawicznie owo coś przenosi się jeszcze wyżej, a tam, gdzie patrzysz nie ma już niczego.<br/><br/><a href="do:uczelnia138A">1: [Spójrz wyżej.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia138A", =>
    Flagi.temp = Flagi.temp + 1
    if Flagi.temp == 10
      Flagi.temp = 0
      game.lactivate(139)
      game.goto(139)
    else
      game.lactivate(138)
      game.goto(138)

#----------UO-3G---------139
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Nie widzisz SENSU w tej absurdalnej zabawie. Odchodzisz od półek.<br/><br/><a href="do:uczelnia139A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia139A", =>
    game.lactivate(120)
    game.goto(120)

#----------UO-3H---------140
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Dżentelmen w Cieniu: <i>Ciężko znaleźć tutaj cokolwiek SENSOWNEGO, prawda? Znam taką piosenkę, której SENS może ci pomóc. Musisz tylko zrozumieć jej tytuł. Nazywa się on „Środek tygodnia”. Czy mnie rozumiesz?</i><br/><br/><a href="do:uczelnia140ABC">1: [Zapytaj, czy tak brzmi tytuł piosenki.]</a><br/><a href="do:uczelnia140ABC">2: [Zapytaj, czy tak nazywa się piosenka.]</a><br/><a href="do:uczelnia140ABC">3: [Zapytaj, czy to tytuł piosenki.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia140ABC", =>
    game.lactivate(141)
    game.goto(141)

#----------UO-3I---------141
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Dżentelmen w Cieniu: <i>Nic nie rozumiesz! „Środek tygodnia” to tylko nazwa tytułu piosenki! Sama piosenka nazywa się „Wąż znający grekę”.</i><br/><br/><a href="do:uczelnia141ABC">1: [Zapytaj, czy tak brzmi tytuł piosenki.]</a><br/><a href="do:uczelnia141ABC">2: [Zapytaj, czy to nazwa tytułu piosenki.]</a><br/><a href="do:uczelnia141ABC">3: [Zapytaj, czy to tytuł piosenki.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia141ABC", =>
    game.lactivate(142)
    game.goto(142)

#----------UO-3J---------142
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Dżentelmen w Cieniu: <i>Gadasz bez SENSU! To nie ma nic wspólnego z tytułem! Tytuł to „Gorycz życia”.</i><br/><br/><a href="do:uczelnia142ABC">1: [Zapytaj, czy to sens tytułu.]</a><br/><a href="do:uczelnia142ABC">2: [Zapytaj, czy to nazwa piosenki.]</a><br/><a href="do:uczelnia142ABC">3: [Zapytaj, czy tak brzmi tytuł piosenki.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia142ABC", =>
    game.lactivate(143)
    game.goto(143)

#----------UO-3K---------143
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Dżentelmen w Cieniu: <i>Wszystko pomieszałeś! Tak się tylko nazywa tytuł piosenki… Jej SENS jest zupełnie gdzie indziej! Chyba się nie dogadamy…</i><br/><br/><a href="do:uczelnia143A">1: [Spróbuj jeszcze raz.]</a><br/><a href="do:uczelnia143B">2: [Odejdź od Dżentelmena w Cieniu.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia143A", =>
    game.lactivate(140)
    game.goto(140)
  game.pushAction "uczelnia143B", =>
    game.lactivate(120)
    game.goto(120)

#----------UO-3L---------144
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wybierasz przedmiot, a Elegancko Wyglądająca Owca podaje ci parę gustownych białych rękawiczek z koźlej skóry.<br/>Elegancko Wyglądająca Owca: <i>Proszę się tym dobrze zaopiekować, bo pamiętam kogoś, kto je zgubił!</i><br/><br/><a href="do:uczelnia144A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia144A", =>
    game.lactivate(146)
    game.goto(146)

#----------UO-3M---------145
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wybierasz pytanie, a Elegancko Wyglądająca Owca przypatruje ci się chwilę uważnie, po czym wyjmuje karteczkę, na której widzisz jakieś dziwne znaczki.<br/>Elegancko Wyglądająca Owca: <i>Wychodzi na to, dobrodzieju, że musi pan sobie odpowiedzieć na proste pytanie: „Kim jest John Galt?”.</i><br/><br/><a href="do:uczelnia145A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia145A", =>
    game.lactivate(146)
    game.goto(146)

#----------UO-4A---------146
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ciężko ci nadążyć za takim rozwojem wypadków, zamykasz oczy, by na chwilę pomyśleć. Kiedy jednak otwierasz je znów, widzisz, że wszystko wokół ciebie się zmieniło. Zwierzęta, karty i figury szachowe patrzą na ciebie zaskoczone, zupełnie tak, jakbyś przerwał przygotowanie czegoś bardzo ważnego. Po chwili podchodzi do ciebie Biały Królik.<br/>Biały Królik: <i>WSzanowny pan spóźniony, ale na szczęście jeszcze nie zaczęliśmy! Za chwilę startujemy! Rozumiem, że dobrodziej bierze udział w wyścigu?</i><br/><br/><a href="do:uczelnia146A">1: [Weź udział w wyścigu.]</a><br/><a href="do:uczelnia146B">2: [Nie bierz udziału w wyścigu.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia146A", =>
    game.lactivate(147)
    game.goto(147)
  game.pushAction "uczelnia146B", =>
    game.lactivate(118)
    game.goto(118)

#----------UO-4B---------147
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Pada sygnał do startu, widzisz, że wszyscy rozbiegają się na różne strony.<br/><br/><a href="do:uczelnia147ABC">1: [Biegnij w lewo.]</a><br/><a href="do:uczelnia147ABC">2: [Biegnij w prawo.]</a><br/><a href="do:uczelnia147ABC">3: [Biegnij prosto.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia147ABC", =>
    game.lactivate(148)
    game.goto(148)

#----------UO-4C---------148
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wyścig nabiera tempa. Wokół obok ciebie walet kier przyjmuje bezbłędnie zagrywkę, figury szachowe wykonują błyskawiczny nawrót, by kontynuować wyścig stylem motylkowym. Kawałek dalej uśmiech bez kota żwawo drybluje pomiędzy zdezorientowanymi jaskółkami.<br/><br/><a href="do:uczelnia148ABC">1: [Przejmij pałeczkę od żaby.]</a><br/><a href="do:uczelnia148ABC">2: [Wbiegnij między ptaki, by uciec z pozycji spalonej.]</a><br/><a href="do:uczelnia148ABC">3: [Refuj foksztaksel, by uniknąć złamania masztu.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia148ABC", =>
    game.lactivate(149)
    game.goto(149)

#----------UO-4D---------149
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Przeczuwasz, że to ostatnie metry tego szaleńczego rajdu. Blisko ciebie pelikan, uderzając klinem, trafia piłeczką do dołka w trzecim uderzeniu, a tuż obok goniec ma już dwukrotną przewagę w pchełkach nad ubraną w wiktoriańską suknię kurą. Wydaje się, że szachom-cyklistom, do zakończenia rajdu pozostało tylko ukończenie etapu górskiego.<br/><br/><a href="do:uczelnia149ABC">1: [Zwód i mocne uderzenie zza pola karnego.]</a><br/><a href="do:uczelnia149ABC">2: [Wykonaj podwójny toeloop i zakończ kombinację rittbergerem.]</a><br/><a href="do:uczelnia149ABC">3: [Poproś o podwyższenie poprzeczki do 8.05 m i wykonaj swoją trzecią próbę.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia149ABC", =>
    game.lactivate(150)
    game.goto(150)

#----------UO-4E---------150
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wydaje się, że wyścig się już skończył, choć chyba nikt nie zna jego wyniku. Biały Królik podchodzi do ciebie po chwili, a wszyscy uczestnicy zabawy patrzą wyczekująco w twoją stronę.<br/>Biały Królik: <i>Panie dobrodzieju, zagapiłem się zupełnie! Na szczęście, pan pewnie wie, jak to wszystko się skończyło. Proszę mi szybko powiedzieć!</i><br/><br/><a href="do:uczelnia150AB">1: [Powiedz, że wygrałeś.]</a><br/><a href="do:uczelnia150AB">2: [Powiedz, że przegrałeś.]</a><br/><a href="do:uczelnia150C">3: [Krzyknij „Gioconda!”.]</a>'
      })
    },
  }))
  game.pushAction "uczelnia150AB", =>
    game.lactivate(118)
    game.goto(118)
  game.pushAction "uczelnia150C", =>
    game.lactivate(151)
    game.goto(151)

#----------UO-4F---------151
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Biały Królik nie wydaje się specjalnie zaskoczony twoją odpowiedzią. Kiwa tylko głową i uśmiecha się przyjaźnie. Podaje ci zmiętą karteczkę, którą po chwili rozwijasz. Odczytujesz słowa zapisane pięknymi, ozdobnymi literami: „Contradictoria ad invicem idem significant”.<br/><br/><a href="do:uczelnia151A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "uczelnia151A", =>
    game.lactivate(118)
    game.goto(118)

#--------------------------------------

#--------RESTAURACJA----------
#------S1--1--------------152
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Ale tłok! Trudno tu będzie kogokolwiek znaleźć. Muszę się chyba rozejrzeć. Spróbuję się tu trochę pokręcić…<br/><br/><a href="do:restauracja152A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja152A", =>
    game.lactivate(153)
    game.goto(153)

#------S1--2--------------153
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner (podchodzi): <i>Dobry wieczór Panu! Niestety nie mamy wolnych stolików.</i><br/><br/><a href="do:restauracja153A">1: <i>Nie szkodzi – ja właściwie nie przyszedłem tutaj na kolację. Szukam kogoś.</i></a><br/><a href="do:restauracja153B">2: <i>Jak to nie ma wolnych miejsc? Mam tutaj rezerwację na nazwisko Paluch.</i>(kłamstwo)</a><br/><a href="do:restauracja153C">3: <i>Nic dziwnego – w całym Poznaniu nie ma drugiej takiej restauracji. Mogę przynajmniej zamówić coś na wynos? Bardzo mi zależy. Co dzisiaj polecacie?</i></a>'
      })
    },
  }))
  game.pushAction "restauracja153A", =>
    game.lactivate(154)
    game.goto(154)
  game.pushAction "restauracja153B", =>
    game.lactivate(157)
    game.goto(157)
  game.pushAction "restauracja153C", =>
    game.lactivate(160)
    game.goto(160)

#------S1--2.1------------154
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>W restauracji? Był Pan z kimś umówiony?</i><br/><br/><a href="do:restauracja154A">1: <i>Tak – rozejrzę się po lokalu.</i></a><br/><a href="do:restauracja154B">2: <i>Właściwie nie… może widział Pan tu dzisiaj piękną kobietę: brunetę, dosyć wysoką, z zielonymi oczami?</i></a>'
      })
    },
  }))
  game.pushAction "restauracja154A", =>
    game.lactivate(162)
    game.goto(162)
  game.pushAction "restauracja154B", =>
    game.lactivate(155)
    game.goto(155)

#------S1--2.1.2----------155
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Nie wiem. Wszystkie kobiety są takie same. Wybaczy Pan, ale mam ważniejsze obowiązki.</i><br/><br/><a href="do:restauracja155A">1: <i>Rozumiem. Proszę się mną nie przejmować. Dam sobie radę</i></a><br/><a href="do:restauracja155B">2: <i>Pan zapomniał, że jest kelnerem? Przyzwyczaiłem się do lepszego traktowania klientów. Może dobrze, że się Pan nie przyzwyczaja do roli kelnera. Pański przełożony…</i></a>'
      })
    },
  }))
  game.pushAction "restauracja155A", =>
    game.lactivate(162)
    game.goto(162)
  game.pushAction "restauracja155B", =>
    game.lactivate(156)
    game.goto(156)

#------S1--2.1.2.2--------156
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Spokojnie! Nikogo takiego tu dzisiaj nie było, przykro mi… stolik się zwolnił – może jednak pan usiądzie?</i><br/><br/><a href="do:restauracja156A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja156A", =>
    game.lactivate(180)
    game.goto(180)

#------S1--2.2------------157
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner (sprawdzając w zeszycie): <i>Bardzo mi przykro, ale nikt o takim nazwisku nie rezerwował u nas miejsca. Musiała zajść jakaś pomyłka…</i><br/><br/><a href="do:restauracja157A">1: <i>To niepoważne! Nie obchodzą mnie wasze pomyłki. Proszę mi natychmiast znaleźć stolik!</i></a><br/><a href="do:restauracja157B">2: <i>Co Pan proponuje?</i></a>'
      })
    },
  }))
  game.pushAction "restauracja157A", =>
    game.lactivate(158)
    game.goto(158)
  game.pushAction "restauracja157B", =>
    game.lactivate(159)
    game.goto(159)

#------S1--2.2.1----------158
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Spokojnie… znajdziemy gdzieś trochę miejsca i dostawimy Panu stolik z zaplecza.</i><br/><br/><a href="do:restauracja158A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja158A", =>
    game.lactivate(180)
    game.goto(180)

#------S1--2.2.2----------159
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Hy, może Pan poczekać. Niedługo jakieś miejsce powinno się zwolnić</i><br/><br/><a href="do:restauracja159A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja159A", =>
    game.lactivate(162)
    game.goto(162)

#------S1--2.3------------160
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Hy, może Pan poczekać. Niedługo jakieś miejsce powinno się zwolnić</i><br/><br/><a href="do:restauracja160A">1: <i>Świetnie, poproszę pierogi.</i></a>'
      })
    },
  }))
  game.pushAction "restauracja160A", =>
    game.lactivate(161)
    game.goto(161)

#------S1--2.3.1----------161
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Pierogi z kapustą i grzybami raz!</i><br/><br/><a href="do:restauracja161A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja161A", =>
    game.lactivate(162)
    game.goto(162)

#------S2--1--------------162
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Idąc wzdłuż sali, mijasz kolejne stoliki. Stara baba z dzieckiem, grupka młodych ludzi, kilka zakochanych par… wszystko miejski motłoch. Jej tu nie ma. Nagle dociera do ciebie nieprzyjemny zapach, idziesz dalej. Po kilku krokach czujesz już obrzydliwy smród… jakby ktoś się nie mył przez całe życie! Rozglądasz się. Jest! Jest źródło tego zapachu: kobieta w czerwonym, brudnym swetrze…<br/><br/><a href="do:restauracja162A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja162A", =>
    game.lactivate(163)
    game.goto(163)

#------S2--2--------------163
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kobieta: <i>Nie! Mam prawo tu być!</i><br/>Kelner: <i>Przykro mi, ale… ale żeby zostać w restauracji musi Pani coś zamówić.</i><br/><br/><a href="do:restauracja163A">1: <i>Gówno tam „zamówić”. Wypieprzaj stąd, bo śmierdzisz!</i></a><br/><a href="do:restauracja163B">2: <i>Dwie kawy, proszę!</i>[dosiądź się]</a><br/><a href="do:restauracja163C">3: <i>Proszę się grzeczniej zwracać do kobiety.</i></a>'
      })
    },
  }))
  game.pushAction "restauracja163A", =>
    game.lactivate(164)
    game.goto(164)
  game.pushAction "restauracja163B", =>
    game.lactivate(172)
    game.goto(172)
  game.pushAction "restauracja163C", =>
    game.lactivate(176)
    game.goto(176)

#------S2--2.1------------164
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Uspokój się, pan! Nie ma wolnych miejsc! Czego pan chcesz?</i><br/><br/><a href="do:restauracja164A">1: <i>Jak już Pan wyrzuci tę śmierdzącą babę, to się stolik zwolni.</i></a><br/><a href="do:restauracja164B">2: <i>Świeżego powietrza!</i></a>'
      })
    },
  }))
  game.pushAction "restauracja164A", =>
    game.lactivate(165)
    game.goto(165)
  game.pushAction "restauracja164B", =>
    game.lactivate(166)
    game.goto(166)

#------S2--2.1.1----------165
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>I tak Pan tu nie usiądzie… ktoś już opłacił ten stolik.</i> (do kobiety):<i> Zamawia Pani coś, albo wychodzi.</i><br/><br/><a href="do:restauracja165A">1: (głośno) <i>A Pana praca polega na wyrzucaniu ludzi za pieniądze?. Ile muszę zapłacić, żeby Pan kogoś dla mnie…</i></a><br/><a href="do:restauracja165B">2: <i>Tak, prosimy dwie kawy!</i> [dosiądź się]</a>'
      })
    },
  }))
  game.pushAction "restauracja165A", =>
    game.lactivate(167)
    game.goto(167)
  game.pushAction "restauracja165B", =>
    game.lactivate(168)
    game.goto(168)

#------S2--2.1.2----------166
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>To na zewnątrz niech pan poszuka, żegnam!</i><br/><br/><a href="do:restauracja166A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "restauracja166A", =>
    game.lactivate(0)
    game.goto(0)

#------S2--2.1.1.1--------167
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Pana w ramach promocji wyrzucę za darmo, żegnam!</i><br/><br/><a href="do:restauracja167A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "restauracja167A", =>
    game.lactivate(0)
    game.goto(0)

#------S2--2.1.1.2--------168
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner odchodzi zmieszany.<br/><br/><a href="do:restauracja168A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja168A", =>
    game.lactivate(169)
    game.goto(169)

#------S2--2.1.1.2.1------169
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kobieta: <i>Mimo wszystko dziękuję… nie mam pieniędzy, żeby cokolwiek kupić.</i><br/><br/><a href="do:restauracja169A">1: <i>Po co w takim razie przychodzi Pani do restauracji?</i></a>'
      })
    },
  }))
  game.pushAction "restauracja169A", =>
    game.lactivate(170)
    game.goto(170)

#------S2--2.1.1.2.1.1----170
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kobieta: <i>Nie wiem… lubię takie miejsca.</i><br/><br/><a href="do:restauracja170A">1: <i>Dam Pani 15 złotych, jeżeli Pani stąd pójdzie. Zje Pani coś w innej restauracji. To chyba żadna różnica?</i></a>'
      })
    },
  }))
  game.pushAction "restauracja170A", =>
    game.lactivate(171)
    game.goto(171)

#------S2--2.1.1.2.1.1.1--171
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kobieta: <i>Zgoda!</i><br/><br/><a href="do:restauracja171A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja171A", =>
    game.lactivate(180)
    game.goto(180)

#------S2--2.2------------172
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner odchodzi. Kobieta milczy.<br/><br/><a href="do:restauracja172A">1: <i>Dobra, zrobiłem to, żeby mieć stolik, ale nie chcę cię tutaj. Wypij kawę i pożegnajmy się, co? Gdyby nie ja i tak by cię już wywalili.</i></a>'
      })
    },
  }))
  game.pushAction "restauracja172A", =>
    game.lactivate(180)
    game.goto(180)

#------S2--2.2.1----------173
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kobieta: <i>Chcę tu zostać!</i><br/><br/><a href="do:restauracja173A">1: <i>Gówno mnie to obchodzi. I tak nie masz pieniędzy – spieprzaj stąd.</i></a><br/><a href="do:restauracja173B">2: <i>Dlaczego właściwie chcesz siedzieć w restauracji. I tak nic nie zamówisz. Nie masz pieniędzy.</i></a>'
      })
    },
  }))
  game.pushAction "restauracja173A", =>
    game.lactivate(174)
    game.goto(174)
  game.pushAction "restauracja173B", =>
    game.lactivate(175)
    game.goto(175)

#------S2--2.2.1.1--------174
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kobieta: <i>Byłam tu pierwsza, to mój stolik. Sam spieprzaj, bo zawołam obsługę.</i><br/><br/><a href="do:restauracja174A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "restauracja174A", =>
    game.lactivate(0)
    game.goto(0)

#------S2--2.2.1.2--------175
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kobieta: <i>Jestem bezdomna i nie mam gdzie pójść.</i><br/><br/><a href="do:restauracja175A">1: <i>Dam ci 15 złotych, jak stąd pójdziesz. Zjesz coś w innej restauracji.</i></a>'
      })
    },
  }))
  game.pushAction "restauracja175A", =>
    game.lactivate(171)
    game.goto(171)

#------S2--2.3------------176
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Nie pana interes. Muszę wykonywać swoje obowiązki.</i><br/><br/><a href="do:restauracja176A">1: <i>Pana obowiązkiem jest grzeczne traktowanie klientów.</i></a><br/><a href="do:restauracja176B">2: <i>Jak taki cham mógł zostać kelnerem?!</i></a>'
      })
    },
  }))
  game.pushAction "restauracja176A", =>
    game.lactivate(177)
    game.goto(177)
  game.pushAction "restauracja176B", =>
    game.lactivate(179)
    game.goto(179)

#------S2--2.3.1----------177
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Ona nie jest klientem! Nawet nic nie zamawia!</i><br/><br/><a href="do:restauracja177A">1: <i>To proszę nam podać dwie kawy</i>[dosiądź się]</a><br/><a href="do:restauracja177B">2: <i>Ja na przykład jestem klientem, więc może tak by się pan zajął najpierw mną? Może by mi pan znalazł jakiś stolik zamiast obrażać tę biedną kobietę?</i></a>'
      })
    },
  }))
  game.pushAction "restauracja177A", =>
    game.lactivate(172)
    game.goto(172)
  game.pushAction "restauracja177B", =>
    game.lactivate(178)
    game.goto(178)

#------S2--2.3.1.1--------178
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Jak mam panu znaleźć stolik? Nie ma wolnych stolików. Proszę nie zawracać głowy i iść do innej restauracji.</i><br/><br/><a href="do:restauracja178A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "restauracja178A", =>
    game.lactivate(0)
    game.goto(0)

#------S2--2.3.2----------179
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Przeszkadzasz mi pan w pracy. Idź pan stąd.</i><br/><br/><a href="do:restauracja179A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "restauracja179A", =>
    game.lactivate(0)
    game.goto(0)


#------S3--1--------------180
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Siedzisz sam przy stoliku, rozglądając się. W końcu postanawiasz zawołać kelnera.<br/><br/><a href="do:restauracja180A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja180A", =>
    game.lactivate(181)
    game.goto(181)

#------S3--2--------------181
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Tak, w czym mogę służyć?</i><br/><br/><a href="do:restauracja181A">1: <i>Co pan poleca?</i></a><br/><a href="do:restauracja181B">2: <i>Na razie chcę tylko się czegoś napić. Co macie?</i></a>'
      })
    },
  }))
  game.pushAction "restauracja181A", =>
    game.lactivate(182)
    game.goto(182)
  game.pushAction "restauracja181B", =>
    game.lactivate(185)
    game.goto(185)

#------S3--2.1------------182
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Daniem dnia są pierogi z kapustą i grzybami</i><br/><br/><a href="do:restauracja181A">1: <i>Nie, dziękuję… Właściwie chcę tylko coś do picia.</i></a><br/><a href="do:restauracja181B">2: <i>Świetnie, poproszę.</i></a>'
      })
    },
  }))
  game.pushAction "restauracja181A", =>
    game.lactivate(183)
    game.goto(183)
  game.pushAction "restauracja181B", =>
    game.lactivate(184)
    game.goto(184)

#------S3--2.1.1----------183
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Proponuję czerwone wino.</i><br/><br/><a href="do:restauracja183A">1: <i>Proszę podać.</i></a>'
      })
    },
  }))
  game.pushAction "restauracja183A", =>
    game.lactivate(186)
    game.goto(186)

#------S3--2.1.2----------184
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Yhy, czy podać coś do picia? Proponuję czerwone wino.</i><br/><br/><a href="do:restauracja184A">1: <i>Tak, poproszę.</i></a>'
      })
    },
  }))
  game.pushAction "restauracja184A", =>
    game.lactivate(186)
    game.goto(186)

#------S3--2.2------------185
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>Cola, Fanta, Sprite. Z alkoholi proponuję czerwone wino.</i><br/><br/><a href="do:restauracja185A">1: <i>Wino, proszę.</i></a>'
      })
    },
  }))
  game.pushAction "restauracja185A", =>
    game.lactivate(186)
    game.goto(186)

#------S3--3--------------186
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner odchodzi, po kilku minutach wraca z kieliszkiem wina na tacy. Podchodząc do ciebie, potyka się – zawartość kieliszka ląduje na twojej koszuli.<br/>Kelner: <i>Najmocniej przepraszam! Nie chciałem…</i><br/><br/><a href="do:restauracja186A">1: <i>Kurwa, ty idioto!</i></a><br/><a href="do:restauracja186B">2: <i>Trzeba to zaprać. Szybko, gdzie jest toaleta?</i></a>'
      })
    },
  }))
  game.pushAction "restauracja186A", =>
    game.lactivate(187)
    game.goto(187)
  game.pushAction "restauracja186B", =>
    game.lactivate(188)
    game.goto(188)

#------S3--3.1------------187
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Wybiegając z restauracji, przewracasz kelnera. Czujesz jednak, że zareagowałeś zbyt impulsywnie.<br/><br/><a href="do:restauracja187A">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "restauracja187A", =>
    game.lactivate(0)
    game.goto(0)

#------S3--3.2------------188
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelner: <i>2.3 Tam w lewo </i>(wskazuje ręką)<i>. Najmocniej przepraszam!</i><br/><br/><a href="do:restauracja188A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja188A", =>
    game.lactivate(189)
    game.goto(189)

#-----S3--4---------------189
  game.push(new Location({
    img: '/assets/game/PARK2.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Koszula wygląda już jako tako. Wychodzisz z łazienki, ale zamiast do sali restauracyjnej, wchodzisz do ciemnego pomieszczenia. Drzwi zamykają się za tobą, próbujesz znaleźć klamkę, ale ściana jest zupełnie gładka.<br/><br/><a href="do:restauracja189A">1: [Dalej]</a>'
      })
    },
  }))
  game.pushAction "restauracja189A", =>
    game.lactivate(190)
    game.goto(190)

#-----------1-----------190
  game.push(new Location({
    img: '/assets/obrazki/1czerwony.jpg',
    active: true,
    activeState: 'a',
    sound: 's0',
    states: {
      a: new LocationState({
        text: 'W tle dźwięk cyrku. Czy słyszysz?<br/><br/><a href="do:AKC_0_4">1: Tak</a><br/><a href="do:AKC_0_1">2: Nie</a>'
      })
    },
  }))
  game.pushAction "AKC_0_4", =>
    game.lactivate(194)
    game.goto(194)
  game.pushAction "AKC_0_1", =>
    game.lactivate(191)
    game.goto(191)
    
#--------1-1-----------191
  game.push(new Location({
    img: '/assets/obrazki/1czerwony.jpg',
    active: true,
    activeState: 'a',
    sound: 's0',
    states: {
      a: new LocationState({
        text: 'W tle dźwięk cyrku. Czy słyszysz?<br/><br/><a href="do:AKC_1_4">1: Tak</a><br/><a href="do:AKC_1_2">2: Nie</a>'
      })
    },
  }))
  game.pushAction "AKC_1_4", =>
    game.lactivate(194)
    game.goto(194)
  game.pushAction "AKC_1_2", =>
    game.lactivate(192)
    game.goto(192)

#--------1-2-----------192
  game.push(new Location({
    img: '/assets/obrazki/1czerwony.jpg',
    active: true,
    activeState: 'a',
    sound: 's0',
    states: {
      a: new LocationState({
        text: 'W tle dźwięk cyrku. Czy słyszysz?<br/><br/><a href="do:AKC_2_4">1: Tak</a><br/><a href="do:AKC_2_3">2: Nie</a>'
      })
    },
  }))
  game.pushAction "AKC_2_4", =>
    game.lactivate(194)
    game.goto(194)
  game.pushAction "AKC_2_3", =>
    game.lactivate(193)
    game.goto(193)


#--------1-3-----------193
  game.push(new Location({
    img: '/assets/obrazki/1czerwony.jpg',
    active: true,
    activeState: 'a',
    sound: 's0',
    states: {
      a: new LocationState({
        text: 'W tle nie słyszysz cyrku. Czy na pewno nie masz wyłączonych głośników?<br/><br/><a href="do:AKC_3_4">1: Słyszę. Żartowałem.</a><br/><a href="do:AKC_2_34">2: Nie mam. Nie słyszę. Nie mogę dalej iść.</a>'
      })
    },
  }))
  game.pushAction "AKC_3_4", =>
    game.lactivate(194)
    game.goto(194)
  game.pushAction "AKC_2_34", =>
    game.lactivate(0)
    game.goto(0)

#-------2-----------194
  game.push(new Location({
    img: '/assets/obrazki/2bialy.jpg',
    active: true,
    activeState: 'a',
    sound: 's1',
    states: {
      a: new LocationState({
        text: 'Wybierz to, co chcesz!<br/><br/><a href="do:AKC_4_5">1: Danie</a><br/><a href="do:AKC_4_6">2: Posiłek</a><br/><a href="do:AKC_4_11">3: Żarcie</a>'
      })
    },
  }))
  game.pushAction "AKC_4_5", =>
    game.lactivate(195)
    game.goto(195)
  game.pushAction "AKC_4_6", =>
    game.lactivate(196)
    game.goto(196)
  game.pushAction "AKC_4_11", =>
    game.lactivate(201)
    game.goto(201)

#--------2-1-----------195
  game.push(new Location({
    img: '/assets/obrazki/3czarny.jpg',
    active: true,
    activeState: 'a',
    sound: 's2',
    states: {
      a: new LocationState({
        text: 'Danie! Oszukanie. „Zgadnij na jaką literę jest moje imię: K, G, czy B?”<br/><br/><a href="do:AKC_5_7">1: K</a><br/><a href="do:AKC_5_7">2: G</a><br/><a href="do:AKC_5_7">3: B</a>'
      })
    },
  }))
  game.pushAction "AKC_5_7", =>
    game.lactivate(197)
    game.goto(197)

#--------2-2----------196
  game.push(new Location({
    img: '/assets/obrazki/3czarny.jpg',
    active: true,
    activeState: 'a',
    sound: 's2',
    states: {
      a: new LocationState({
        text: 'Posiłek! Oszukaniec. „Zgadnij na jaką literę jest moje imię: K, G, czy B?”<br/><br/><a href="do:AKC_6_7">1: K</a><br/><a href="do:AKC_6_7">2: G</a><br/><a href="do:AKC_6_7">3: B</a>'
      })
    },
  }))
  game.pushAction "AKC_6_7", =>
    game.lactivate(197)
    game.goto(197)

#--------3-----------197
  game.push(new Location({
    img: '/assets/obrazki/2bialy.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Hahaha, żadna z tych liter to nie jest prawidłowa odpowiedź. Jak szukałeś?<br/><br/><a href="do:AKC_7_8">1: Nacisnąłem byle jaką literę.</a><br/><a href="do:AKC_7_9">2: Po prostu wybrałem jakąkolwiek literkę, proszę Pani</a><br/><a href="do:AKC_7_34">3: Nie chcę już w to grać</a>'
      })
    },
  }))
  game.pushAction "AKC_7_8", =>
    game.lactivate(198)
    game.goto(198)
  game.pushAction "AKC_7_9", =>
    game.lactivate(199)
    game.goto(199)
  game.pushAction "AKC_7_34", =>
    game.lactivate(0)
    game.goto(0)

#--------3-1-----------198
  game.push(new Location({
    img: '/assets/obrazki/4czarnobialy.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Jak ze mną rozmawiasz? Zwróć się do mnie prawidłowo.<br/><br/><a href="do:AKC_8_9">1: Przepraszam, nie myślałem, że do Pani trzeba się zwracać</a><br/><a href="do:AKC_8_34">2: Nie chcę już w to grać</a>'
      })
    },
  }))
  game.pushAction "AKC_8_9", =>
    game.lactivate(199)
    game.goto(199)
  game.pushAction "AKC_8_34", =>
    game.lactivate(0)
    game.goto(0)

#--------4-----------199
  game.push(new Location({
    img: '/assets/obrazki/5bialy.jpg',
    active: true,
    activeState: 'a',
    sound: 's5',
    states: {
      a: new LocationState({
        text: 'O, już rozmawiasz ze mną. Więc co wybierasz? Pamiętaj co powiedziałam. Nie masz wyboru - musisz ze mną grać.<br/><br/><a href="do:AKC_9_10">1: Posiłek</a><br/><a href="do:AKC_9_11">2: Żarcie </a><br/><a href="do:AKC_9_10">3: Danie</a>'
      })
    },
  }))
  game.pushAction "AKC_9_10", =>
    game.lactivate(200)
    game.goto(200)
  game.pushAction "AKC_9_11", =>
    game.lactivate(201)
    game.goto(201)

#--------4-1----------200
  game.push(new Location({
    img: '/assets/obrazki/6fiolet.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Czy na pewno nie wybierzesz tego, co powiedziałam? <br/><br/><a href="do:AKC_10_34">1: Danie</a><br/><a href="do:AKC_10_11">2: Żarcie</a>'
      })
    },
  }))
  game.pushAction "AKC_10_34", =>
    game.lactivate(0)
    game.goto(0)
  game.pushAction "AKC_10_11", =>
    game.lactivate(201)
    game.goto(201)

#--------1-----------201
  game.push(new Location({
    img: '/assets/obrazki/7 - juz scena 2- bialy.jpg',
    active: true,
    activeState: 'a',
    sound: 's6',
    states: {
      a: new LocationState({
        text: 'Danie „żar”. Danie „cię”<br/><br/><a href="do:AKC_11_12">1: Żar</a><br/><a href="do:AKC_11_17">2: Cię</a>'
      })
    },
  }))
  game.pushAction "AKC_11_12", =>
    game.lactivate(202)
    game.goto(202)
  game.pushAction "AKC_11_17", =>
    game.lactivate(207)
    game.goto(207)

#--------2-----------202
  game.push(new Location({
    img: '/assets/obrazki/8plamy.jpg',
    active: true,
    activeState: 'a',
    sound: 's7',
    states: {
      a: new LocationState({
        text: '„Jeszcze jedna plama.” Dlaczego to mówi głos kobiecy?<br/><br/><a href="do:AKC_12_13">1: Moja wina?</a><br/><a href="do:AKC_12_14">2: Precz przeklęta plamo! To ON! To kelner ją zrobił. To TY, to TY wytłumaczysz!</a>'
      })
    },
  }))
  game.pushAction "AKC_12_13", =>
    game.lactivate(203)
    game.goto(203)
  game.pushAction "AKC_12_14", =>
    game.lactivate(204)
    game.goto(204)

#--------2-1-----------203
  game.push(new Location({
    img: '/assets/obrazki/9plamypoglebione.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Byłeś tu z nią. Przecież dlatego tu przyszedłeś. Kelner wylał wino na twoją koszulę. Kazałeś jej mówić. Koniec sytuacji był taki, że krzyczał na nią kelner, a potem ty sam wiesz co wykrzykiwałeś. Wiesz co to znaczy?<br/><br/><a href="do:AKC_13_15">1: Tak, kelner nie powinien na nią krzyczeć. Ja na koszuli miałem wino. Miałem coś zrobić?</a><br/><a href="do:AKC_13_16">2: Błąd. Mój błąd. Czy mogę się wytłumaczyć?</a>'
      })
    },
  }))
  game.pushAction "AKC_13_15", =>
    game.lactivate(205)
    game.goto(205)
  game.pushAction "AKC_13_16", =>
    game.lactivate(206)
    game.goto(206)

#--------2-2-----------204
  game.push(new Location({
    img: '/assets/obrazki/9plamypoglebione.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Żołnierzem jesteś, a tchórzysz? Kto ma Ciebie wytłumaczyć?<br/><br/><a href="do:AKC_14_15">1: Ewa może, umie, potrafi. Ja nie chcę.</a><br/><a href="do:AKC_14_16">2: Powiedziałbym cytatem: „Nikt nas nie pociągnie do tłumaczenia”. Ale to nie jest mój tekst.</a>'
      })
    },
  }))
  game.pushAction "AKC_14_15", =>
    game.lactivate(205)
    game.goto(205)
  game.pushAction "AKC_14_16", =>
    game.lactivate(206)
    game.goto(206)

#--------3-1-----------205
  game.push(new Location({
    img: '/assets/obrazki/10jakby teatr.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Więc co ma wypowiedzieć głos?<br/><br/><a href="do:AKC_15_34">1: JA nie chcę już w to grać.</a><br/><a href="do:AKC_15_24">2: Jeszcze nie po wszystkim. Ja to ja.</a><br/><a href="do:AKC_15_20">3: Jestem widzem.</a>'
      })
    },
  }))
  game.pushAction "AKC_15_34", =>
    game.lactivate(0)
    game.goto(0)
  game.pushAction "AKC_15_24", =>
    game.lactivate(214)
    game.goto(214)
  game.pushAction "AKC_15_20", =>
    game.lactivate(210)
    game.goto(210)

#--------3-2------------206
  game.push(new Location({
    img: '/assets/obrazki/10jakby teatr.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Więc co ma wypowiedzieć głos?<br/><br/><a href="do:AKC_16_24">1: Jeszcze nie po wszystkim. Ja to ja.</a><br/><a href="do:AKC_16_20">2: Jestem widzem.</a>'
      })
    },
  }))
  game.pushAction "AKC_16_24", =>
    game.lactivate(214)
    game.goto(214)
  game.pushAction "AKC_16_20", =>
    game.lactivate(210)
    game.goto(210)

#--------4------------207
  game.push(new Location({
    img: '/assets/obrazki/8plamy.jpg',
    active: true,
    activeState: 'a',
    sound: 's8',
    states: {
      a: new LocationState({
        text: 'Jaki okropny szmer! śmiechy! wrzaski!<br/><br/><a href="do:AKC_17_18">1: Oni wszyscy stoją; Nienawidzą mnie wszyscy, kłaniają się, boją.</a><br/><a href="do:AKC_17_19">2: Kelner- patrz wyszczerza zęby – Dbrum – ten uśmiech jak pająk wleciał mi do gęby.</a>'
      })
    },
  }))
  game.pushAction "AKC_17_18", =>
    game.lactivate(208)
    game.goto(208)
  game.pushAction "AKC_17_19", =>
    game.lactivate(209)
    game.goto(209)

#--------4-1------------208
  game.push(new Location({
    img: '/assets/obrazki/9plamypoglebione.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Masz na sobie koszule z czerwoną plamą. Stoisz na środku. oni wokół ciebie chodzą, kłaniają się, boją.<br/><br/><a href="do:AKC_18_15">1: Muszę coś powiedzieć. Patrzę: Gdzie ta Ewa? Przecież miała tu być. Ona im powie. Ja tu stoję.</a><br/><a href="do:AKC_18_16">2: Hahaha! Przecież jesteśmy w
teatrze.</a>'
      })
    },
  }))
  game.pushAction "AKC_18_15", =>
    game.lactivate(205)
    game.goto(205)
  game.pushAction "AKC_18_16", =>
    game.lactivate(206)
    game.goto(206)

#--------4-2------------209
  game.push(new Location({
    img: '/assets/obrazki/9plamypoglebione.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Patrzą się na ciebie. Szemrzą. Musisz coś powiedzieć.<br/><br/><a href="do:AKC_19_15">1: o nie, nie. Jaki szmer. epigramy, żarciki, przytyki. Gdzie mój głos?</a><br/><a href="do:AKC_19_16">2: Witam Państwa serdecznie. Ja tylko gram w grę.</a>'
      })
    },
  }))
  game.pushAction "AKC_19_15", =>
    game.lactivate(205)
    game.goto(205)
  game.pushAction "AKC_19_16", =>
    game.lactivate(206)
    game.goto(206)


#--------1------------210
  game.push(new Location({
    img: '/assets/obrazki/11 scena 3 kelnerzy.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Kelnerzy w białych ubraniach. Co widzisz?<br/><br/><a href="do:AKC_20_21">1: Widzę szpital. Słyszę brzęk metalu.</a><br/><a href="do:AKC_20_21">2: Widzę biały bal przebierańców. Wszyscy ruszają się szybko. Muzyka jest błyskawiczna. Stroboskop rozświetla twarze i wydaję się mi, że oni mają takie same twarze.</a>'
      })
    },
  }))
  game.pushAction "AKC_20_21", =>
    game.lactivate(211)
    game.goto(211)

#--------2------------211
  game.push(new Location({
    img: '/assets/obrazki/11 scena 3 kelnerzy.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Czy na pewno chcesz być widzem?<br/><br/><a href="do:AKC_21_22">1: Tak.</a><br/><a href="do:AKC_21_24">2: Nie.</a>'
      })
    },
  }))
  game.pushAction "AKC_21_22", =>
    game.lactivate(212)
    game.goto(212)
  game.pushAction "AKC_21_24", =>
    game.lactivate(24)
    game.goto(24)

#--------2-1------------212
  game.push(new Location({
    img: '/assets/obrazki/11 scena 3 kelnerzy.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Co widzisz?<br/><br/><a href="do:AKC_22_23">1: Widzę białe robaki nachodzące na siebie. Coś czerwonego jest pod nimi. Zastanawiam się, czy to moje wino.</a><br/><a href="do:AKC_22_23">2: Widzę pomalowanych na biało ludzi. Mogę dostrzec tylko ich twarze. Zamalowują na biało przestrzeń. Nie mogę dostrzec, czy to ściana, czy przedmiot. Nie wiem gdzie jestem.</a>'
      })
    },
  }))
  game.pushAction "AKC_22_23", =>
    game.lactivate(213)
    game.goto(213)

#--------2-1-1------------213
  game.push(new Location({
    img: '/assets/obrazki/11 scena 3 kelnerzy.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Nie widzisz, że nie możesz być widzem?<br/><br/><a href="do:AKC_23_34">1: Nie widzę, że to nie ja widzę. Nie widzę, że te opisy mogą pojawiać się w nieskończoność. Chcę skończyć grę. </a><br/><a href="do:AKC_23_24">2: To nie ja widzę. Ja widzę ekran monitora, a na nim obrazek głów w białej przestrzeni. Chcę grać.</a>'
      })
    },
  }))
  game.pushAction "AKC_23_34", =>
    game.lactivate(0)
    game.goto(0)
  game.pushAction "AKC_23_24", =>
    game.lactivate(214)
    game.goto(214)

#--------1-----------214
  game.push(new Location({
    img: '/assets/obrazki/12 scena 4 rekawiczki.jpg',
    active: true,
    activeState: 'a',
    sound: 's9',
    states: {
      a: new LocationState({
        text: '„Witam, czy jest Pan gotowy?”<br/><br/><a href="do:AKC_24_25">1: Tak. </a><br/><a href="do:AKC_24_34">2: Nie - to pewnie skończę tę grę.</a>'
      })
    },
  }))
  game.pushAction "AKC_24_25", =>
    game.lactivate(215)
    game.goto(215)
  game.pushAction "AKC_24_34", =>
    game.lactivate(0)
    game.goto(0)

#--------2-----------215
  game.push(new Location({
    img: '/assets/obrazki/13 naczynie z literkami.jpg',
    active: true,
    activeState: 'a',
    sound: 's10',
    states: {
      a: new LocationState({
        text: 'Ugotujesz teraz swoją zupę. Uważaj- wymienię początkowe składniki.<br/><br/><a href="do:AKC_25_26">1: DALEJ </a>'
      })
    },
  }))
  game.pushAction "AKC_25_26", =>
    game.lactivate(216)
    game.goto(216)

#--------3-----------216
  game.push(new Location({
    img: '/assets/obrazki/13 naczynie z literkami.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Zapamiętałeś? Masz kolejną szansę ich usłyszenia. Uważaj, bo możesz zepsuć swoją zupę. (- Jeden nieodpowiedni składnik truje.) Jeżeli zaznaczysz wymienione, możesz usłyszeć wszystkie składniki jeszcze raz.<br/><br/><a href="do:AKC_26_27">1: A O </a><br/><a href="do:AKC_26_34">2: U Y </a><br/><a href="do:AKC_26_27">3: E I </a>'
      })
    },
  }))
  game.pushAction "AKC_26_27", =>
    game.lactivate(217)
    game.goto(217)
  game.pushAction "AKC_26_34", =>
    game.lactivate(0)
    game.goto(0)

#--------4-----------217
  game.push(new Location({
    img: '/assets/obrazki/13 naczynie z literkami.jpg',
    active: true,
    activeState: 'a',
    sound: 's12',
    states: {
      a: new LocationState({
        text: 'Z jakich słów chcesz gotować? Pamiętaj, że jeden składnik słowa truje posiłek.<br/><br/><a href="do:AKC_27_28">1: E W A </a><br/><a href="do:AKC_27_30">2: J A </a><br/><a href="do:AKC_27_28">3: M A K B E T </a>'
      })
    },
  }))
  game.pushAction "AKC_27_28", =>
    game.lactivate(218)
    game.goto(218)
  game.pushAction "AKC_27_30", =>
    game.lactivate(220)
    game.goto(220)


#--------4-1-----------218
  game.push(new Location({
    img: '/assets/obrazki/13 naczynie z literkami.jpg',
    active: true,
    activeState: 'a',
    sound: 's13',
    states: {
      a: new LocationState({
        text: 'Zupa zaraz się może zatruć. Masz ostatnią szansę. Rejestruj, pisz, utrwal, spisz, wypisz. J już jest.<br/><br/><a href="do:AKC_28_29">1: DALEJ </a>'
      })
    },
  }))
  game.pushAction "AKC_28_29", =>
    game.lactivate(219)
    game.goto(219)

#-------4-2-----------219
  game.push(new Location({
    img: '/assets/obrazki/13 naczynie z literkami.jpg',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Z jakich słów chcesz gotować? Pamiętaj, że jeden składnik słowa truje posiłek.<br/><br/><a href="do:AKC_29_31">1: E W A </a><br/><a href="do:AKC_29_30">2: J A </a><br/><a href="do:AKC_29_31">3: M A K B E T </a>'
      })
    },
  }))
  game.pushAction "AKC_29_31", =>
    game.lactivate(221)
    game.goto(221)
  game.pushAction "AKC_29_30", =>
    game.lactivate(220)
    game.goto(220)

#--------5-----------220
  game.push(new Location({
    img: '/assets/obrazki/14 bialy kolor w garnku.jpg',
    active: true,
    activeState: 'a',
    sound: 's16',
    states: {
      a: new LocationState({
        text: '<span style="text-decoration: underline;">JA</span> Brawo! Jeden składnik już masz. Wybierz kolejny. Pamiętaj, że jeden składnik słowa truje!<br/><br/><a href="do:AKC_30_31">1: A D A M </a><br/><a href="do:AKC_30_32">2: L E K T O R </a><br/><a href="do:AKC_30_31">3: G R A C Z </a>'
      })
    },
  }))
  game.pushAction "AKC_30_31", =>
    game.lactivate(221)
    game.goto(221)
  game.pushAction "AKC_30_32", =>
    game.lactivate(222)
    game.goto(222)

#--------5-1-----------221
  game.push(new Location({
    img: '/assets/obrazki/14 bialy kolor w garnku.jpg',
    active: true,
    activeState: 'a',
    sound: 's15',
    states: {
      a: new LocationState({
        text: 'Zatrułeś zupę. Strata zupy. <br/><br/><a href="do:AKC_31_34">1: DALEJ </a>'
      })
    },
  }))
  game.pushAction "AKC_31_34", =>
    game.lactivate(0)
    game.goto(0)

#----------6-----------222
  game.push(new Location({
    img: '/assets/obrazki/14 bialy kolor w garnku.jpg',
    active: true,
    activeState: 'a',
    sound: 's18',
    states: {
      a: new LocationState({
        text: '<span style="text-decoration: underline;">LEKTOR</span> Brawo! Drugi składnik już masz. Wybierz ostatni. Nie zatruj!<br/><br/><a href="do:AKC_32_33">1: G R A </a><br/><a href="do:AKC_32_31">2: M Y S Z </a>'
      })
    },
  }))
  game.pushAction "AKC_32_33", =>
    game.lactivate(223)
    game.goto(223)
  game.pushAction "AKC_32_31", =>
    game.lactivate(221)
    game.goto(221)

#----------7-----------223
  game.push(new Location({
    img: '/assets/obrazki/15 zupa sie gotuje.jpg',
    active: true,
    activeState: 'a',
    sound: 's19',
    states: {
      a: new LocationState({
        text: 'Gratuluję! Ugotowałeś! Zupa gra <span style="text-decoration: underline;">/ja lektor gra/</span> <br/><br/><a href="do:AKC_33_34">1: [MAPA]</a>'
      })
    },
  }))
  game.pushAction "AKC_33_34", =>
    game.lactivate(0)
    game.goto(0)











  $('a').live('click', (e) ->
    href = $(this).attr('href')
    if href.substr(0,3) == "do:"
      e.preventDefault()
      action = href.substr(3)
      game.action(action)
  )
  game.ready =>
    game.goto(46)
