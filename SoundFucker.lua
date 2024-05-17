local SongList = {3929730934, 5567523008, 2631687985, 188088048, 343430735, 6343741731, 5538547181, 7696427240, 7696491068, 7145372503, 7147215136, 3900067524, 3175432527, 8294288087, 6201427049}

function setSound(pitch, Volume, SoundID, Remote, looped)
    looped = looped or true
	local randomized_id = "HACK_".. math.random(5838327) .. "_PROTECTED" .. math.random(5838327)
   	local Args = {
		[1] = "newSound",
		[2] = randomized_id,
		[3] = game.InsertService,
		[4] = 'rbxassetid://'..SoundID,
		[5] = pitch,
		[6] = Volume,
		[7] = looped
	}
   	Remote:FireServer(unpack(Args))
	return {[1] = "playSound", [2] = randomized_id}
end

for _, v in pairs(game:GetDescendants()) do
    if v.Name == "AC6_FE_Sounds" then
        local soundshit = SongList[math.random(1, #SongList)]
        v:FireServer(unpack(setSound(math.random(-3, 3), 255, soundshit, v, true)))
    end
end
