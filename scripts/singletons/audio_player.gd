extends AudioStreamPlayer

var rng = RandomNumberGenerator.new()

## Music
const dynamic_music_1 = preload("res://audios/ost/dynamic_1.mp3")
const dynamic_music_2 = preload("res://audios/ost/dynamic_2.mp3")
const dynamic_music_3 = preload("res://audios/ost/dynamic_3.mp3")
const dynamic_music_4 = preload("res://audios/ost/dynamic_4.mp3")
const dynamic_music_5 = preload("res://audios/ost/dynamic_5.mp3")
const dynamic_music_6 = preload("res://audios/ost/dynamic_6.mp3")

## SFX

# Store - Coins
const coins_1 = preload("res://audios/sfx/shop-coins/clink1.wav")
const coins_2 = preload("res://audios/sfx/shop-coins/clink2.wav")
const coins_3 = preload("res://audios/sfx/shop-coins/clink3.wav")
const coins_4 = preload("res://audios/sfx/shop-coins/clink4.wav")

# Menus - GUI
const open_menu = preload("res://audios/sfx/gui/open-change_menus.mp3")
const close_menu = preload("res://audios/sfx/gui/close-change_menus.mp3")

# Bomb Explode
const bomb_explode_1 = preload("res://audios/sfx/bomb/bomb_exploding_1.mp3")

# Click
const click_1 = preload("res://audios/sfx/click/click1.mp3")

# Ghost Click
const g_click_1 = preload("res://audios/sfx/ghost_click/ghost_click1.mp3")

## Player


## Coins

func _play_music(music: AudioStream, volume = -9.0, actualTime = 0.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
	seek(actualTime)

# Music
func dynamic_music():
	if GlobalVars.score < 10 and !GlobalVars.unlocked_shop:
		var actualTime = get_playback_position()
		_play_music(dynamic_music_1, -5, actualTime)
		await self.finished
	if GlobalVars.music_stage == 1:
		var actualTime = get_playback_position()
		_play_music(dynamic_music_2, -5, actualTime)
		await self.finished
	if GlobalVars.music_stage == 2:
		var actualTime = get_playback_position()
		_play_music(dynamic_music_3, -5, actualTime)
		await self.finished
	if GlobalVars.music_stage == 3:
		var actualTime = get_playback_position()
		_play_music(dynamic_music_4, -5, actualTime)
		await self.finished
	if GlobalVars.music_stage == 4:
		var actualTime = get_playback_position()
		_play_music(dynamic_music_5, -5, actualTime)
		await self.finished
	if GlobalVars.music_stage == 5:
		var actualTime = get_playback_position()
		_play_music(dynamic_music_6, -5, actualTime)
		await self.finished

#------------------------------
func play_FX(stream: AudioStream, volume = 0.0, pitch = 1.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	fx_player.bus = "SFX" 
	fx_player.pitch_scale = pitch
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	fx_player.queue_free()

# SFX
func bought_item():
	var sfx = rng.randi_range(1,4)
	match sfx:
		1:
			play_FX(coins_1)
		2:
			play_FX(coins_2)
		3:
			play_FX(coins_4)
		4:
			play_FX(coins_4)

func click():
	play_FX(click_1)

func ghost_click():
	play_FX(g_click_1)

func bomb_explode():
	play_FX(bomb_explode_1, -10)
	

func open_menu_gui():
	play_FX(open_menu, +5.0)

func close_menu_gui():
	play_FX(close_menu, +5.0)

func fade_to_music(fade_time := 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -80, fade_time) # fade out

func music_reduce(new_volume := -18.0, fade_time := 0.5, pitch = 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", new_volume, fade_time) # fade out
	tween.tween_property(self, "pitch_scale", pitch, fade_time)

func music_normal(old_volume := -5.0, fade_time := 0.5, pitch = 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", old_volume, fade_time) # fade out
	tween.tween_property(self, "pitch_scale", pitch, fade_time)
