function tdm.updateAllPlayerUi()
  local players = player(0,"tableliving")
  for _,id in ipairs(players) do
    tdm.updatePlayerUi(id)
  end
end

function tdm.updatePlayerUi(id)
  if tdm.player[id].class ~= nil then
    parse(' hudtxt2 '..id..' 1 "'..rgb(255,255,128)..'HP: '..rgb(255,255,255)..math.ceil(tdm.player[id].health)..'/'..math.ceil(tdm.player[id].maxhealth)..' " '..player(id,"screenw") / 2.25 ..' " '..player(id,"screenh") / 1.5 ..' " 0 0 25')
    parse(' hudtxt2 '..id..' 5 "'..rgb(128,128,255)..'AP: '..rgb(255,255,255)..math.ceil(tdm.player[id].armor)..' " '..player(id,"screenw") / 2.25 ..' " '..player(id,"screenh") / 1.44 ..' " 0 0 25')
    parse(' hudtxt2 '..id..' 10 "'..rgb(128,128,255)..'Armor: '..rgb(255,255,255)..tdm.player[id].armortype.name..' " '..player(id,"screenw") / 2.25 ..' " '..player(id,"screenh") / 1.38 ..' " 0 0 25')
    parse(' hudtxt2 '..id..' 3 "'..rgb(255,255,128)..'Class: '..rgb(255,255,255)..tdm.player[id].class.name..' " '..player(id,"screenw") - player(id,"screenw")..' " '..player(id,"screenh") / 1.115 ..' " 0 0 25')
    parse(' hudtxt2 '..id..' 4 "'..rgb(255,255,128)..'Ability: '..tdm.getPlayerAbilityStatus(id)..rgb(255,255,128)..' " '..player(id,"screenw") / 6 ..' " '..player(id,"screenh") / 1.115 ..' " 0 0 25')
    parse(' hudtxt2 '..id..' 6 "'..rgb(255,255,128)..'Rank: '..rgb(255,255,255)..tdm.playerranks[tdm.player[id].rank].name..' " '..player(id,"screenw") - player(id,"screenw") ..' " '..player(id,"screenh") - player(id,"screenh") + 300 ..' " 0 0 25')
    parse(' hudtxt2 '..id..' 8 "'..rgb(255,255,128)..'EXP: '..rgb(255,255,255)..math.ceil(tdm.player[id].exp)..'/'..math.ceil(tdm.player[id].expreq)..' " '..player(id,"screenw") - player(id,"screenw") ..' " '..player(id,"screenh") - player(id,"screenh") + 325 ..' " 0 0 25')
    parse(' hudtxt2 '..id..' 9 "'..rgb(255,255,128)..'Battle Score: '..rgb(255,255,255)..math.ceil(tdm.player[id].battlescore)..' " '..player(id,"screenw") - player(id,"screenw") ..' " '..player(id,"screenh") - player(id,"screenh") + 350 ..' " 0 0 25')
    parse(' hudtxt2 '..id..' 11 "'..rgb(255,255,128)..'Kills: '..rgb(255,255,255)..math.ceil(tdm.player[id].kills)..' " '..player(id,"screenw") - player(id,"screenw") ..' " '..player(id,"screenh") - player(id,"screenh") + 375 ..' " 0 0 25')
  end
  local target = tdm.getPlayerTarget(id)
  if target ~= nil then
    parse(' hudtxt2 '..id..' 2 "'..rgb(255,255,128)..'Enemy HP:'..rgb(255,255,255)..' '..math.ceil(tdm.player[target].health)..'/'..math.ceil(tdm.player[target].maxhealth)..' " '..player(id,"mousex") + player(id,"mousex")..' " '..player(id,"mousey") + player(id,"mousey")..' " 0 0 15')
    parse(' hudtxt2 '..id..' 7 "'..rgb(128,128,255)..'Enemy AP:'..rgb(255,255,255)..' '..math.ceil(tdm.player[target].armor)..' " '..player(id,"mousex") + player(id,"mousex")..' " '..player(id,"mousey") + player(id,"mousey") - 15 ..' " 0 0 15')
  end
end

function tdm.createRankIcon(id)
  tdm.player[id].gui.icon = image(images..""..tdm.playerranks[tdm.player[id].rank].imgicon.."", player(id,"screenw") - player(id,"screenw") + 24, player(id,"screenh") - player(id,"screenh") + 276, 2, id)
  imagescale(tdm.player[id].gui.icon,0.75,0.75)
end

function tdm.deleteRankIcon(id)
  freeimage(tdm.player[id].gui.icon)
end

function tdm.getPlayerAbilityName(id)
  if tdm.player[id].class.gadget == nil then
    return rgb(255,0,0).."None"
  end
  return rgb(255,255,255)..tdm.player[id].class.gadget.name
end

function tdm.getPlayerAbilityStatus(id)
  local abilitystatus = tdm.getPlayerAbilityName(id)
  if tdm.player[id].class.gadget == nil then
    return abilitystatus
  end
  if tdm.player[id].abilitycooldown == 0 then
    abilitystatus = abilitystatus..rgb(0,255,0).." [Ready!]"
  else
    abilitystatus = abilitystatus..rgb(255,255,0).." [Ready in "..math.ceil(tdm.player[id].abilitycooldown).."]"
  end
  return abilitystatus
end

function tdm.getPlayerTarget(id)
  if tdm.player[id].target == nil then
    parse(' hudtxt2 '..id..' 2 "" 2 270')
    parse(' hudtxt2 '..id..' 7 "" 2 270')
    return nil
  end
  if player(tdm.player[id].target, "health") <= 0 then
    tdm.player[id].target = nil
    return nil
  end
  if player(tdm.player[id].target, "team") == player(id, "team") then
    tdm.player[id].target = nil
    return nil
  end
  return tdm.player[id].target
end
