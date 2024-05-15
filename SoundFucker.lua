local SongList = {3929730934, 5567523008, 5517133180, 2631687985, 2478816735, 188088048, 343430735, 6343741731, 8280196339, 5538547181, 7696427240}

function setSound(pitch, Volume, SoundID, Remote, looped)
    looped = looped or true
	local randomized_id = "V3rm was here".. math.random(5838327)
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

for _, v in pairs(workspace:GetDescendants()) do
    if v.Name == "AC6_FE_Sounds" then
        local soundshit = SongList[math.random(1, #SongList)]
        v:FireServer(unpack(setSound(math.random(-3, 3), 255, soundshit, v, true)))
    end
end
