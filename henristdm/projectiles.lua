tdm.entities = {}
tdm.entitytypes = {}

tdm.entitytypes.vdagger = {
  name = "Vampire Knives",
  image = "gfx/henristdm/vdagger.png",
  speed = 45,
  lifetime = 5,
  size = 14,
  onCreate = function(entity)
    entity.rotate = true
    imagescale(entity.image,0.75,0.9)
  end,
  onUpdate = function(entity)
  end,
  onPlayerCollsion = function(entity,id)
    if (player(entity.owner, "team") ~= player(id, "team")) then
      tdm.handledamage(id, entity.owner, math.random(413,547))
      tdm.player[id].combattimer = math.random(4,6)
      tdm.player[entity.owner].health = tdm.player[entity.owner].health + math.random(206,278)
      if tdm.player[entity.owner].health >= tdm.player[entity.owner].maxhealth then
        tdm.player[entity.owner].maxhealth = tdm.player[entity.owner].maxhealth + math.random(20,27)
        tdm.player[entity.owner].health = tdm.player[entity.owner].maxhealth
      end
      entity.alive = false
    end
  end,
  onWallCollision = function(entity)
    entity.alive = false
  end,
  onDespawn = function(entity) end
}

tdm.entitytypes.igrenade = {
  name = "Impact Grenade",
  image = "gfx/henristdm/inade.png",
  speed = 32,
  lifetime = 5,
  size = 12,
  onCreate = function(entity)
    entity.rotate = true
  end,
  onUpdate = function(entity)
  end,
  onPlayerCollsion = function(entity,id)
    if (player(entity.owner, "team") ~= player(id, "team")) then
      tdm.handledamage(id, entity.owner, 1250)
      tdm.player[id].combattimer = math.random(4,6)
      entity.alive = false
    end
  end,
  onWallCollision = function(entity)
    entity.alive = false
  end,
  onDespawn = function(entity)
    parse("explosion "..entity.position.x.." "..entity.position.y.." 85 550 "..entity.owner)
  end
}

tdm.entitytypes.hbeacon = {
  name = "Healing Beacon",
  image = "gfx/henristdm/beacon.png",
  speed = 0,
  lifetime = 20,
  size = 60,
  onCreate = function(entity)
    entity.rotate = true
  end,
  onUpdate = function(entity)
  end,
  onPlayerCollsion = function(entity,id)
    if (player(entity.owner, "team") == player(id, "team")) then
      tdm.player[id].health = tdm.player[id].health + (tdm.player[id].maxhealth / 20)
      tdm.player[entity.owner].health = tdm.player[entity.owner].health + math.random(7,13)
      if tdm.player[id].health >= tdm.player[id].maxhealth then
        tdm.player[id].health = tdm.player[id].maxhealth
      end
      if tdm.player[entity.owner].health >= tdm.player[entity.owner].maxhealth then
        tdm.player[entity.owner].health = tdm.player[entity.owner].maxhealth
      end
    end
  end,
  onWallCollision = function(entity)
  end,
  onDespawn = function(entity)
  end
}

function tdm.spawnprojectile(id,type)
  local entity = {}
  entity.type = type
  entity.owner = id
  entity.alive = true
  entity.rotate = false
  entity.lifetime = entity.type.lifetime
  entity.dir = math.rad(player(id,"rot") - 90)
  entity.speed = entity.type.speed
  entity.position = {x = player(id,"x"), y = player(id,"y")}
  entity.image = image(entity.type.image, 0, 0, 0)
  imagepos(entity.image, entity.position.x, entity.position.y, math.deg(entity.dir) + 90)
  entity.type.onCreate(entity)
  tdm.entities[#tdm.entities + 1] = entity
end

addhook("ms100","tdm.updateprojectiles")
function tdm.updateprojectiles()
  local index = 0
  while index < #tdm.entities do
    index = index + 1
    local entity = tdm.entities[index]
    -- move
    local mx = math.cos(entity.dir) * entity.speed
    local my = math.sin(entity.dir) * entity.speed
    entity.position.x = entity.position.x + mx
    entity.position.y = entity.position.y + my
    if entity.rotate == true then
      tween_move(entity.image, 100, entity.position.x, entity.position.y, tween_rotateconstantly(entity.image, 35))
    else
      tween_move(entity.image, 100, entity.position.x, entity.position.y, math.deg(entity.dir) + 90)
    end
    -- update
    entity.type.onUpdate(entity)
    -- wall collsion
    local tx = misc.pixel_to_tile(entity.position.x)
    local ty = misc.pixel_to_tile(entity.position.y)
    if tile(tx, ty, "property") == 1 or objectat(tx,ty) > 0 then
      entity.type.onWallCollision(entity)
    end
    -- player collision
    for _,id in ipairs(player(0,"tableliving")) do
      if id ~= entity.owner then
        local px = player(id,"x")
        local py = player(id,"y")
        local dx = math.abs(entity.position.x-px)
        local dy = math.abs(entity.position.y-py)
        local dist = dx + dy
        if dist <= 16 + entity.type.size then
           entity.type.onPlayerCollsion(entity,id)
        end
      end
    end
    -- lifetime
    entity.lifetime = entity.lifetime - 0.1
    if entity.lifetime <= 0 then
      entity.alive = false
    end
    -- despawn
    if entity.alive == false then
      entity.type.onDespawn(entity)
      freeimage(entity.image)
      tdm.entities[index] = tdm.entities[#tdm.entities]
      tdm.entities[#tdm.entities] = nil
      index = index - 1
    end
  end
end
