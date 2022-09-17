tdm.vehicles = {}
tdm.vehicletypes = {}

tdm.vehicletypes.humvee = {
  name = "Humvee",
  image = "gfx/henristdm/humvee.png",
  speed = 5,
  size = 60,
  onCreate = function(entity)
  end,
  onUpdate = function(entity)
  end,
  onPlayerCollsion = function(entity,id)
    if (player(vehicle.owner, "team") ~= player(id, "team")) then
      tdm.handledamage(id, vehicle.owner, math.random(100,125))
      tdm.player[id].combattimer = math.random(8,10)
    end
  end,
  onWallCollision = function(entity)
    vehicle.alive = false
  end,
  onDespawn = function(entity)
    --parse("explosion "..entity.position.x.." "..entity.position.y.." 85 550 "..entity.owner)
  end
}

function tdm.spawnVehicle(id,type)
  local vehicle = {}
  vehicle.type = type
  vehicle.owner = id
  vehicle.alive = true
  vehicle.gun = image(vehicle.type.gun, 0, 0, 0)
  vehicle.dir = player(id,"rot")
  vehicle.speed = vehicle.type.speed
  vehicle.health = vehicle.type.health
  vehicle.bulletresistance = vehicle.type.bulletresistance
  vehicle.position = {x = player(id,"x"), y = player(id,"y")}
  vehicle.image = image(vehicle.type.image, 0, 0, 0)
  imagepos(vehicle.image, vehicle.position.x, vehicle.position.y, math.deg(vehicle.dir))
  vehicle.type.onCreate(vehicle)
  tdm.vehicles[#tdm.vehicles + 1] = vehicle
end

addhook("move","tdm.updateVehicles")
function tdm.updateVehicles(id,x,y,walk)

end
