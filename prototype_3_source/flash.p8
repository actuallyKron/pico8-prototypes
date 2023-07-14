pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
possible_clrs = {8,9,11,12}
possible_inputs = {⬇️,⬅️,➡️,⬆️}
input_strings = {"⬇️","⬅️","➡️","⬆️"}
selected_clr = 3
selected_input = 0
circle_radius = 48
score = 0
highscore = 0
lives = 3
heart_sprites = {01,01,01}
game_active = false

-- hcenter code from here:
-- pico-8.fandom.com/wiki/centering_text

function hcenter(s)
  return 64-#s*2
end

	-- all this wave function code
	-- is from the "hello" demo

function wave()
	
	-- for each color
	-- (from pink -> white)
	
	for col = 14,7,-1 do
		
		-- for each letter
		for i=1,5 do
		
			-- t() is the same as time()
			t1 = t()*30 + i*4 - col*2
			
			-- position
			x = 40+i*8     +cos(t1/90)*3
			y = 20+(col-7)+cos(t1/50)*5
			pal(7,col)
			spr(16+i, x, y)
		end
 end
end

function choose_clr()
	rand_num = (flr(rnd(4)))
	rand_num += 1
	selected_clr = possible_clrs[rand_num]
	selected_input = possible_inputs[rand_num]
	circle_radius = 48 -- reset radius
end

function check_input()
	if btnp(selected_input) then
		score += 1
		sfx(1) -- play sucess sound
		choose_clr()
	elseif btnp(⬇️) or btnp(⬅️) or btnp(➡️) or btnp(⬆️) then
		lives -= 1
		sfx(0) -- play fail sound
		choose_clr()
	end 
end

function calc_hearts()

	-- terrible code to calculate
	-- what heart sprites
	-- should be shown

	if lives == 3 then
		heart_sprites = {01,01,01}
	elseif lives == 2 then
		heart_sprites = {01,01,02}
	elseif lives == 1 then
		heart_sprites = {01,02,02}
	elseif lives == 0 then
		heart_sprites = {02,02,02}
		game_over()
	end
	
	-- if circle gets too small
	-- lose a life
	-- it's -3 to give the player
	-- a small buffer of extra time
	-- to press the input

	if circle_radius < -3 then
		lives -= 1
		sfx(0)
		choose_clr()
	end
end

function game_over()
	if lives == 0 then
		if score > highscore then
			highscore = score
		end
		game_active = false
	end
end

function draw_game()
	-- draw the circle
	circfill(64,64,circle_radius,selected_clr)
	-- draw all the hearts
	mset(07,01,heart_sprites[1])
	mset(08,01,heart_sprites[2])
	mset(09,01,heart_sprites[3])
	map()
	-- print score and input label
	score_text = ("  score: " .. score)
	print(score_text, hcenter(tostr(score_text)), 2, 7)
--	print("score: "..score, 64,4,7)
	print(input_strings[rand_num],61,62,7)
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
	credit_text = "p8-prototype iii"
	print(credit_text, hcenter(tostr(credit_text)), 112, 7)
	credit_text2 = "by actuallykron"
	print(credit_text2, hcenter(tostr(credit_text2)), 120, 7)
end

function start()
	lives = 3
	score = 0
	choose_clr()
	game_active = true
end

function _init()
	music(0)
end

function _update()
	if game_active == true then
		circle_radius -= 1
		check_input()
		calc_hearts()
	elseif game_active == false and btnp(5) then
		start()
	end
end

function _draw()
	cls(0)
	if game_active == false then
		draw_main_menu()
	elseif game_active == true then
		draw_game()
	end

end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008008000050050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888800555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008888000055550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777000070000000777700007777000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000070000000700700007000000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000070000000700700007000000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777000070000000777700007000000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000070000000700700007777000077770000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000070000000700700000007000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000070000000700700000007000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000077770000700700007777000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000077770007777000700700000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000070070007888000780780000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000700000078870007999900780780000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000700000077770007900000780780000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000077770000700000079979007777a0077778b000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000007000000070000007887900888700078878b000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000078888000700000079a790009979b078978b000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000007777000070000007997900777790078a78b000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000780000007a0000089b890088889c008bb8bd00000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000078888000777700089a8900099990009bd9bd00000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000780000008a0000009cc9c000bbab00abcabd00000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000078aaa000888800009bb9c00aaaab000bd0bd00000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000089990009a000000ac0ac000cccbe00cddcd00000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000008bbb00099990000accac000bbbb000cd0cd00000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009aaa0000a000000bc0bc000dddc0000deed00000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009ddd0000aaaa000bcebc000cccc0000d00d00000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009bbb0000b0000000cddc0000eede000e00e00000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000accc0000b0000000c00c000dddde000e00e00000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000addd0000bbbb0000deed0000000e000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000beee0000c0000000d00d0000eeee000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000b0000000cccc0000d00d00000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000c0000000d0000000e00e00000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000d0000000dddd0000e00e00000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000e0000000eeee0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000007770777077700770077000000aaaaa0000007770077000007770700077707070000000000000000000000000000000
0000000000000000000000000000000000707070707000700070000000aa0a0aa000000700707000007070700070707070000000000000000000000000000000
0000000000000000000000000000000000777077007700777077700000aaa0aaa000000700707000007770700077707770000000000000000000000000000000
0000000000000000000000000000000000700070707000007000700000aa0a0aa000000700707000007000700070700070000000000000000000000000000000
00000000000000000000000000000000007000707077707700770000000aaaaa0000000700770000007000777070707770000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000007070777007707070077007700770777077700000000077700000000000000000000000000000000000000000
00000000000000000000000000000000000000007070070070007070700070007070707070000700000070700000000000000000000000000000000000000000
00000000000000000000000000000000000000007770070070007770777070007070770077000000000070700000000000000000000000000000000000000000
00000000000000000000000000000000000000007070070070707070007070007070707070000700000070700000000000000000000000000000000000000000
00000000000000000000000000000000000000007070777077707070770007707700707077700000000077700000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000777077700000777077700770777007707770707077707770000077707770777000000000000000000000000000000000
00000000000000000000000000000000707070700000707070707070070070700700707070707000000007000700070000000000000000000000000000000000
00000000000000000000000000000000777077707770777077007070070070700700777077707700000007000700070000000000000000000000000000000000
00000000000000000000000000000000700070700000700070707070070070700700007070007000000007000700070000000000000000000000000000000000
00000000000000000000000000000000700077700000700070707700070077000700777070007770000077707770777000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000007770707000007770077077707070777070007000707070707770077077000000000000000000000000000000000000
00000000000000000000000000000000007070707000007070700007007070707070007000707070707070707070700000000000000000000000000000000000
00000000000000000000000000000000007700777000007770700007007070777070007000777077007700707070700000000000000000000000000000000000
00000000000000000000000000000000007070007000007070700007007070707070007000007070707070707070700000000000000000000000000000000000
00000000000000000000000000000000007770777000007070077007000770707077707770777070707070770070700000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__sfx__
0003000024050210501c0501a050130500e050090500505000050040000450000500140001500017000180001a0001b0001c0001e0001f00021000220002300025000290002a0002c0002d000000000000000000
000400002755025550275502a5503350033500325002b7002b7002a7002a7002a7002a70029700297000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c000007055070550a0550a0550a0550a0550a05507055050550505505055070550705507055070550705507055070550a0550a0550a055070550505505055070550705507055070550a0550a0550705507055
0110000011152101520e1500c1500c1510b1500b1510c1500f1521015012152111501115212150131511515014152121501315215150171511515014152171511815016152131501315215150161511615013151
__music__
02 04454344
