
class @SoundSystem
  constructor: ->
    soundManager.url = "/assets/"
    @sounds = []
    @ready =>
      # @sounds['default'] = new Sound('default', '/assets/amelia14.ogg',{volume: 12})
      @sounds['s0'] = new Sound('s0', '/assets/0muzyka_cyrku.mp3',{volume: 25})
      @sounds['s1'] = new Sound('s1', '/assets/1wybierz_zarcie.mp3',{volume: 25})
      @sounds['s2'] = new Sound('s2', '/assets/2szukaj.mp3',{volume: 25})
      @sounds['s3'] = new Sound('s3', '/assets/3zgadnij.mp3',{volume: 25})
      @sounds['s4'] = new Sound('s4', '/assets/4anikaniganib.mp3',{volume: 25})
      @sounds['s5'] = new Sound('s5', '/assets/5smiech.mp3',{volume: 25})
      @sounds['s6'] = new Sound('s6', '/assets/6serwujemy_dwa_dania.mp3',{volume: 25})
      @sounds['s7'] = new Sound('s7', '/assets/7jeszcze_jedna_plama.mp3',{volume: 25})
      @sounds['s8'] = new Sound('s8', '/assets/8jaki_okropny szmer_smiechy_wrzaski.mp3',{volume: 25})
      @sounds['s9'] = new Sound('s9', '/assets/9witam_czy_pan jest_gotowy.mp3',{volume: 25})
      @sounds['s10'] = new Sound('s10', '/assets/10ugotujesz.mp3',{volume: 25})
      @sounds['s11'] = new Sound('s11', '/assets/11uwazaj_wymienie.mp3',{volume: 25})
      @sounds['s12'] = new Sound('s12', '/assets/12literki_skladniki.mp3',{volume: 25})
      @sounds['s13'] = new Sound('s13', '/assets/13uwazaj_wymienie.mp3',{volume: 25})
      @sounds['s14'] = new Sound('s14', '/assets/14literki.mp3',{volume: 25})
      @sounds['s15'] = new Sound('s15', '/assets/15_ach.mp3',{volume: 25})
      @sounds['s16'] = new Sound('s16', '/assets/16brawo.mp3',{volume: 25})
      @sounds['s17'] = new Sound('s17', '/assets/17ja.mp3',{volume: 25})
      @sounds['s18'] = new Sound('s18', '/assets/18lektor.mp3',{volume: 25})
      @sounds['s19'] = new Sound('s19', '/assets/19jalektorgra.mp3',{volume: 25})

  ready: (handler)->
    if handler != null
      soundManager.onready =>
        handler()

  ensure: (name)->
    if @current
      if @current.id != name
        @current.stop()
      else return @current
    @current = @sounds[name]
    if @current
    	@current.loop()

  play: (name)->
    if @sounds[name]
    	@sounds[name].play()
        

  stop: (name)->
    @sounds[name].stop()

    
