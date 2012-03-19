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
    $(window).scrollTo('.game-canvas', 1000)

$ ->
  window.game = new Game()
  
  game.push(new Location({
    miniX: 400,
    miniY: 300,
    mini: '/assets/game/f1mini.png',
    img: '/assets/game/f1.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: '<br/>Jedziemy w lewo, czy w prawo? <br/><br/><a href="do:f1_w_lewo">W LEWO</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f1_w_prawo">W PRAWO</a>',
        sound: 's1a'
      })
      b: new LocationState({
        text: '<br/>Gdzie teraz? <br/><br/><a href="do:f1_w_lewo">W LEWO</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f1_w_prawo">W PRAWO</a>',
        sound: 's1b'
      })
      c: new LocationState({
        text: '<br/><br/><a href="do:mapa">MAPA</a>'
        sound: null
      })
    },
  }))

  game.pushAction "mapa", =>
    $(window).scrollTo('.map-canvas', 1000)
  
  game.pushAction "f1_w_prawo", =>
    game.state(0, 'b')
    game.lactivate(3)
    game.goto(3)

  game.pushAction "f1_w_lewo", =>
    game.state(0, 'b') 
    game.lactivate(1)   
    game.goto(1)

  game.push(new Location({
    miniX: 100,
    miniY: 100,
    mini: '/assets/game/f2mini.png',
    img: '/assets/game/f2.png',
    active: false,
    rotation: 13,
    activeState: 'a'
    states: {
      a: new LocationState({
        text: '<br/>Wtorek, piątek, czy sobota?<br/><br/><a href="do:f2_wtorek_piatek">WTOREK</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f2_wtorek_piatek">PIĄTEK</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f2_sobota">SOBOTA</a>'
        sound: 's2a'
      })
      b: new LocationState({
        text: '<br/><br/>Widzimy się w sobotę!<br/><br/><a href="do:mapa">MAPA</a>'
        sound: 's2b'
      })
      c: new LocationState({
        text: '<br/><br/><a href="do:mapa">MAPA</a>'
        sound: null
      })
    },
  }))

  game.pushAction "f2_wtorek_piatek", =>
    game.state(0, 'c')
    game.state(1, 'c')
    game.state(3, 'b')
    game.lactivate(2) 
    game.goto(2)

  game.pushAction "f2_sobota", =>
    game.state(1, 'b')
    game.goto(1)
  
  game.push(new Location({
    miniX: 70,
    miniY: 430,
    mini: '/assets/game/f3mini.png',
    img: '/assets/game/f3.png',
    active:false,
    rotation: -20,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: '<br/><br/><br/>Gościu, nie żyjesz.'
        sound: 's3'
      })
    },
  }))
  
  game.push(new Location({
    miniX: 850,
    miniY: 120,
    mini: '/assets/game/f4mini.png',
    img: '/assets/game/f4.png',
    active:false,
    rotation: 12,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: '<br/>Chcesz do teatru? <br/><br/><a href="do:f4_tak">TAK</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f4_nie">NIE</a>'
        sound: 's4a'
      })
      b: new LocationState({
        text: '<br/><br/><a href="do:mapa">MAPA</a>'
        sound: null
      })
    },
  }))

  game.pushAction "f4_tak", =>
    game.state(3, 'b')
    game.lactivate(4) 
    game.goto(4)

  game.pushAction "f4_nie", =>
    game.state(3, 'b')
    game.goto(3)

  game.push(new Location({
    miniX: 850,
    miniY: 440,
    mini: '/assets/game/t0.jpg',
    active:false,
    rotation: 12,
    activeState: 't1a'
    states: {
      t1a: new LocationState({
        text: '<br/>Znajdujesz się w ciemnym hallu teatru, w którym pracowała twoja dziewczyna. <br/><br/><a href="do:t0_do_kasy">1: Podejdź do kasy biletowej.</a>',
        img: '/assets/game/t1a.jpg'
        sound: null
      })
      t1b: new LocationState({
        text: 'Skrzypiąca posadzka prowadzi cię wprost do znudzonej kobiety siedzącej za oszkloną ladą.<br/>KOBIETA: Taaak? Dzisiaj nie wystawiamy żadnego spektaklu – chyba, że chce pan kupić bilet na jutrzejszy...<br/><br/><a href="do:t1b_t1c">1: Szukam przyjaciółki. Aktorki. Powinna być dziś w teatrze – chciałem jej zrobić niespodziankę.</a><br/><a href="do:t1b_t1d">2: Jestem tutaj w sprawie przesłuchania do nowego spektaklu. Gdzie powinienem się zgłosić?</a><br/><a href="do:t1b_t1e">3: Ja z zaplecza technicznego – miałem pomóc przy dekoracji.</a>'
        img: '/assets/game/t1b.jpg'
        sound: null
      })
      t1c: new LocationState({
        text: '<br/>KOBIETA: Dobrze, proszę za mną. <br/><br/><a href="do:t1_do_garderoby">1: [Idź za kobietą.] </a>',
        img: '/assets/game/t1b.jpg'
        sound: null
      })
      t1d: new LocationState({
        text: '<br/>KOBIETA: Dobrze, proszę za mną. <br/><br/><a href="do:t1_na_scene">1: [Idź za kobietą.] </a>',
        img: '/assets/game/t1b.jpg'
        sound: null
      })
      t1e: new LocationState({
        text: '<br/>KOBIETA: Dobrze, proszę za mną. <br/><br/><a href="do:t1_do_zaplecza">1: [Idź za kobietą.] </a>',
        img: '/assets/game/t1b.jpg'
        sound: null
      })
    },
  }))

  game.pushAction "t0_do_kasy", =>
    game.state(4, 't1b')
    game.goto(4)

  game.pushAction "t1b_t1c", =>
    game.state(4, 't1c')
    game.goto(4)

  game.pushAction "t1b_t1d", =>
    game.state(4, 't1d')
    game.goto(4)

  game.pushAction "t1b_t1e", =>
    game.state(4, 't1e')
    game.goto(4)

  game.pushAction "t1_do_garderoby", =>
    game.lactivate(6)
    game.state(4, 't1a')
    game.goto(6)

  game.pushAction "t1_na_scene", =>
    game.lactivate(5)
    game.state(4, 't1a')
    game.goto(5)

  game.pushAction "t1_do_zaplecza", =>
    game.state(4, 't1a')
    game.goto(4)

  game.push(new Location({
    miniX: 850,
    miniY: 120,
    mini: '/assets/game/t0.jpg',
    img: '/assets/game/t2a.jpg',
    active:false,
    rotation: 12,
    activeState: 't2a',
    states: {
      t2a: new LocationState({
        text: 'Przeciskasz się przez miejsca dla widowni, by dojść do intensywnie oświetlonej sceny. Z daleka jednak widzisz już, że nie ma tutaj twojej dziewczyny. W ogóle nie dostrzegasz kobiecych sylwetek. W pomieszczeniu jest bardzo głośno: krzyki aktorów, mieszają się z hukiem narzędzi pracowników mocujących scenografię. <br/><br/><a href="do:t2a_t2bczekaj">1: [Poczekaj na koniec próby.]</a><br/><a href="do:t2a_t2bprzeszkodz">2: [Przeszkodź próbie.]</a>',
        img: '/assets/game/t2a.jpg'
        sound: null
      })
      t2b1: new LocationState({
        text: 'Decydujesz się przeczekać próbę, choć wkrótce okazuje się ona raczej kłótnią reżysera z aktorem. Ich krzyki, powtarzane przez echo, unoszą się nieznośnie nad widownią, do momentu, aż aktor nie opuści ze wściekłością sali. <br/><br/><a href="do:t2b1_t2b2">1: [Podejdź do reżysera.]</a>',
        img: '/assets/game/t2a.jpg'
        sound: null
      })
      t2b2: new LocationState({
        text: 'REŻYSER: Tak, więc czego pan chciał ode mnie. Jestem bardzo zajęty! <br/><br/><a href="do:t2b2_t2b2a">1: Coś się stało? Ta kłótnia nie brzmiała najlepiej.</a><br/><a href="do:t2b2_t2b2b">2: Chciałem się spytać czy nie widział pan może ostatnio pewnej aktorki. Bardzo mi zależy, by się z nią skontaktować...</a>',
        img: '/assets/game/t2b.jpg'
        sound: null
      })
      t2b2a: new LocationState({
        text: 'REŻYSER: To nie do pomyślenia! Widzi Pan to ja jestem reżyserem, to ja wiem co wyciąć z tekstu, a co zostawić. Niech nie myśli, że może się tak po prostu zbuntować. Jak dzieciak! A co do Ewy to nie widziałem jej od czasu przesłuchania – chyba się obraziła, że nie dostała roli. No cóż trzeba było nie wyprowadzać mnie z równowagi! <br/><br/><a href="do:t2_do_garderoby">1: [Poszukaj garderoby aktorów]</a><br/><a href="do:t2_do_zaplecza">1: [Poszukaj zaplecza technicznego]</a>',
        img: '/assets/game/t2b.jpg'
        sound: null
      })
      t2b2b: new LocationState({
        text: 'REŻYSER: To nie do pomyślenia! Mam już dość tych kłótni. Prowincjonalni aktorzy, prowincjonalni. Nic nie rozumieją! A ta Ewa wcale nie była lepsza – też tylko ciągle dyskutowała i wygłaszała bezsensowne opinie. Nie do pomyślenia! Dobrze, że już jej tu nie ma. <br/><br/><a href="do:t2_do_garderoby">1: [Poszukaj garderoby aktorów]</a><br/><a href="do:t2_do_zaplecza">1: [Poszukaj zaplecza technicznego]</a>',
        img: '/assets/game/t2b.jpg'
        sound: null
      })
      t2c1: new LocationState({
        text: 'REŻYSER: Proszę stąd natychmiast wyjść! Mamy tutaj próbę! Pró—bę! Wyzwolenia! Jezu! Krzysztof! Przecież tego miało nie być – jak t o brzmi? Chyba wycięliśmy to ze scenariusza!<br/><br/><a href="do:t2c1_t2c11">1: [Przeczekaj próbę.]</a>',
        img: '/assets/game/t2b.jpg'
        sound: null
      })
      t2c11: new LocationState({
        text: 'Chcąc nie chcąc, jesteś zmuszony przeczekać próbę. Jest ona raczej kłótnią reżysera z aktorem. Ich krzyki, powtarzane
przez echo, unoszą się nieznośnie nad widownią, do momentu, aż aktor nie opuści z wściekłością sali. <br/><br/><a href="do:t2c11_t2c2">1: [Podejdź do reżysera.]</a>',
        img: '/assets/game/t2a.jpg'
        sound: null
      })
      t2c2: new LocationState({
        text: 'REŻYSER: Tak, więc czego pan chciał ode mnie. Jestem bardzo zajęty! <br/><br/><a href="do:t2c2_t2c2a">1: Coś się stało? Ta kłótnia nie brzmiała najlepiej.</a><br/><a href="do:t2c2_t2c2b">2: Chciałem się spytać czy nie widział pan może ostatnio pewnej aktorki. Bardzo mi zależy, by się z nią skontaktować...</a>',
        img: '/assets/game/t2b.jpg'
        sound: null
      })
      t2c2a: new LocationState({
        text: 'REŻYSER: To nie do pomyślenia! Mam już dość tych kłótni. Prowincjonalni aktorzy, prowincjonalni. Nic nie rozumieją! A ta Ewa wcale nie była lepsza – też tylko ciągle dyskutowała i wygłaszała bezsensowne opinie. Nie do pomyślenia! Dobrze, że już jej tu nie ma. <br/><br/><a href="do:t2_do_garderoby">1: [Poszukaj garderoby aktorów]</a><br/><a href="do:t2_do_zaplecza">1: [Poszukaj zaplecza technicznego]</a>',
        img: '/assets/game/t2b.jpg'
        sound: null
      })
      t2c2b: new LocationState({
        text: 'REŻYSER: Nie odchodzi mnie pan ani pańska dziewczyna. Ja tutaj zajmuje się SZTUKĄ i mam własne problemy! <br/><br/><a href="do:t2_do_garderoby">1: [Poszukaj garderoby aktorów]</a><br/><a href="do:t2_do_zaplecza">2: [Poszukaj zaplecza technicznego]</a>',
        img: '/assets/game/t2b.jpg'
        sound: null
      })
    },
  }))

  game.pushAction "t2a_t2bczekaj", =>
    game.state(5, 't2b1')
    game.goto(5)

  game.pushAction "t2a_t2bprzeszkodz", =>
    game.state(5, 't2c1')
    game.goto(5)

  game.pushAction "t2b1_t2b2", =>
    game.state(5, 't2b2')
    game.goto(5)

  game.pushAction "t2b2_t2b2a", =>
    game.state(5, 't2b2a')
    game.goto(5)

  game.pushAction "t2b2_t2b2b", =>
    game.state(5, 't2b2b')
    game.goto(5)

  game.pushAction "t2c1_t2c11", =>
    game.state(5, 't2c11')
    game.goto(5)

  game.pushAction "t2c11_t2c2", =>
    game.state(5, 't2c2')
    game.goto(5)

  game.pushAction "t2c2_t2c2a", =>
    game.state(5, 't2c2a')
    game.goto(5)

  game.pushAction "t2c2_t2c2b", =>
    game.state(5, 't2c2b')
    game.goto(5)

  game.pushAction "t2_do_garderoby", =>
    game.lactivate(6)
    game.state(6, 't3a_po_scenie')
    game.goto(6)

  game.pushAction "t2_do_zaplecza", =>
    game.state(5, 't2c2b')
    game.goto(5)
  
  game.push(new Location({
    miniX: 850,
    miniY: 120,
    mini: '/assets/game/t0.jpg',
    img: '/assets/game/t3a.jpg',
    active:false,
    rotation: 12,
    activeState: 't3a_przed_scena',
    states: {
      t3a_po_scenie: new LocationState({
        text: 'W pokoju znajduje się mężczyzna. Czesze perukę na biurku. Wydaje ci się jakby znajomy. Pukasz do drzwi, na co odpowiada wesoły, zapraszający uśmiech.<br/>AKTOR: O, cześć! Jesteś nowy. Wzywają mnie na scenę? Mam nadzieję, że nie... Zresztą pewnie i tak moja postać niedługo całkowicie zniknie ze scenariusza. <br/><br/><a href="do:do_t3a1">1: Nie, nie jestem pracownikiem – przyszedłem tutaj, bo szukam mojej dziewczyny. Widziałeś ją może ostatnio?</a><br/><a href="do:do_t3a2">2: Wydaje mi się, że już po próbie. Reżyser nieźle pociął się z jednym z aktorów. Zresztą i tak nie jestem tu dlatego – szukam mojej dziewczyny. Widziałeś ją może ostatnio?</a><br/><a href="do:do_t3a3">3: Niestety, ale reżyser wzywa pana na scenę.</a>'
        sound: null
      })
      t3a_przed_scena: new LocationState({
        text: '<br/>W pokoju znajduje się mężczyzna. Czesze perukę na biurku. Wydaje ci się jakby znajomy. Pukasz do drzwi, na co odpowiada wesoły, zapraszający uśmiech.<br/>AKTOR: O, cześć! Jesteś nowy. Wzywają mnie na scenę? Mam nadzieję, że nie... Zresztą pewnie i tak moja postać niedługo całkowicie zniknie ze scenariusza. <br/><br/><a href="do:do_t3a1">1: Nie, nie jestem pracownikiem – przyszedłem tutaj, bo szukam mojej dziewczyny. Widziałeś ją może ostatnio?</a><br/><a href="do:do_t3a3">2: Niestety, ale reżyser wzywa pana na scenę.</a>'
        sound: null
      })
      t3a1: new LocationState({
        text: 'Nie widziałem jej od czasu wyników kastingu. Starała się o rolę Harfiarki w Wyzwoleniu, które właśnie mamy nieszczęście wystawiać. W każdym razie roli tej nie dostała i od tamtej pory jej nie widziałem. Zresztą nie tylko ona „znikła”. Od dawna też nie widziałem Jerzego - jak go kiedyś spotkasz to spytaj się o Ewę, może on coś wie <br/><br/><a href="do:do_t3p23">1: Dlaczego macie aż takie problemy z tą sztuką?</a><br/><a href="do:do_t3p13">2: Skąd te ciągłe kłótnie z reżyserem?</a><br/><a href="do:do_t3p12">3: Czy wiesz, dlaczego... nie dostała tej roli?</a>'
        sound: null
      })
      t3a2: new LocationState({
        text: 'Taaak, dziwię się, że jeszcze nie wyrzucił Krzyśka – to już ich kolejna kłótnia. Co do Ewy - Nie widziałem ją od czasu wyników kastingu. Starała się o rolę Harfiarki w Wyzwoleniu, które właśnie mamy nieszczęście wystawiać. W każdym razie roli tej nie dostała i od tamtej pory jej nie widziałem. Od dawna też nie widziałem Jerzego – jak go kiedyś spotkasz to spytaj się o Ewę, może on coś wie. <br/><br/><a href="do:do_t3p23">1: Dlaczego macie aż takie problemy z tą sztuką?</a><br/><a href="do:do_t3p13">2: Skąd te ciągłe kłótnie z reżyserem?</a><br/><a href="do:do_t3p12">3: Czy wiesz, dlaczego... nie dostała tej roli?</a>'
        sound: null
      })


      t3p23: new LocationState({
        text: 'Reżyser (pff! Wielki mi reżyser!) ciągle tnie sztukę. Próbuje pozbawić Wyzwolenie Wyspiańskiego chyba wszystkich możliwych sensów. Mu jest zresztą chyba wszystko jedno – żeby tylko nie wzbudzać kontrowersji, żeby było przeciętnie. <br/><br/><a href="do:do_t3o2p3">1: Skąd te ciągłe kłótnie z reżyserem?</a><br/><a href="do:do_t3o3p2">2: Czy wiesz, dlaczego... nie dostała tej roli?</a>'
        sound: null
      })
      t3p13: new LocationState({
        text: 'Wiesz, on przyjechał tutaj z Warszawy. Chce zrobić ten spektakl i wyjechać z powrotem do stolicy. Traktuje nas z góry. Ciągle mu coś się nie podoba, ciągle coś wycina, ciągle zmienia obsadę. W zasadzie Ewa mogła zostać – pewnie w końcu powierzyłby jej tą rolę. <br/><br/><a href="do:do_t301p3">1: Dlaczego macie aż takie problemy z tą sztuką?</a><br/><a href="do:do_t3o3p1">2: Czy wiesz, dlaczego... nie dostała tej roli?</a>'
        sound: null
      })
      t3p12: new LocationState({
        text: 'Wydaje mi się, że dlatego, że wcześniej pokłócili się o metody pracy. Ewa jak pewnie wiesz, jest zwolenniczką metody Stanisławskiego. Nic ci to nie mówi? Wczuwamy się w postać, w nią i jej świat. Wiesz... Świadome oddziałuje na nieświadomość itd. W każdym razie on z góry ustalił, że go to nie interesuje, że to nienowoczesne. To była właściwie jedna z pierwszych kłótni z reżyserem. <br/><br/><a href="do:do_t3o1p2">1: Dlaczego macie aż takie problemy z tą sztuką?</a><br/><a href="do:do_t3o2p1">2: Skąd te ciągłe kłótnie z reżyserem?</a>'
        sound: null
      })


      t3o2p3: new LocationState({
        text: 'Wiesz, on przyjechał tutaj z Warszawy. Chce zrobić ten spektakl i wyjechać z powrotem do stolicy. Traktuje nas z góry. Ciągle mu coś się nie podoba, ciągle coś wycina, ciągle zmienia obsadę. W zasadzie Ewa mogła zostać – pewnie w końcu powierzyłby jej tą rolę. <br/><br/> <a href="do:do_t3o3">1: Czy wiesz, dlaczego... nie dostała tej roli?</a>'
        sound: null
      })
      t3o3p2: new LocationState({
        text: 'Wydaje mi się, że dlatego, że wcześniej pokłócili się o metody pracy. Ewa jak pewnie wiesz, jest zwolenniczką metody Stanisławskiego. Nic ci to nie mówi? Wczuwamy się w postać, w nią i jej świat. Wiesz... Świadome oddziałuje na nieświadomość itd. W każdym razie on z góry ustalił, że go to nie interesuje, że to nienowoczesne. To była właściwie jedna z pierwszych kłótni z reżyserem.<br/><br/><a href="do:do_t3o2">1: Skąd te ciągłe kłótnie z reżyserem?</a>'
        sound: null
      })
      t3o1p3: new LocationState({
        text: 'Reżyser (pff! Wielki mi reżyser!) ciągle tnie sztukę. Próbuje pozbawić Wyzwolenie Wyspiańskiego chyba wszystkich możliwych sensów. Mu jest zresztą chyba wszystko jedno – żeby tylko nie wzbudzać kontrowersji, żeby było przeciętnie. <br/><br/><a href="do:do_t3o3">1: Czy wiesz, dlaczego... nie dostała tej roli?</a>'
        sound: null
      })
      t3o3p1: new LocationState({
        text: 'Wydaje mi się, że dlatego, że wcześniej pokłócili się o metody pracy. Ewa jak pewnie wiesz, jest zwolenniczką metody Stanisławskiego. Nic ci to nie mówi? Wczuwamy się w postać, w nią i jej świat. Wiesz... Świadome oddziałuje na nieświadomość itd. W każdym razie on z góry ustalił, że go to nie interesuje, że to nienowoczesne. To była właściwie jedna z pierwszych kłótni z reżyserem. <br/><br/><a href="do:do_t3o1">1: Dlaczego macie aż takie problemy z tą sztuką?</a>'
        sound: null
      })
      t3o1p2: new LocationState({
        text:'Reżyser (pff! Wielki mi reżyser!) ciągle tnie sztukę. Próbuje pozbawić Wyzwolenie Wyspiańskiego chyba wszystkich możliwych sensów. Mu jest zresztą chyba wszystko jedno – żeby tylko nie wzbudzać kontrowersji, żeby było przeciętnie. <br/><br/><a href="do:do_t3o2">1: Skąd te ciągłe kłótnie z reżyserem?</a>'
        sound: null
      })
      t3o2p1: new LocationState({
        text: 'Wiesz, on przyjechał tutaj z Warszawy. Chce zrobić ten spektakl i wyjechać z powrotem do stolicy. Traktuje nas z góry. Ciągle mu coś się nie podoba, ciągle coś wycina, ciągle zmienia obsadę. W zasadzie Ewa mogła zostać – pewnie w końcu powierzyłby jej tą rolę. <br/><br/><a href="do:do_t3o1">1: Dlaczego macie aż takie problemy z tą sztuką?</a>'
        sound: null
      })

      t3o3: new LocationState({
        text: 'Wydaje mi się, że dlatego, że wcześniej pokłócili się o metody pracy. Ewa jak pewnie wiesz, jest zwolenniczką metody Stanisławskiego. Nic ci to nie mówi? Wczuwamy się w postać, w nią i jej świat. Wiesz... Świadome oddziałuje na nieświadomość itd. W każdym razie on z góry ustalił, że go to nie interesuje, że to nienowoczesne. To była właściwie jedna z pierwszych kłótni z reżyserem. <br/><br/>'
        sound: null
      })
      t3o1: new LocationState({
        text:'Reżyser (pff! Wielki mi reżyser!) ciągle tnie sztukę. Próbuje pozbawić Wyzwolenie Wyspiańskiego chyba wszystkich możliwych sensów. Mu jest zresztą chyba wszystko jedno – żeby tylko nie wzbudzać kontrowersji, żeby było przeciętnie. <br/><br/>'
        sound: null
      })
      t3o2: new LocationState({
        text: 'Wiesz, on przyjechał tutaj z Warszawy. Chce zrobić ten spektakl i wyjechać z powrotem do stolicy. Traktuje nas z góry. Ciągle mu coś się nie podoba, ciągle coś wycina, ciągle zmienia obsadę. W zasadzie Ewa mogła zostać – pewnie w końcu powierzyłby jej tą rolę. <br/><br/>'
        sound: null
      })



      t3a3: new LocationState({
        text: 'Aktor wychodzi przyjrzeć się scenie, a Ty zostajesz sam w garderobie. </br></br><a href="do:gard"> [Rozejrzyj się.] </a>'
        sound: null
      })
      gard: new LocationState({
        text: '<br/><br/><a href="do:mapa">MAPA</a>'
        sound: null
        img: '/assets/game/t3b.jpg'
      })
    },
  }))

  game.pushAction "do_t3a1", =>
    game.state(6, 't3a1')
    game.goto(6)

  game.pushAction "do_t3a2", =>
    game.state(6, 't3a2')
    game.goto(6)

  game.pushAction "do_t3a3", =>
    game.state(6, 't3a3')
    game.goto(6)

  game.pushAction "do_t3p23", =>
    game.state(6, 't3p23')
    game.goto(6)

  game.pushAction "do_t3p12", =>
    game.state(6, 't3p12')
    game.goto(6)

  game.pushAction "do_t3p13", =>
    game.state(6, 't3p13')
    game.goto(6)

  game.pushAction "do_t3o1p2", =>
    game.state(6, 't3o1p2')
    game.goto(6)

  game.pushAction "do_t3o1p3", =>
    game.state(6, 't3o1p3')
    game.goto(6)

  game.pushAction "do_t3o2p1", =>
    game.state(6, 't3o2p1')
    game.goto(6)

  game.pushAction "do_t3o2p3", =>
    game.state(6, 't3o2p3')
    game.goto(6)

  game.pushAction "do_t3o3p1", =>
    game.state(6, 't3o3p1')
    game.goto(6)

  game.pushAction "do_t3o3p2", =>
    game.state(6, 't3o3p2')
    game.goto(6)

  game.pushAction "do_t3o1", =>
    game.state(6, 't3o1')
    game.goto(6)

  game.pushAction "do_t3o2", =>
    game.state(6, 't3o2')
    game.goto(6)

  game.pushAction "do_t3o3", =>
    game.state(6, 't3o3')
    game.goto(6)


  game.pushAction "gard", =>
    game.state(6, 'gard')
    game.goto(6)

  $('.map_link').click(=>
      $(window).scrollTo('.map-canvas', 1000)
    )
  $('a').live('click', (e) ->
    href = $(this).attr('href')
    if href.substr(0,3) == "do:"
      e.preventDefault()
      action = href.substr(3)
      game.action(action)
  )
  game.ready =>
    game.goto(0)
