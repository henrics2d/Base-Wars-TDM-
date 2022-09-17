tdm.classestable = {}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Soldier",
  description = "A powerful soldier with no special abilities and moderate health",
  description2 = "Spawns with either an M4A1 or an AK47",
	health = 1000,
	maxhealth = 1000,
  armorpoints = 1000,
  armorid = 2,
  damagemultiplier = 1,
	basespeed = 0,
  img = nil,
  gadget = nil,
  onSpawn = function(id)
    if player(id, "team") == 1 then
      parse("equip "..id.." 30")
      parse("equip "..id.." 51")
      parse("equip "..id.." 3")
      parse("strip "..id.." 2")
    else
      parse("equip "..id.." 32")
      parse("equip "..id.." 51")
      parse("equip "..id.." 3")
      parse("strip "..id.." 1")
    end
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Scout",
  description = "A very fast soldier with a shotgun and low health",
  description2 = "Can increase his speed and damage momentarily",
	health = 1000,
	maxhealth = 1000,
  armorpoints = 500,
  armorid = 1,
  damagemultiplier = 1,
	basespeed = 8,
  img = "cap.png",
  gadget = {
    name = "Scout's Boost",
    cooldown = 15,
    callback = function(id)
      msg2(id,rgb(255,0,0).."I feel hyper!@C")
      tdm.player[id].damagemultiplier = 1.80
      parse("speedmod "..id.." 32")
      timer2(5000,{id},function(id)
        msg2(id,rgb(255,0,0).."Boost over.@C")
        parse("speedmod "..id.." 8")
        tdm.player[id].damagemultiplier = 1
      end)
    end
  },
  onSpawn = function(id)
    parse("strip "..id.." ".."2")
    parse("strip "..id.." ".."1")
    parse("equip "..id.." ".."3")
    parse("equip "..id.." ".."10")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Heavy",
  description = "A heavily armored soldier with lots of health and armor",
  description2 = "Comes with a M249 but alike the soldier, no special abilities",
	health = 2000,
	maxhealth = 2000,
  armorpoints = 1000,
  armorid = 1,
  damagemultiplier = 1,
	basespeed = -4,
  img = "armor.png",
  gadget = nil,
  onSpawn = function(id)
    if player(id, "team") == 1 then
      parse("strip "..id.." ".."2")
      parse("equip "..id.." ".."3")
    else
      parse("strip "..id.." ".."1")
      parse("equip "..id.." ".."4")
    end
    parse("equip "..id.." ".."40")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Defender",
  description = "An extremely tanky half cyborg thats capable of providing buffs to his comrades",
  description2 = "Comes only with a Five-Seven",
	health = 2000,
	maxhealth = 2000,
  armorpoints = 2000,
  armorid = 2,
  damagemultiplier = 1,
	basespeed = -6,
  img = "cyborg.png",
  gadget = {
    name = "Buff Shields",
    cooldown = 25,
    callback = function(id)
      for _,victim in ipairs(player(0,"tableliving")) do
        local px = player(id,"x")
        local py = player(id,"y")
        local dx = math.abs(player(victim,"x")-px)
        local dy = math.abs(player(victim,"y")-py)
        local dist = dx + dy
        if dist <= 128 then
          if player(id,"team") == player(victim,"team") then
            tdm.player[victim].armor = tdm.player[victim].armor + 500
          end
        end
      end
    end
  },
  onSpawn = function(id)
    if player(id, "team") == 1 then
      parse("strip "..id.." ".."2")
    else
      parse("strip "..id.." ".."1")
    end
    parse("equip "..id.." 6")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Commando",
  description = "A veteran of war with a AUG Bullpup and a singular airstrike",
  description2 = "Can increase the damage of his allies momentarily, aswell as his own",
	health = 800,
	maxhealth = 800,
  armorpoints = 1000,
  armorid = 2,
  damagemultiplier = 1,
	basespeed = 2,
  img = "badge.png",
  gadget = {
    name = "Call to Arms",
    cooldown = 60,
    callback = function(id)
      msg(rgb(255,0,0).."Commando "..player(id,"name").." has called to arms!")
      for _,victim in ipairs(player(0,"tableliving")) do
        local px = player(id,"x")
        local py = player(id,"y")
        local dx = math.abs(player(victim,"x")-px)
        local dy = math.abs(player(victim,"y")-py)
        local dist = dx + dy
        if dist <= 128 then
          if player(id,"team") == player(victim,"team") then
            tdm.player[victim].damagemultiplier = 1.25
            timer2(7500,{id},function(id)
              tdm.player[victim].damagemultiplier = 1
            end)
          end
        end
      end
    end
  },
  onSpawn = function(id)
    parse("equip "..id.." ".."76")
    parse("equip "..id.." ".."33")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Sniper",
  description = "A trained professional with an anti-material sniper rifle",
  description2 = "Can penetrate the armor of vehicles with his rifle, aswell as momentarily increase his speed to escape dire situations",
	health = 1000,
	maxhealth = 1000,
  armorpoints = 300,
  armorid = 1,
  damagemultiplier = 1,
	basespeed = 3,
  img = "sniper.png",
  gadget = {
    name = "Escape Plan",
    cooldown = 30,
    callback = function(id)
      parse("speedmod "..id.." 25")
      timer2(4000,{id},function(id)
        parse("speedmod "..id.." 0")
      end)
    end
  },
  onSpawn = function(id)
    parse("equip "..id.." ".."35")
    parse("equip "..id.." ".."52")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Assassin",
  description = "A flanker with a deadly machete and scout sniper rifle",
  description2 = "Can one-shot anyone in a small timeframe using his ability",
	health = 550,
	maxhealth = 550,
  armorpoints = 0,
  armorid = 1,
  damagemultiplier = 1,
	basespeed = 11,
  img = "assassin.png",
  gadget = {
    name = "Nail-Biting Accuracy",
    cooldown = 35,
    callback = function(id)
      tdm.player[id].damagemultiplier = 100
      msg2(id,rgb(255,0,0).."Focus, Concentrate!@C")
      timer2(1000,{id},function(id)
        tdm.player[id].damagemultiplier = tdm.player[id].class.damagemultiplier
        msg2(id,rgb(255,0,0).."Kill period over.@C")
      end)
    end
  },
  onSpawn = function(id)
    parse("equip "..id.." ".."69")
    parse("equip "..id.." ".."34")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Automaton",
  description = "A rogue automaton robot with many gadgets at his disposal",
  description2 = "Can generate molotovs and gas grenades for area denial",
	health = 400,
	maxhealth = 400,
  armorpoints = 5000,
  armorid = 5,
  damagemultiplier = 1,
	basespeed = 1,
  img = "automaton.png",
  gadget = {
    name = "Refill Supply",
    cooldown = 10,
    callback = function(id)
      parse("equip "..id.." 51")
      parse("equip "..id.." 73")
      parse("equip "..id.." 72")
    end
  },
  onSpawn = function(id)
    parse("equip "..id.." ".."20")
    parse("equip "..id.." ".."73")
    parse("equip "..id.." ".."72")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Medic",
  description = "A medic that can heal both in an area and single targets",
  description2 = "Not completely defenseless however...",
	health = 1000,
	maxhealth = 1000,
  armorpoints = 0,
  armorid = 1,
  damagemultiplier = 1,
	basespeed = 4,
  img = "medic.png",
  gadget = {
    name = "Healing Beacon",
    cooldown = 30,
    callback = function(id)
      tdm.spawnprojectile(id,tdm.entitytypes.hbeacon)
    end
  },
  onSpawn = function(id)
    parse("equip "..id.." ".."22")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Demolitionist",
  description = "A mercenary that can use both rockets and grenades",
  description2 = "His ability fires a powerful impact grenade thats capable of causing heavy damage to vehicles",
	health = 1200,
	maxhealth = 1200,
  armorpoints = 400,
  armorid = 2,
  damagemultiplier = 1,
	basespeed = -3,
  img = "demo.png",
  gadget = {
    name = "Impact Grenade",
    cooldown = 10,
    callback = function(id)
      tdm.spawnprojectile(id,tdm.entitytypes.igrenade)
    end
  },
  onSpawn = function(id)
    parse("equip "..id.." ".."48")
    parse("equip "..id.." ".."49")
    parse("equip "..id.." ".."51")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Vampire",
  description = "Not an actual vampire, relies on his lifesteal abilities to survive",
  description2 = "His ability allows him to throw vampire knives that heal on contact",
	health = 50,
	maxhealth = 50,
  armorpoints = 1000,
  armorid = 6,
  damagemultiplier = 1,
	basespeed = 3,
  img = "vamp.png",
  gadget = {
    name = "Vampire Knives",
    cooldown = 3,
    callback = function(id)
      tdm.spawnprojectile(id,tdm.entitytypes.vdagger)
      timer2(150,{id},function(id)
        tdm.spawnprojectile(id,tdm.entitytypes.vdagger)
        timer2(150,{id},function(id)
          tdm.spawnprojectile(id,tdm.entitytypes.vdagger)
        end)
      end)
    end
  },
  onSpawn = function(id)
    parse("equip "..id.." ".."69")
    parse("strip "..id.." ".."1")
    parse("strip "..id.." ".."2")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = false,
  name = "Necromancer",
  description = "(VERY UNFINISHED) An experienced magician in the art of reviving the dead",
  description2 = "His ability allows him to spawn hordes of weak minions",
	health = 650,
	maxhealth = 650,
  armorpoints = 0,
  armorid = 1,
  damagemultiplier = 1,
	basespeed = 5,
  img = "necro.png",
  gadget = {
    name = "Summon Minions",
    cooldown = 15,
    callback = function(id)
    end
  },
  onSpawn = function(id)
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = true,
  name = "Dreadnaut",
  description = "Basically a walking tank...",
  description2 = "Very tanky albeit slow, uses a M134 along with his abilities",
	health = 2500,
	maxhealth = 2500,
  armorpoints = 8000,
  armorid = 4,
  damagemultiplier = 1,
	basespeed = -9,
  img = "juggernaut.png",
  gadget = nil,
  onSpawn = function(id)
    parse("equip "..id.." 90")
    parse("equip "..id.." 47")
    parse("strip "..id.." 1")
    parse("strip "..id.." 2")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = true,
  name = "Juggernaut",
  description = "Boasts level 4 armor for cheap",
  description2 = "Very tanky albeit slow, uses a M249 along with his abilities",
	health = 1000,
	maxhealth = 1000,
  armorpoints = 4000,
  armorid = 4,
  damagemultiplier = 1,
	basespeed = -9,
  img = "minijug.png",
  gadget = nil,
  onSpawn = function(id)
    parse("equip "..id.." 40")
    parse("strip "..id.." 1")
    parse("strip "..id.." 2")
  end,
}

tdm.classestable[#tdm.classestable+1] = {
  unique = true,
  name = "Engineer",
  description = "Very fragile, but can repair his teammate's armor and support them with buildings",
  description2 = "Comes with a wrench and supporting abilities",
	health = 500,
	maxhealth = 500,
  armorpoints = 1000,
  armorid = 2,
  damagemultiplier = 1,
	basespeed = 0,
  img = "engie.png",
  gadget = nil,
  onSpawn = function(id)
    parse("equip "..id.." 74")
    parse("equip "..id.." 11")
    parse("equip "..id.." 5")
    parse("strip "..id.." 1")
    parse("strip "..id.." 2")
  end,
}

function tdm.getRandomClass()
  local index = math.ceil(math.random() * #tdm.classestable)
  return tdm.classestable[index]
end
