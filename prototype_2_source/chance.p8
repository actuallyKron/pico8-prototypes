pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- pico-8 prototype ii - "chance"
-- by actuallykron

-- actuallykron.itch.io/chance-pico-8
-- most the code here is mine
-- but some isn't.
-- i've tried to comment and credit
-- the original authors, where i could remember

score = 0
highscore = 0
lowscore = 0

game_started = false

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
		for i=1,6 do
		
			-- t() is the same as time()
			t1 = t()*30 + i*4 - col*2
			
			-- position
			x = 32+i*8     +cos(t1/90)*3
			y = 20+(col-7)+cos(t1/50)*5
			pal(7,col)
			spr(16+i, x, y)
		end
 end
end

function _update()
	
	if game_started == false then
		if (btnp(5)) then game_started = true end
	end
	
	if game_started == true then
		if (btnp(5)) then
			chance = (flr(rnd(2)))
			sfx(00)
			if chance == 1 then
				score = score+1
			elseif chance == 0 then
				score = score-1 end
	
			if score > highscore then
				highscore = score
			end
			
			if score < lowscore then
				lowscore = score
			end
	end
end
end

function _draw()
	cls(0)
	
	if game_started == true then
	
		-- highscore title & backdrop
		highscore_text = ("highscore: " .. highscore)
		print(highscore_text,hcenter(highscore_text), 12, 5)
		print(highscore_text,hcenter(highscore_text), 11, 12)		
		
		-- lowscore text & backdrop
		lowscore_text = ("lowscore: " .. lowscore)
		print(lowscore_text, hcenter(tostr(lowscore_text)), 113, 5)
		print(lowscore_text, hcenter(tostr(lowscore_text)), 112, 13)	
	
		-- current score text & backdrop
	 score_text = ("current score: " .. score) 
		print(score_text,hcenter(score_text), 65, 5)
		print(score_text,hcenter(score_text), 64, 7)

		-- control text & backdrop
		control_text = ("press ❎ to roll")
	 print("press ❎ to roll",hcenter(control_text), 49, 5)
		print("press    to roll",hcenter(control_text), 48, 7)
		print("      ❎        ",hcenter(control_text), 48, 10)

		positive_text = ("roll: positive")
		negative_text = ("roll: negative")
	
		-- show positive text
		if chance == 1 then
   print("roll: positive ",hcenter(positive_text), 79, 5)
	 	print("roll: ",hcenter(positive_text), 78, 7)
	 	print("      positive", hcenter(positive_text), 78, 11)
	
		-- show negative text
		elseif chance == 0 then
   print("roll: negative ",hcenter(negative_text), 79, 5)
   print("roll: ",hcenter(negative_text), 78, 7)
	 	print("      negative", hcenter(negative_text), 78, 8)
		end

	end
	
	-- main menu if the game isn't started
	if game_started == false then
		wave()
		start_text = "press ❎ to play"
		
		--	print(start_text, hcenter(tostr(start_text)), 56, 5)	
		print("press    to play", hcenter(tostr(start_text)), 72, 7)
 	print("      ❎        ", hcenter(tostr(start_text)), 72, 10)
	
		credit_text = "p8-prototype ii"
		print(credit_text, hcenter(tostr(credit_text)), 112, 7)
		credit_text2 = "by actuallykron"
		print(credit_text2, hcenter(tostr(credit_text2)), 120, 7)

	end

end

-- that's it, you looked through
-- all of my terrible code
-- hope it helped you in some way
-- love, kron <3
__gfx__
00000000ccccccccaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccccccccaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700ccccccccaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000ccccccccaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000ccccccccaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700cccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777000070070000777700077000700077770000777700000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000070070000700700077000700070000000700000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000070070000700700070700700070000000700000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000077770000777700070700700070000000777700000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000077770000700700070070700070000000777700000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000070070000700700070070700070000000700000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007000000070070000700700070007700070000000700000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777000070070000700700070007700077770000777700000000000000000000000000000000000000000000000000000000000000000000000000
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
00000000000000000000000000000007770000707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000008780000707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000799000797900077780000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000079a000797900077780000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000077900007779b007778b000999a00000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000889b0008889b007878b000777a00000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000009900000999b007878bd00797ad0000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000aacc000aaab000ababd00777cd0000000000000000000000000000000000007770000000000000000000000000000000
000000000000000000000000000000000bc00000bbb0000bdbd007addd00000000000ddde0000000000000000000007000000000000000000000000000000000
00000000000000000000000000000000bbc00000ccce000cdcd007cdee0000000000077700000000000007700000087770000000000000000000000000000000
000000000000000000000000000000000dcd0000dede0000d0d0000d00000000000007e000000707000007870000087000000000000000000000000000000000
000000000000000000000000000000000cc00000ddde0000e0e0000e00000000000007e000000707000007780000087770000000000000000000000000000000
0000000000000000000000000000000000dee0000e0e00000000000000000000000007dde000070700000787000008aa00000000000000000000000000000000
0000000000000000000000000000000000de00000eee000000000000000000000000077700000707000007780000088800000000000000000000000000000000
000000000000000000000000000000000dde000000000000000000000000000000000000000007770000088b000009aa00000000000000000000000000000000
00000000000000000000000000000000000e00000000000000000000000000000000000000000999000009b90000099900000000000000000000000000000000
0000000000000000000000000000000000ee000000000000000000000000000000000000000000000000099b00000aaa00000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000bb000000bdd00000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bbb00000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ddd00000000000000000000000000000000
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
00000000000000000000000000000000007770777077700770077000000777770000007770077000007770700077707070000000000000000000000000000000
00000000000000000000000000000000007070707070007000700000007770777000000700707000007070700070707070000000000000000000000000000000
00000000000000000000000000000000007770770077007770777000007700077000000700707000007770700077707770000000000000000000000000000000
00000000000000000000000000000000007000707070000070007000007700077000000700707000007000700070700070000000000000000000000000000000
00000000000000000000000000000000007000707077707700770000000777770000000700770000007000777070707770000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000007070777007707070077007707770777077700000000077700000000000000000000000000000000000000000
00000000000000000000000000000000000000007070070070007070700070007070707070000700000070700000000000000000000000000000000000000000
00000000000000000000000000000000000000007770070070007770777070007070770077000000000070700000000000000000000000000000000000000000
00000000000000000000000000000000000000007070070070707070007070007070707070000700000070700000000000000000000000000000000000000000
00000000000000000000000000000000000000007070777077707070770007707770707077700000000077700000000000000000000000000000000000000000
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
00000000000000000000000000000000000077707770000077707770077077700770777070707770777000007770000000000000000000000000000000000000
00000000000000000000000000000000000070707070000070707070707007007070070070707070700000000700000000000000000000000000000000000000
00000000000000000000000000000000000077707770777077707700707007007070070077707770770000000700000000000000000000000000000000000000
00000000000000000000000000000000000070007070000070007070707007007070070000707000700000000700000000000000000000000000000000000000
00000000000000000000000000000000000070007770000070007070770007007700070077707000777000007770000000000000000000000000000000000000
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

__gff__
0002040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00020000115602055017500245001b5001d5000c500205001e5500b500235002350024500255002550026500275002750027500275000d50024500205001e5001a50014500035000050000500005000050000500
000600001c3500f350093500435001350013400133001320013100030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
