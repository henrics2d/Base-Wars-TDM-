function tdm.regeneration()
  local players = player(0,"tableliving")
	for _,id in ipairs(players) do
	  tdm.regeneratePlayer(id)
  end
end

function tdm.regeneratePlayer(id)
  if tdm.player[id].class == nil then
    return
  end
  if tdm.player[id].combattimer > 0 then
    return
  end
  tdm.player[id].health = tdm.player[id].health + tdm.player[id].maxhealth / math.random(16,24)
  if tdm.player[id].health >= tdm.player[id].maxhealth then
    tdm.player[id].health = tdm.player[id].maxhealth
  end
end

function tdm.effectscountdown()
  local players = player(0,"tableliving")
  for _,id in ipairs(players) do
    if tdm.player[id].class == nil then
      return
    end
    if tdm.player[id].combattimer > 0 then
      tdm.player[id].combattimer = tdm.player[id].combattimer - 0.1
    end
  end
end

addbind("space")
addhook("key","tdm.key")
function tdm.key(id,key,state)
  if tdm.player[id].class == nil then
    return
  end
  if tdm.player[id].class.gadget == nil then
    return
  end
	if (key == "space") then
    tdm.gadgets(id,tdm.player[id].class.gadget,tdm.player[id].class.gadget.cooldown)
	end
end

function tdm.gadgets(id,type,cooldown)
  if type == nil then
    return
  end
  if tdm.player[id].abilitycooldown > 0 then
    return
  end
  type.callback(id)
  tdm.player[id].abilitycooldown = tdm.player[id].abilitycooldown + cooldown
end


function tdm.abilityCooldownCounter()
	for id,playerdata in pairs(tdm.player) do
		if playerdata.class == nil then
      return
    end
		playerdata.abilitycooldown = playerdata.abilitycooldown - 0.1
		if playerdata.abilitycooldown < 0 then
			playerdata.abilitycooldown = 0
		end
	end
end
