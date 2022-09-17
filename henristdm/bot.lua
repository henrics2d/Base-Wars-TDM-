addhook("spawn","tdm.bots")
function tdm.bots(id)
  if player(id,"bot") then
    tdm.deletePlayerClass(id)
    tdm.setPlayerClass(id,tdm.getRandomClass())
    if tdm.player[id].class.unique then
      tdm.bots(id)
      parse("strip "..id.." 47")
      parse("strip "..id.." 90")
      parse("strip "..id.." 11")
      parse("strip "..id.." 40")
    end
    if player(id,"team") == 1 then
      local entity = tdm.random_array_value(tdm.find_entity_types("Env_Cube3D"))
      parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
    else
      local entity = tdm.random_array_value(tdm.find_entity_types("Env_Item"))
      parse("setpos "..id.." "..misc.tile_to_pixel(entity.x).." "..misc.tile_to_pixel(entity.y))
    end
  end
end
