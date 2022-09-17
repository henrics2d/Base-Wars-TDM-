tdm.commands = {}

tdm.commands[#tdm.commands+1] = {
  locked = true,
  permlevel = "",
  name = "Client Commands",
  callback = function(id)
  end
}

tdm.commands[#tdm.commands+1] = {
  locked = false,
  permlevel = "Client",
  name = "Reset to spawn",
  callback = function(id)
    parse("kill "..id)
  end
}

tdm.commands[#tdm.commands+1] = {
  locked = false,
  permlevel = "Client",
  name = "Set Default Spawn Class",
  callback = function(id)
    tdm.defaultClass(id)
  end
}

tdm.commands[#tdm.commands+1] = {
  locked = true,
  permlevel = "Admin",
  name = "Spawn Humvee (TEST)",
  callback = function(id)
    tdm.spawnVehicle(id,tdm.vehicletypes.humvee)
  end
}

tdm.commands[#tdm.commands+1] = {
  locked = true,
  permlevel = "",
  name = "Buy Classes",
  callback = function(id)
  end
}

tdm.commands[#tdm.commands+1] = {
  locked = false,
  permlevel = "Client",
  name = "Buy Dreadnaut",
  callback = function(id)
    if tdm.player[id].battlescore >= 500 then
      tdm.player[id].battlescore = tdm.player[id].battlescore - 500
      tdm.deletePlayerClass(id)
      tdm.setPlayerClass(id,tdm.classestable[13])
      if player(id,"team") == 1 then
        local entity = tdm.random_array_value(tdm.find_entity_types("Env_Cube3D"))
        parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
      else
        local entity = tdm.random_array_value(tdm.find_entity_types("Env_Item"))
        parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
      end
    end
  end
}

tdm.commands[#tdm.commands+1] = {
  locked = false,
  permlevel = "Client",
  name = "Buy Juggernaut",
  callback = function(id)
    if tdm.player[id].battlescore >= 150 then
      tdm.player[id].battlescore = tdm.player[id].battlescore - 150
      tdm.deletePlayerClass(id)
      tdm.setPlayerClass(id,tdm.classestable[14])
      if player(id,"team") == 1 then
        local entity = tdm.random_array_value(tdm.find_entity_types("Env_Cube3D"))
        parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
      else
        local entity = tdm.random_array_value(tdm.find_entity_types("Env_Item"))
        parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
      end
    end
  end
}

tdm.commands[#tdm.commands+1] = {
  locked = false,
  permlevel = "Client",
  name = "Buy Engineeer",
  callback = function(id)
    if tdm.player[id].battlescore >= 250 then
      tdm.player[id].battlescore = tdm.player[id].battlescore - 250
      tdm.deletePlayerClass(id)
      tdm.setPlayerClass(id,tdm.classestable[15])
      if player(id,"team") == 1 then
        local entity = tdm.random_array_value(tdm.find_entity_types("Env_Cube3D"))
        parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
      else
        local entity = tdm.random_array_value(tdm.find_entity_types("Env_Item"))
        parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
      end
    end
  end
}
