tdm = {}
images = "gfx/henristdm/"

tdm.directory = "sys/lua/henristdm"

tdm.savesdirectory = tdm.directory.."/saves"
tdm.vehiclesdirectory = tdm.directory.."/vehicles"

dofile(tdm.directory.."/utility.lua")
dofile(tdm.directory.."/savingloading.lua")
dofile(tdm.directory.."/parsesettings.lua")
dofile(tdm.directory.."/checks.lua")
dofile(tdm.directory.."/ranks.lua")
dofile(tdm.directory.."/custommenus.lua")
dofile(tdm.directory.."/health.lua")
dofile(tdm.directory.."/effects.lua")
dofile(tdm.directory.."/menus.lua")
dofile(tdm.directory.."/classes.lua")
dofile(tdm.directory.."/armors.lua")
dofile(tdm.directory.."/commands.lua")
dofile(tdm.directory.."/projectiles.lua")
dofile(tdm.directory.."/bot.lua")
dofile(tdm.directory.."/gui.lua")
dofile(tdm.vehiclesdirectory.."/engine.lua")

tdm.player = {}

addhook("die","tdm.saveondeath")
function tdm.saveondeath(id)
  tdm.save(id)
  if tdm.player[id].gui.icon ~= nil then
    tdm.deleteRankIcon(id)
    tdm.player[id].gui.icon = nil
  end
  tdm.player[id].target = nil
end

addhook("join","tdm.initialize")
function tdm.initialize(id)
  tdm.player[id] = {}
  tdm.player[id].gui = {}
  tdm.player[id].defaultclass = nil
end

addhook("die","tdm.deletePlayerClass")
function tdm.deletePlayerClass(id)
  parse("hudtxtclear "..id)
  if tdm.player[id].image ~= nil then
    freeimage(tdm.player[id].image)
    tdm.player[id].image = nil
  end
  tdm.player[id].class = nil
end

addhook("spawn","tdm.defaultSpawns")
function tdm.defaultSpawns(id)
  if tdm.player[id].defaultclass == nil then
    return
  end
  tdm.setPlayerClass(id,tdm.player[id].defaultclass)
  if player(id,"team") == 1 then
    local entity = tdm.random_array_value(tdm.find_entity_types("Env_Cube3D"))
    parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
  else
    local entity = tdm.random_array_value(tdm.find_entity_types("Env_Item"))
    parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
  end
end

function tdm.setPlayerClass(id,data)
  checks.requireType("id", id, "number")
  checks.requireType("data", data, "table")
	local playerdata = tdm.player[id]
  playerdata.class = data
	playerdata.health = playerdata.class.health
  playerdata.maxhealth = playerdata.class.maxhealth
  playerdata.damagemultiplier = playerdata.class.damagemultiplier
  playerdata.armor = playerdata.class.armorpoints
  playerdata.armortype = tdm.armorstable[playerdata.class.armorid]
  playerdata.combattimer = 0
  playerdata.abilitycooldown = 0
  playerdata.gui = {}
	parse("speedmod "..id.." "..playerdata.class.basespeed)
	if playerdata.class.img ~= nil then
		playerdata.image = image(images..playerdata.class.img, 3, 0, 200 + id)
	end
	--
  tdm.createRankIcon(id)
	playerdata.class.onSpawn(id)
end

addhook("ms100","tdm.ms100")
function tdm.ms100()
  tdm.updateAllPlayerUi()
  tdm.regeneration()
  tdm.effectscountdown()
  tdm.abilityCooldownCounter()
end

addhook("kill","tdm.kill")
function tdm.kill(killer,victim,weapon,x,y,killerobject,assistant)
	tdm.killreward(killer,victim,x,y,killerobject,assistant)
	tdm.ranks(killer,victim,x,y,killerobject,assistant)
  tdm.save(killer)
  tdm.save(victim)
end

function tdm.killreward(killer,victim,x,y,killerobject,assistant)
	tdm.player[killer].battlescore = tdm.player[killer].battlescore + math.ceil(math.random(21,29))
	tdm.player[killer].kills = tdm.player[killer].kills + 1
end

function tdm.ranks(killer,victim,x,y,killerobject,assistant)
  tdm.player[killer].exp = tdm.player[killer].exp + math.ceil(math.random(21,29))
	if tdm.player[killer].exp >= tdm.player[killer].expreq and tdm.player[killer].rank ~= 20 then
		tdm.player[killer].expreq = tdm.playerranks[tdm.player[killer].rank + 1].expreq
		tdm.player[killer].exp = 0
		tdm.player[killer].rank = tdm.player[killer].rank + 1
		msg2(killer,""..rgb(255,255,255).."Rank "..rgb(255,255,128).."Up!@C")
    tdm.deleteRankIcon(killer)
		tdm.createRankIcon(killer)
		msg(rgb(255,255,255)..player(killer, "name").." ranked up to "..rgb(255,255,128)..tdm.playerranks[tdm.player[killer].rank].name.."!")
	end
end
