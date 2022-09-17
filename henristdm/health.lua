addhook("hit","tdm.healthHitSystem")
function tdm.healthHitSystem(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
	if player(id,"team") == player(source,"team") then
		return 1
	end
	local damage = hpdmg
	if itemtype(weapon,"dmg") ~= "" and weapon >= 1 and weapon <= 100 then
		damage = itemtype(weapon,"dmg")
	end
	if source > 0 then
		damage = damage * tdm.player[source].damagemultiplier
	end
	tdm.handledamage(id,source,damage)
  tdm.player[id].combattimer = math.random(4,6)
	return 1
end

function tdm.handledamage(id, source, damage)
	if damage > 0 then
		if tdm.player[id].armor > 0 then
			tdm.onarmorhit(id, source, damage)
		else
			tdm.onbrokenarmor(id, source, damage)
		end
		if tdm.player[id].armor <= 0 then
			tdm.player[id].armor = 0
		end
		if tdm.player[id].health <= 0 then
			parse("customkill "..source.." Killed "..id)
		end
	end
  if source > 0 then
		tdm.player[source].target = id
	end
	percent = (tdm.player[id].health / tdm.player[id].maxhealth) * 100
	if percent > 1 then
		parse("sethealth "..id.." "..math.ceil(percent))
	end
end

function tdm.onbrokenarmor(id, source, damage)
	if damage > 0 then
		tdm.player[id].health = tdm.player[id].health - damage
		tdm.player[id].armor = tdm.player[id].armor - damage
		parse("sv_sound2 "..id.." henristdm/hphit.wav")
		parse("sv_sound2 "..source.." henristdm/hphit.wav")
	end
end

function tdm.onarmorhit(id, source, damage)
	if damage < tdm.player[id].armortype.resistance then
		tdm.player[id].armor = tdm.player[id].armor - tdm.player[id].armortype.damageondink * (damage * 0.1)
		tdm.player[id].health = tdm.player[id].health - tdm.player[id].armortype.damageonresist * (damage * 0.01)
		parse("sv_sound2 "..id.." henristdm/armordink.wav")
		parse("sv_sound2 "..source.." henristdm/armordink.wav")
	else
		tdm.onbrokenarmor(id, source, damage)
	end
end
