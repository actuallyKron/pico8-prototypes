pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
score = 0
highscore = 0
player = {x=0,y=120,speed=3.5,size=8,lives=3}
bullet = {x,y}
heart_sprites = {2,2,2}
shoot_cooldown = 0
enemy_spawn_timer = 0
enemy_spawn_timer_goal = 100
fast_enemy_spawn_timer = 0
fast_enemy_spawn_timer_goal = 200

game_screen = "main_menu"

function reset_game_defaults()
	player.lives = 3
	score = 0
	enemies={}
	fast_enemies={}
	bullets={}
	enemy_spawn_timer_goal = 100
	fast_enemy_spawn_timer_goal = 200
end

function handle_enemy_spawning()
	
	enemy_spawn_timer += 1
	fast_enemy_spawn_timer += 1

	if enemy_spawn_timer > enemy_spawn_timer_goal then
		local x = (flr(rnd(120)))
		spawn_enemy(x,-8)
		enemy_spawn_timer = 0
		
		if enemy_spawn_timer_goal > 30 then
			enemy_spawn_timer_goal -= 1
		end
	end
	
	if score > 30 then
		if fast_enemy_spawn_timer > fast_enemy_spawn_timer_goal then
			local x = (flr(rnd(120)))
			spawn_fast_enemy(x,-8)
			fast_enemy_spawn_timer = 0
			
			if enemy_spawn_timer_goal > 60 then
				enemy_spawn_timer_goal -= 3
			end
		end 
	end
end

function handle_movement()

	if btn(0) and player.x>0 then
		player.x = player.x-player.speed end
	if btn(1) and player.x<118 then
		player.x = player.x+player.speed end

end

function handle_shooting()

	if shoot_cooldown >0 then shoot_cooldown -= 1 end

	if btnp(5) and shoot_cooldown == 0 then
 	shoot(player.x,120)
 	shoot_cooldown = 10
 	sfx(1) -- play shoot sound
	end

end

function calculate_lives()

	if player.lives == 3 then
		heart_sprites = {2,2,2}
	elseif player.lives == 2 then
		heart_sprites = {2,2,3}
	elseif player.lives == 1 then
		heart_sprites = {2,3,3}
	elseif player.lives <= 0 then
		heart_sprites = {3,3,3}
		game_over()
	end
end
-- hcenter code from here:
-- pico-8.fandom.com/wiki/centering_text

function hcenter(s)
  return 64-#s*2
end

function draw_lose_menu()

	local go_x = 28
	local go_y = 32

	spr(39,go_x,go_y)
	spr(40,go_x+8,go_y)
	spr(41,go_x+16,go_y)
	spr(42,go_x+24,go_y)
	spr(43,go_x+32,go_y)
	spr(44,go_x+40,go_y)
	spr(45,go_x+48,go_y)
	spr(46,go_x+56,go_y)
	spr(47,go_x+64,go_y)

	-- print start input text	
	start_text = "press ❎ to play again"
	print("press    to play again", hcenter(tostr(start_text)), 72, 7)
	print("      ❎        ", hcenter(tostr(start_text)), 72, 10)
	
	score_text = ("score: "..score)
	print(score_text, hcenter(tostr(score_text)), 80, 7)	
	
	highscore_text = ("highscore: "..highscore)
	print(highscore_text, hcenter(tostr(highscore_text)), 88, 7)	
	
end

function draw_main_menu()
	wave()	
	-- print start input text	
	start_text = "press ❎ to play"
	print("press    to play", hcenter(tostr(start_text)), 72, 7)
	print("      ❎        ", hcenter(tostr(start_text)), 72, 10)
	
	highscore_text = ("highscore: "..highscore)
	print(highscore_text, hcenter(tostr(highscore_text)), 80, 7)	
	-- print credit stuff
	credit_text = "p8-prototype iv"
	print(credit_text, hcenter(tostr(credit_text)), 112, 7)
	credit_text2 = "by actuallykron"
	print(credit_text2, hcenter(tostr(credit_text2)), 120, 7)
end

function print_ui()
	score_text = ("score: " ..score)
	print(score_text, hcenter(score_text), 4, 7)
	spr(heart_sprites[1], 52, 12)
	spr(heart_sprites[2], 60, 12)
	spr(heart_sprites[3], 68, 12)
end

function game_over()

	if score > highscore then
		highscore = score
	end
	
	game_screen = "lose"

end

	-- all this wave function code
	-- is from the "hello" demo

function wave()
	
	-- for each color
	-- (from pink -> white)
	
	for col = 14,7,-1 do
		input_col = col
		-- for each letter
		for i=1,6 do
		
			-- t() is the same as time()
			t1 = t()*30 + i*4 - col*2
			
			-- position
			x = 32+i*8     +cos(t1/90)*3
			y = 20+(col-7)+cos(t1/50)*5
			pal(7,col)
			spr(31+i, x, y)
		end
 end
end

function _init()
	init_bullets()
	init_enemies()
	init_fast_enemies()
	music(0)
end

function _update()

	if game_screen == "game" then
		handle_movement()
		handle_shooting()
		handle_enemy_spawning()
		calculate_lives()

		bullet_enemy_collisions()
		bullet_fast_enemy_collisions()
		enemy_player_collisions()
		fast_enemy_player_collisions()
	
	 update_bullets()
 	update_enemies()
 	update_fast_enemies()
	
	elseif game_screen == "lose" then
		if btnp(5) then
			game_screen = "main_menu"
		end
	elseif game_screen == "main_menu" then
		
		if btnp(5) then
			reset_game_defaults()
			game_screen = "game"
		end
	end

end
	
function _draw()

	cls(0)

	if game_screen == "game" then
		spr(0,player.x,player.y)
		draw_bullets()
		draw_enemies()
		draw_fast_enemies()
		print_ui()
	elseif game_screen == "lose" then
		draw_lose_menu()
	elseif game_screen == "main_menu" then
		draw_main_menu()	
	end
	
end
-->8
--bullets

function init_bullets()
	bullets={}
end

function update_bullets()
	
	for b in all(bullets) do
		b.y=b.y-3
		
		if b.y < -10 then
			del(bullets,b)
		end

end

end

function draw_bullets()
	for b in all(bullets) do
		spr(1,b.x,b.y)
	end
	
end

function shoot(bx,by)

	add(bullets,{
		x=bx,
		y=by,
		size=8,
		speed=1
	})
end
-->8
-- enemies

function init_enemies()
	enemies={}
end

function update_enemies()
	
	for e in all(enemies) do
		e.y=e.y+e.speed
		
		if e.y > 130 then
			del(enemies,e)
			player.lives -=1
			sfx(3)
		elseif e.y < -150 then
			del(enemies,e)
		end
	
	end

end

function draw_enemies()
	for e in all(enemies) do
		spr(16,e.x,e.y)
	end
	
end

function spawn_enemy(ex,ey)

	add(enemies,{
		x=ex,
		y=ey,
		size=8,
		speed=1
	})
end
-->8
-- collisions
-- by  u/benjamarchi
-- www.reddit.com/r/pico8/comments/hl2ylk/if_you_draw_a_sprite_using_spr_in_code_instead_of/

function collisions(obj1,obj2)

	local hb1={obj1.x,obj1.y,obj1.x+obj1.size,obj1.y+obj1.size}
	local hb2={obj2.x,obj2.y,obj2.x+obj2.size,obj2.y+obj2.size}

	if hb1[1]>=hb2[3] or hb1[2]>=hb2[4] or hb1[3]<=hb2[1] or hb1[4]<=hb2[2] then
		return false
	else
		return true
	end
	
end

function bullet_enemy_collisions()

	for e=1,#enemies do
		local enemy=enemies[e]
		
		for b=1,#bullets do
			local bullet=bullets[b]
		
			if collisions(bullet,enemy) then
			--	del(bullets,b)
			--	del(enemies,enemies[e])
				enemies[e].y = -160 -- move off map
				bullets[b].y = -150
				score+=1
				sfx(0) 
			end
				
		end
	end
end

function bullet_fast_enemy_collisions()

	for fe=1,#fast_enemies do
		local enemy=fast_enemies[fe]
		
		for b=1,#bullets do
			local bullet=bullets[b]
		
			if collisions(bullet,enemy) then
				fast_enemies[fe].y = -160 -- move off map
				bullets[b].y = -150
				score+=1
				sfx(0) 
			end	
			
		end
	end
end

function enemy_player_collisions()

	for e=1,#enemies do
		local enemy=enemies[e]
		
			if collisions(player,enemy) then
				enemies[e].y = -160 -- move off map
				player.lives -=1
				sfx(3)
			end	
			
	end
end

function fast_enemy_player_collisions()

	for fe=1,#fast_enemies do
		local fast_enemy=fast_enemies[fe]
		
			if collisions(player,fast_enemy) then
				fast_enemies[fe].y = -160 -- move off map
				player.lives -=1
				sfx(3)
			end	
			
	end
end
-->8
-- fast enemies 

function init_fast_enemies()
	fast_enemies={}
end

function update_fast_enemies()
	
	for fe in all(fast_enemies) do
		fe.y=fe.y+fe.speed
		
		if fe.y > 130 then
			player.lives -=1
			sfx(3)
			del(fast_enemies,fe)
		elseif fe.y < -150 then
			del(enemies,fe)
		end
	end

end

function draw_fast_enemies()
	for fe in all(fast_enemies) do
		spr(17,fe.x,fe.y)
	end
	
end

function spawn_fast_enemy(fex,fey)

	add(fast_enemies,{
		x=fex,
		y=fey,
		size=8,
		speed=2
	})
end
__gfx__
00c00c0000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07c00c700c7777c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07c00c70c777777c0080800000505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07c00c70cc7777cc0888880005555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07c00c70cc7777cc0088800000555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77cccc770cc77cc00008000000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007cc70000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0bb00bb00cc00cc00dd00dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbccccccccdddddddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b000000bc000000cd000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb7887bbcc7887ccdd7887dd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b7887b00c7887c00d7887d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0bb77bb00cc77cc00dd77dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b0bb0b00c0cc0c00d0dd0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b0000b00c0000c00d0000d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777700007777000707707000777700007777000707707000000000088888800088880000800800088888800000000008888880080000800888888008888800
00700700007000000707707000700700007000000707707000000000080000000800008008088080080000000000000008000080080000800800000008000800
00700700007000000707707000700700007000000707707000000000080000000800008008088080080000000000000008000080080000800800000008000800
00777700007777000707707000777700007777000707707000000000080000000800008008088080088888800000000008000080080000800888888008000800
00700000007777000707707000700000007777000707707000000000080008800888888008088080080000000000000008000080008008000800000008888800
00700000007000000707707000700000007000000707707000000000080000800800008008088080080000000000000008000080008008000800000008008000
00700000007000000707707000700000007000000707707000000000080000800800008008088080080000000000000008000080008008000800000008008800
00700000007777000777777000700000007777000777777000000000088888800800008008088080088888800000000008888880000880000888888008000880
__map__
0000000000000000000000001900150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000019000000150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0003000019230132300d2200822004210002100020000200002001200013000130001200010000100001000011000160001c00021000210001e0001a00017000150001400013000140001500014000120000d000
000100002a02026020220201f0201c02016020140200f0200a020102000c20008200062002b2002b2002c20000200002000020000300003000030000000000000000000000000000000000000000000000000000
0005000000000000000555005550085500c550105500f5500b5500b5500e550000001755017550165501755017550165501355010550000000000000000000000000000000000000000000000000000000000000
0004000016150131500d1500915004150011502d60030600326001360012600116001160012600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000c0431c0000e300120000c043160000d0000f0000c0431a00018000000000c0430000000000000000c0430c00000000000000c0430000013000000000c0430000000000000000c043000000000000000
0110000002040021210e01502140020200e110020450212002010021400e02502110020400e111020450e11002040021200e01502140020200e11002045021200e01002140020250e110020410e110020450e110
011000001a5131d5201f0152152024513260201a5101d5201f0132152024510260201a5131d5201f0102152024513260201a5101d5201f0132152024515260201a5131d5201f0152152024513260201a5001d500
__music__
02 04050644

