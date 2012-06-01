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
        text: 'Dokąd chcesz się udać?<br/><br/><a href="do:MAPApark">1: Do parku</a><br/><a href="do:MAPAuczelnia">2: Na uczelnię</a>'
      })
    },
  }))
  game.pushAction "MAPApark", =>
    game.lactivate(1)
    game.goto(1)
  game.pushAction "MAPAuczelnia", =>
    game.lactivate(57)
    game.goto(57)
    
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
    game.lactivate(82)
    game.goto(82)

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
    game.lactivate(64)
    game.goto(64)

#-----------U-2B---------62
  game.push(new Location({
    img: '/assets/game/uczelnia1.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: 'Podchodzisz do Profesora i prosisz go szeptem, by odszedł z tobą na bok.<br/><br/><a href="do:uczelnia62A">1: <i>Panie Profesorze, obawiam się, że zaszła pomyłka. Tak naprawdę nie jestem jedną z osób, które miały wygłaszać tutaj referat. Szukam Ewy. Sądzę, że zaginęła.</i></a>'
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
        text: 'Podchodzisz do mównicy. Lekko trzęsą ci się ręce. Nie masz pojęcia, co teraz zrobić.<br/><br/><a href="do:uczelnia63A">1: [Powiedz profesorowi, że w roztargnieniu zostawiłeś wydruk referatu na dworcu PKP]</a><br/><a href="do:uczelnia58B">2: [Opowiedz dowcip]</a>'
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
    game.lactivate(76)
    game.goto(76)
  game.pushAction "uczelnia64B", =>
    game.lactivate(77)
    game.goto(77)

#-----------U-2E---------65
#-----------U-2F---------66
#-----------U-2G---------67
#-----------U-2H---------68
#-----------U-2I---------69
#-----------U-2J---------70
#-----------U-2K---------71
#-----------U-2L---------72
#-----------U-2M---------73
#-----------U-2N---------74
#-----------U-2O---------75
#-----------U-2P---------76
#-----------U-2R---------77
#-----------U-2S---------78
#-----------U-2T---------79
#-----------U-2U---------80
#-----------U-2W---------81
#--------------------------


  $('a').live('click', (e) ->
    href = $(this).attr('href')
    if href.substr(0,3) == "do:"
      e.preventDefault()
      action = href.substr(3)
      game.action(action)
  )
  game.ready =>
    game.goto(46)
