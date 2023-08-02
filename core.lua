-- ALCHAEL CORE
ac = {}
ac.Actions = {
    Addle = 7560,
    Aero = 121,
    Aethercharge = 25800,
    ApexArrow = 16496,
    ArmysPaeon = 116,
    Barrage = 107,
    BattleVoice = 118,
    BlastArrow = 25784,
    Bloodletter = 110,
    Bulwark = 22,
    BurstShot = 97,
    CausticBite = 100,
    CircleOfScorn = 23,
    Cure = 120,
    Cure2 = 135,
    Diagnosis = 24284,
    DivineVeil = 3540,
    Dosis = 24283,
    Egeiro = 24287,
    EmpyrealArrow = 3558,
    EnergyDrain = 16508,
    Eukresia = 24290,
    FastBlade = 9,
    Fester = 181,
    FightOrFlight = 20,
    Gemshine = 25883,
    GoringBlade = 3538,
    Haima = 24305,
    HallowedGround = 30,
    Kardia = 24285,
    IronJaws = 3560,
    IronWill = 28,
    Ladonsbite = 106,
    LucidDreaming = 7562,
    MagesBallad = 114,
    NaturesMinne = 7408,
    Outburst = 16511,
    Peloton = 7557,
    Phlegma = 24289,
    Physis = 24288,
    PitchPerfect = 7404,
    PreciousBrilliance = 25884,
    Prognosis = 24286,
    Prominence = 16457,
    Physick = 16230,
    RadiantAegis = 25799,
    RadiantFinale = 25785,
    RageOfHalone = 21,
    RagingStrikes = 101,
    RainOfDeath = 117,
    Rampart = 7531,
    RefulgentArrow = 98,
    Reprisal = 7535,
    Rescue = 7571,
    Resurrection = 173,
    RiotBlade = 15,
    Ruin = 163,
    SecondWind = 7541,
    Sentinel = 17,
    Shadowbite = 16494,
    Sheltron = 3542,
    ShieldBash = 16,
    ShieldLob = 24,
    Sidewinder = 3562,
    Sleep = 25880,
    Soteria = 24294,
    SpiritsWithin = 29,
    Stone = 119,
    Stormbite = 113,
    SummonCarbuncle = 25798,
    SummonEmerald = 25804,
    SummonRuby = 25802,
    SummonTopaz = 25803,
    Swiftcast = 7561,
    TheWanderersMinuet = 3559,
    TotalEclipse = 7381,
    Toxicon = 24304,
    Troubadour = 7405,
}
ac.combo = {}
table.insert(ac.combo,ac.Actions.FastBlade)
table.insert(ac.combo,ac.Actions.RiotBlade)
table.insert(ac.combo,ac.Actions.RageOfHalone)
table.insert(ac.combo,ac.Actions.TotalEclipse)
table.insert(ac.combo,ac.Actions.Prominence)
ac.constants = {
    pixel2distance = 1000
}

ac.flags = {
    autotarget = true,
    bosstarget = false,
    canaoe = false,
    caninterrupt = false,
    canweave = false,
    class = "none",
    damagedfriends = 0,
    enemiesinsidecone = 0,
    heading = 0,
    idletime = 0,
    ismoving = false,
    lastaction = 0,
    mode = "simple",
    movetime = 0,
    objective = "damage",
    pos = {},
    songlist = 1,
    teamdamage = 0,
    toughness = 0,
}
ac.gauge = {
    BLMumbraltimer = nil,
    BLMumbraltype = nil,
    SGEcharges = nil,
    SGEmeter = nil,
    SMNactivesummon = nil,
    SMNaetherflow = nil,
    SMNemerald = nil,
    SMNruby = nil,
    SMNtopaz = nil,
    SMNlockdown = nil,
    SMNsummontime = nil,
    SMNstacks = nil,
}
ac.jobs = {
    Gladiator = 1,
    Lancer = 4,
    Archer = 5,
    Conjurer = 6,
    Paladin = 19,
    Bard = 23,
    WhiteMage = 24,
    Arcanist = 26,
    Summoner = 27,
    Sage = 40,
}
ac.range = {
    aoe = 0,
    aoeheal = 0,
    basic = 0,
    buff = 0,
    cone = 0,
    heal = 0,
    radiusRainOfDeath = 8,
    radiusShadowbite = 5,
    rangepadding = 2,
    short = 0,
}
local file = FileLoad(GetLuaModsPath().."EASECore\\settings.ini")
if (file) then
    ac.settings = file
else
    ac.settings = {
        aoethreshold = 3,
        aoeheal1 = 100,
        aoeheal2 = 200,
        aoeheal3 = 325,
        aoeheal4 = 475,
        autocombat = true,
        bosshpmultiplier = 8,
        debug = false,
        dotrefresh = 8,
        dotthreshold = 20,
        hpthreshold0 = 90,
        hpthreshold1 = 75,
        hpthreshold2 = 50,
        hpthreshold3 = 33,
        hpcritical = 15,
        mphalf = 5000,
        mpcritical = 1000,
        pullmode = false,
        trashhpmultiplier = 2,
    }
end
ac.targets = {
    boss = nil,
    cone = {ents=0},
    heal = nil,
    manual = nil,
    rangecircle = {ents=0},
    revive = nil,
    short = {},
    single = nil,
    tankpoke = nil,
}
ac.timer = {
    heartbeat = { frequency = 1000, last = Now(), },
    peloton = { timeout = 3, },
    pulse = { frequency = 100, last = Now(), },
    sprint = { timeout = 3, }
}
function ac.CastAction(target,action) local a = ActionList:Get(1,action)
    if (a and not a.isoncd and a.level <= Player.level) then
        --Player:SetTarget(target.id)
        a:Cast(target.id)
        --if ac.targets.manual then Player:SetTarget(ac.targets.manual.id) else Player:ClearTarget() end
    end
end
function ac.Channel(target,action) local a = ActionList:Get(1,action)
    if (a and not a.isoncd and a.level <= Player.level and not Player:IsMoving()) then
        Player:SetTarget(target.id) a:Cast(target.id)
        if ac.targets.manual then Player:SetTarget(ac.targets.manual.id) else Player:ClearTarget() end
    end
end
function ac.Color(r,g,b,a) return GUI:ColorConvertFloat4ToU32(r,g,b,a) end
function ac.CombatBard()
    ac.range.aoeheal = 30
    ac.flags.class = "ranged"
    ac.range.basic = 25.0
    ac.range.buff = 30.0
    ac.range.cone = 12
    if(ac.flags.mode == "simple") then
        --Outside Combat
        if(not ac.IsInBossDungeon() and not IsMounted() and not IsFlying() and not ac.IsValidAttackTarget() and not ac.HasBuff("Peloton") and not Player.Incombat and ac.flags.movetime >= ac.timer.peloton.timeout) then -- if Peloton Castable
            local action = ActionList:Get(1,ac.Actions.Peloton)
            action:Cast()
        end
        --In Combat
        -- AOE
        local tr = ac.targets.rangecircle
        if (ac.HasBuff("Shadowbite Ready") and ac.IsAOECandidate(tr)) then ac.CastAction(tr,ac.Actions.Shadowbite) end
        local tc = ac.targets.cone
        if (ac.IsAOECandidate(tc)) then ac.CastAction(tc,ac.Actions.Ladonsbite) end
        local ts = ac.IsValidAttackTarget() or ac.targets.single or ac.targets.boss
        if ts and not ts.los2 then Player:SetTarget(ts) end
        -- WEAVING
        if (ac.flags.canweave) then
            if Player.hp.percent <= ac.settings.hpthreshold3 then ac.CastAction(Player,ac.Actions.SecondWind) end
            if (ac.flags.teamdamage > ac.settings.aoeheal1 and ac.IsAOEHealGood()) then ac.CastAction(Player,ac.Actions.Troubadour) end
            if (ac.flags.teamdamage > ac.settings.aoeheal2 and ac.IsAOEHealGood()) then ac.CastAction(Player,ac.Actions.NaturesMinne) end
            if (ts and not ac.HasBuff("Barrage")) then
                if (Player.gauge[1] > 100) then ac.CastAction(Player,ac.Actions.RadiantFinale) end
                if (ac.flags.songlist == 1 and Player.gauge[3] <= 3000) then ac.CastAction(ts,ac.Actions.TheWanderersMinuet) end
                if (ac.flags.songlist == 2 and Player.gauge[3] <= 3000) then ac.CastAction(ts,ac.Actions.PitchPerfect) ac.CastAction(ts,ac.Actions.MagesBallad) end
                if (ac.flags.songlist == 3 and Player.gauge[3] <= 12000) then ac.CastAction(ts,ac.Actions.ArmysPaeon) end
            end
            if (ts) then
                ac.CastAction(Player,ac.Actions.BattleVoice)
                if ((Player.gauge[2] == 3 and ac.HasBuff("The Wanderer's Minuet")) or not ac.HasBuff("The Wanderer's Minuet")) then ac.CastAction(ts, ac.Actions.PitchPerfect) end
                ac.CastAction(Player,ac.Actions.RagingStrikes)
                if (not ac.HasBuff("Barrage")) then ac.CastAction(ts,ac.Actions.EmpyrealArrow) end
                if (not ac.HasBuff("Straight Shot Ready")) then ac.CastAction(Player,ac.Actions.Barrage) end
                ac.CastAction(ts,ac.Actions.Sidewinder)
            end
            if (tr) then
                local r = ac.IsValidAttackTarget() or ac.targets.rangecircle
                if (ac.IsAOECandidate(r)) then
                    ac.CastAction(r,ac.Actions.RainOfDeath)
                elseif(not ac.HasBuff("Barrage")) then
                    ac.CastAction(r,ac.Actions.Bloodletter)
                end
            end
        end
        -- SINGLE
        if (ts) then
            if (ac.IsDOTexpiring(ts,1) or ac.IsDOTexpiring(ts,2) and not ac.HasBuff("Barrage")) then ac.CastAction(ts,ac.Actions.IronJaws) end -- needs higher prio to refresh dot properly
            ac.CastAction(ts,ac.Actions.BlastArrow)
            if (Player.gauge[4] > 80) then ac.CastAction(ts,ac.Actions.ApexArrow) end
            if (ac.HasBuff("Straight Shot Ready")) then ac.CastAction(ts,ac.Actions.RefulgentArrow) end
            if (not ac.HasDOT(ts,1)) then ac.CastAction(ts,ac.Actions.CausticBite)
            elseif (not ac.HasDOT(ts,2)) then ac.CastAction(ts,ac.Actions.Stormbite)
            else ac.CastAction(ts,ac.Actions.BurstShot) end
        end
    end
end
function ac.CombatDragoon()
    ac.range.basic = 3
end
function ac.CombatPaladin()
    ac.flags.class = "tank"
    ac.range.basic = 3
    ac.range.short = 5
    ac.range.long = 20
    if(ac.flags.mode == "simple") then
        if(Duty:GetQueueStatus() == 4) then --inside dungeon
            if(not ac.HasBuff("Iron Will") and not ac.IsInBossDungeon()) then
                ActionList:Get(1, ac.Actions.IronWill):Cast()
            end
        end
        -- Start Poking things when already in combat or have a tasty look on an innocent mob else stay put
        local tp = ac.targets.tankpoke
        if (Player.Incombat) then
            if (tp) then ac.CastAction(tp,ac.Actions.ShieldLob) end
        else
            local tp = ac.IsValidAttackTarget()
            if (tp and tp.distance2d > ac.range.basic and tp.distance2d < ac.range.long) then ac.CastAction(tp,ac.Actions.ShieldLob) end
        end
        local ts = ac.IsValidAttackTarget() or ac.targets.single
        if (ac.flags.canweave) then
            -- [MITIGATION]
            if ac.flags.teamdamage >= ac.settings.aoeheal1 then ac.CastAction(Player,ac.Actions.DivineVeil) end
            if (table.valid(Player.gauge)) then
                if (Player.gauge[1] > ac.settings.hpthreshold1 and Player.hp.percent < ac.settings.hpthreshold0) then
                    ac.CastAction(Player,ac.Actions.Sheltron)
                elseif (Player.gauge[1] > ac.settings.hpthreshold2 and Player.hp.percent < ac.settings.hpthreshold1) then
                    ac.CastAction(Player,ac.Actions.Sheltron)
                end
            end
            if ts and ts.hp.max > Player.hp.max * ac.settings.bosshpmultiplier or ac.IsAOEGood(ac.range.short) and ac.flags.canweave then --check if target is a boss, not sure with the algorithm
                ac.flags.bosstarget = true
                if Player.hp.percent < ac.settings.hpthreshold1 then ac.CastAction(Player,ac.Actions.Reprisal) end
                if Player.hp.percent < ac.settings.hpthreshold2 then ac.CastAction(Player,ac.Actions.Rampart) end
                if Player.hp.percent < ac.settings.hpthreshold3 and not ac.HasBuff("Rampart") then ac.CastAction(Player,ac.Actions.Sentinel) end
                if Player.hp.percent < ac.settings.hpthreshold3 and not ac.HasBuff("Rampart") and not ac.HasBuff("Sentinel") then ac.CastAction(Player,ac.Actions.Bulwark) end
                if Player.hp.percent < ac.settings.hpcritical then ac.CastAction(Player,ac.Actions.HallowedGround) end
            else
                ac.flags.bosstarget = false
            end
        end
        -- AOE TIME
        if ac.IsAOEGood(ac.range.short) then
            if ac.flags.canweave then ac.CastAction(Player,ac.Actions.FightOrFlight) end
            if ac.flags.canweave then ac.CastAction(Player,ac.Actions.CircleOfScorn) end
            if (ac.flags.lastaction == ac.Actions.TotalEclipse) then ac.CastAction(Player,ac.Actions.Prominence) end
            ac.CastAction(Player,ac.Actions.TotalEclipse)
        else    -- Less than AOE threshold
            -- Dunno what logic to add...yet
        end
        --table.sort(ac.enemies, function(l,r)	return math.distance3d(Player.pos,l.pos) < math.distance3d(Player.pos,r.pos) end)
        table.sort(ac.targets.short, function(l,r) return (l.hp.current) < (r.hp.current) end)
        table.sort(ac.targets.short, function(l,r) return (l.aggropercentage) < (r.aggropercentage) end)
        -- [SINGLE TARGET ROTATION]
        if(table.valid(ac.targets.short)) then
            local ts = ac.IsValidAttackTarget() or ac.targets.short[1]
            if ac.flags.canweave and ac.flags.bosstarget then ac.CastAction(Player,ac.Actions.FightOrFlight) end
            if ac.flags.canweave and ac.flags.bosstarget then ac.CastAction(Player,ac.Actions.CircleOfScorn) end
            if ac.flags.canweave then ac.CastAction(ts,ac.Actions.SpiritsWithin) end
            if ac.flags.canweave then ac.CastAction(ts,ac.Actions.GoringBlade) end
            a = ActionList:Get(1, ac.Actions.ShieldBash)
            if(ts.castinginfo.castinginterruptible and ac.flags.toughness > ac.settings.bosshpmultiplier / 2) then
                ac.flags.caninterrupt = true    -- Dont remove these flags, they're used for debugging purposes
                ac.CastAction(ts,ac.Actions.ShieldBash)
            else
                ac.flags.caninterrupt = false
            end
            if (ac.IsCombo(ac.Actions.RiotBlade)) then ac.CastAction(ts,ac.Actions.RageOfHalone) end
            if (ac.IsCombo(ac.Actions.FastBlade)) then ac.CastAction(ts,ac.Actions.RiotBlade) end
            if (not ac.IsCombo(ac.Actions.FastBlade)) then ac.CastAction(ts,ac.Actions.FastBlade) end
        end
        if not tp and ts then ac.CastAction(ts,ac.Actions.ShieldLob) end
    end
end
function ac.CombatSage()
    ac.range.aoe = 15
    ac.range.aoeheal = 15
    ac.range.basic = 25
    ac.range.heal = 30
    if (ac.flags.mode == "simple") then
        local ts = ac.IsValidAttackTarget() or ac.targets.single
        local th = ac.IsValidHealTarget() or ac.targets.heal
        local tr = ac.IsValidReviveTarget() or ac.targets.revive

        -- AOE HEALS
        if ac.flags.damagedfriends >= #ac.friends/2 then
            if ac.flags.teamdamage >= ac.settings.aoeheal1/2 then ac.Channel(Player,ac.Actions.Prognosis) end
        end
        
        -- WEAVING
        if ac.flags.canweave then
            if not ac.HasBuff("Eukresia") and ts and not ac.HasBuff("Eukrasian Dosis",ts) then ac.CastAction(Player,ac.Actions.Eukresia) end
            if ac.flags.teamdamage >= ac.settings.aoeheal1/3 then ac.CastAction(Player,ac.Actions.Physis) end
            if not ac.HasBuff("Kardion", th) and Player.Incombat then ac.CastAction(th,ac.Actions.Kardia) end
        end
        if th then
            if (th.hp.percent <= ac.settings.hpthreshold1) then ac.CastAction(th,ac.Actions.Diagnosis) end
        end
        if ts then 
            if ac.HasBuff("Eukrasia") then ac.Cast(ts,ac.Actions.Dosis) end
            if ac.HasBuff("Eukrasian Dosis",ts) then ac.Channel(ts,ac.Actions.Dosis) end
        end
    end
end
function ac.CombatSummoner()
    ac.range.basic = 25
    ac.range.heal = 30
    if ac.flags.mode == "simple" then
        if not table.valid(Player.pet) then ac.Channel(Player,ac.Actions.SummonCarbuncle) end
        local tz = ac.IsValidReviveTarget() or ac.targets.revive
        local tr = ac.IsValidAttackTarget() or ac.targets.rangecircle
        local ts = ac.IsValidAttackTarget() or ac.targets.single or ac.targets.boss
        local th = ac.IsValidHealTarget() or ac.targets.heal
        
        if ac.flags.canweave then
            if Player.mp.current < ac.settings.mpcritical then ac.CastAction(Player,ac.Actions.LucidDreaming) end
            if Player.hp.percent < ac.settings.hpthreshold1 then ac.CastAction(Player,ac.Actions.RadiantAegis) end
            if Player.Incombat then
                if ac.gauge.SMNruby == 0 and ac.gauge.SMNtopaz == 0 and ac.gauge.SMNemerald == 0 then ac.CastAction(Player,ac.Actions.Aethercharge) end
                if tr then if ac.HasBuff("Swiftcast") and ac.IsAOECandidate(tr) and ac.gauge.SMNactivesummon == 1 then ac.CastAction(tr,ac.Actions.PreciousBrilliance) end end
                if ts then
                    if ac.HasBuff("Swiftcast") and ac.gauge.SMNactivesummon == 1 then ac.CastAction(ts,ac.Actions.Gemshine) end
                    if ac.gauge.SMNactivesummon == 1 and not tz then ac.CastAction(Player,ac.Actions.Swiftcast) end
                    if ac.gauge.SMNemerald == 1 and ac.gauge.SMNactivesummon == 0 then ac.CastAction(ts,ac.Actions.SummonEmerald) end
                    if ac.gauge.SMNtopaz == 1 and ac.gauge.SMNactivesummon == 0 then ac.CastAction(ts,ac.Actions.SummonTopaz) end
                    if ac.gauge.SMNruby == 1 and ac.gauge.SMNactivesummon == 0 then ac.CastAction(ts,ac.Actions.SummonRuby) end
                end
            end
            if ts then
                if ac.gauge.SMNaetherflow == 0 then ac.CastAction(ts,ac.Actions.EnergyDrain) end
                if ac.gauge.SMNaetherflow > 0 then ac.CastAction(ts,ac.Actions.Fester) end
            end
        end
        if tr then
            local r = ac.IsValidAttackTarget() or tr
            if ac.IsAOECandidate(r) then
                if ac.gauge.SMNactivesummon > 0 and r then ac.Channel(r,ac.Actions.PreciousBrilliance) end
                ac.Channel(r,ac.Actions.Outburst)
            end
        end
        if th and th.hp.percent < ac.settings.hpthreshold2 then
            ac.Channel(th,ac.Actions.Physick)
        end
        if ts then
            if ac.gauge.SMNactivesummon > 0 and ts then ac.Channel(ts,ac.Actions.Gemshine) end
            ac.Channel(ts,ac.Actions.Ruin)
        end
    end
end
function ac.CombatWhiteMage() --Whole section needs overhaul, I still can't find the time
    ac.range.aoe = 15
    ac.range.basic = 25
    ac.range.heal = 30
    if (ac.flags.mode == "simple") then
        local el = EntityList("alive,targetable")
        ac.friends = {}
        table.insert(ac.friends, Player)
        for _, entity in pairs(el) do   -- search for friendlies within range
            if (entity.distance2d < ac.range.heal and not entity.attackable and entity.hp.percent > 0 and entity.los2) then
                table.insert(ac.friends, entity)
            end
        end
        table.sort(ac.friends, function(l,r) return (l.hp.percent) < (r.hp.percent) end)
        local target = ac.friends[1]
        if (target.hp.percent < ac.settings.hpthreshold1 and Player.mp.current > ac.settings.mpcritical) then
            Player:SetTarget(target.id)
            local a = ActionList:Get(1, ac.Actions.Cure)
            if(not MIsCasting() and not Player:IsMoving() and ac.GCD()) then
                a:Cast(target.id)
            end
        end
        if (Duty:GetQueueStatus() ~= 4) then --[OUTSIDE DUNGEON BEHAVIOUR]
            local target = Player:GetTarget()
            if(target and target.attackable) then
                local a = ActionList:Get(1, ac.Actions.Aero)
                if (not IsMounted() and not MIsCasting() and ac.GCD() and not ac.HasDOT(target,1) and Player.level >= 4) then
                    a:Cast(target.id)
                end
            end
            target = Player:GetTarget()
            if (target and target.attackable and target.distance2d < ac.range.basic) then
                --SINGLE TARGET ROTATION
                local a = ActionList:Get(1, ac.Actions.Aero)
                if (not IsMounted() and not MIsCasting() and ac.GCD() and not ac.HasDOT(target,1) and Player.level >= 4) then
                    a:Cast(target.id)
                end

                local a = ActionList:Get(1, ac.Actions.Stone)
                if (not MIsCasting() and not Player:IsMoving() and ac.GCD()) then
                    a:Cast(target.id)
                end
            end
        else    --[INSIDE DUNGEON BEHAVIOUR]
            local el = EntityList("alive,attackable,aggro")
            ac.enemies = {}
            for _, entity in pairs(el) do
                if(entity.distance2d <= ac.range.basic and entity.los2) then
                    table.insert(ac.enemies, entity)
                end
            end
            if (table.valid(ac.enemies)) then
                
            end
            table.sort(ac.enemies, function (l,r) return (l.hp.current) < (r.hp.current) end)
            table.sort(ac.enemies, function (l,r) return (l.aggropercentage) > (r.aggropercentage) end)
            table.sort(ac.enemies, function (l,r) return not ac.HasDOT(l,1) and ac.HasDOT(r,1) end)
            if(table.valid(ac.enemies)) then
                Player:SetTarget(ac.enemies[1].id)
                local target = Player:GetTarget()
                --SINGLE TARGET ROTATION
                local a = ActionList:Get(1, ac.Actions.Aero)
                if (ac.GCD() and not ac.HasDOT(target,1) and Player.level >= 4) then
                    a:Cast(target.id)
                end
                local a = ActionList:Get(1, ac.Actions.Stone)
                if (not MIsCasting() and not Player:IsMoving() and ac.GCD()) then
                    a:Cast(target.id)
                end
            end
        end
        local target = Player:GetTarget()
        if (target and target.attackable and ac.HasDOT(target,1) and Player:IsMoving()) then
            local a = ActionList:Get(1, ac.Actions.Aero)
            if (ac.GCD()) then
                a:Cast(target.id)
            end
        end
    end
end
function ac.DrawCircle(pos,radius,color,segments) --for AOE detection and drawing functionality to come
    local sx, sy = ac.W2S(pos)
    local n = (2*math.pi*radius/segments)
    local angle = n / radius local currentangle = 0
    local sppx = 0 local sppy = 0 local sfx = 0 local sfy = 0
    for i = 1, segments, 1 do
        local px = pos.x + (radius * math.sin(currentangle))
        local pz = pos.z + (radius * math.cos(currentangle))
        local spx, spy = ac.W2S({x=px,y=pos.y,z=pz})
        if i == 1 then
            sfx = spx sfy = spy
        elseif i < segments then
            GUI:AddTriangleFilled(sx,sy,spx,spy,sppx,sppy,color)
        else
            GUI:AddTriangleFilled(sx,sy,spx,spy,sppx,sppy,color)
            GUI:AddTriangleFilled(sx,sy,sfx,sfy,spx,spy,color)
        end
        sppx = spx sppy = spy
        currentangle = currentangle + angle
    end
end
function ac.DrawHitbox()
    --GUI:PushStyleColor(GUI.Col_WindowBg, ac.Color(1,1,1,1))
    GUI:PushStyleVar(GUI.StyleVar_Alpha,0.01)
    local sw = GetGameSettings()[18].value*2.2 local sh = GetGameSettings()[19].value*2
    GUI:SetNextWindowSize(sw,sh)
    GUI:Begin("Hitbox", true, GUI.WindowFlags_NoInputs + GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoFocusOnAppearing + GUI.WindowFlags_NoBringToFrontOnFocus + GUI.WindowFlags_NoMove)
    spos = RenderManager:WorldToScreen(Player.pos)
    if MGetTarget() then
        tpos = RenderManager:WorldToScreen(MGetTarget().pos)
    else
        tpos = nil
    end
    if spos then
        GUI:SetWindowPos(spos.x-sw/2,spos.y-sh/2)
        local t = Player:GetTarget()
        if t and table.valid(t.pos) then 
            --ac.DrawCircle(t.pos,t.distance2d,ac.Color(0,.7,.9,.1),16)
            --d("T id:"..tostring(t.id).." Tpos: "..string.format("%.2f - %.2f - %.2f", t.pos.x, t.pos.y, t.pos.z))
        end
        --ac.DrawCircle(Player.pos,2,ac.Color(0,.7,.9,.5),16)
        GUI:AddCircleFilled(spos.x,spos.y,5,GUI:ColorConvertFloat4ToU32(1/255, 1/255, 1/255, 1),8)
        GUI:AddCircleFilled(spos.x,spos.y,2,GUI:ColorConvertFloat4ToU32(1, 1, 1, 1),8)
        
    end
    GUI:PopStyleVar()
    GUI:End()
end
function ac.Draw()
    local open, visible = true, true
    if(open) then
        if ac.settings.debug then GUI:SetNextWindowSize(300, 304) else GUI:SetNextWindowSize(124, 104) end
        GUI:PushStyleVar(GUI.StyleVar_Alpha,1)
        visible, open = GUI:Begin("EASE Core", open, GUI.WindowFlags_NoResize)
        if(visible) then
            local toggleautocombat
            local togglepullmode
            local autocombat
            if (ac.IsSupported()) then GUI:Text(ac.GetJob().." is READY!") else GUI:Text("Coming SOON...") end
            if (ac.settings.autocombat) then
                if ac.IsSupported() then
                    autocombat = GUI:ImageButton("#Activator",GetLuaModsPath().."\\EASECore\\on.jpg",100,43)
                else
                    autocombat = GUI:ImageButton("#Activator",GetLuaModsPath().."\\EASECore\\soon.jpg",100,43)
                end
            else
                autocombat = GUI:ImageButton("#Activator",GetLuaModsPath().."\\EASECore\\off.jpg",100,43)
            end
            if GUI:IsItemHovered() then
                if ac.settings.autocombat then
                    GUI:SetTooltip("version Alpha 0.7\nCurrently Supported:\nBARD - 100%%\nPALADIN - 50%%\nSAGE - 20%%\nSUMMONER - 30%%\nWHITE MAGE - 20%%\nAdd me on Discord for support\nand requests @alchael\n-P.S. Thank you so much\nfor trying me out. Take care :]")
                else
                    GUI:SetTooltip("The EASE Series Upholds The Tenets of\nEfficiency\n        Affordability\n                Simplicity\n                        Elegance\nPrepare for Maximum Awesomeness... :]")
                end
            end
            -- ac.settings.pullmode, togglepullmode = GUI:Checkbox("Pull Mode", ac.settings.pullmode)
            -- if toggleautocombat or togglepullmode then ac.SaveSettings() end
            if (autocombat) then
                ac.settings.autocombat = not ac.settings.autocombat
                ac.SaveSettings()
            end

            if ac.settings.debug and ac.InGame() then
                if MGetTarget() then
                    GUI:Text("ID: "..tostring(MGetTarget().id))
                end
                GUI:Text("Job: "..tostring(Player.job)) GUI:SameLine()
                GUI:Text("Idle: "..tostring(ac.flags.idletime)) GUI:SameLine()
                GUI:Text("Moving: "..tostring(ac.flags.movetime)) GUI:SameLine()
                GUI:Text("Boss: "..tostring(ac.IsInBossDungeon()))
                GUI:Text("AOE: "..tostring(ac.flags.canaoe)) GUI:SameLine()
                GUI:Text("Interrupt: "..tostring(ac.flags.caninterrupt)) GUI:SameLine()
                GUI:Text("Weave: "..tostring(ac.flags.canweave))
                GUI:Text("Loading: "..tostring(not Player.targetable)) GUI:SameLine()
                
                if (table.valid(Player:GetTarget())) then
                    ac.flags.toughness = Player:GetTarget().hp.max / Player.hp.max
                end
                GUI:Text("Tough: "..string.format("%.2f", ac.flags.toughness)) GUI:SameLine()
                GUI:Text("Boss: "..tostring(ac.flags.bosstarget))
                local t = Player:GetTarget()
                if(t ~= nil) then
                    GUI:Text("Target: "..tostring(t.name))
                    --Player:SetFacing(t.pos.x,t.pos.y,t.pos.z,true)
                    GUI:Text("GetPositional: "..tostring(ac.GetPositional(t))) GUI:SameLine()
                    GUI:Text("Distance: "..string.format("%.2f",t.distance2d))
                   -- GUI:Text("Cone: "..tostring(ac.EnemiesInsideCone(ac.range.cone,t))) GUI:SameLine()
                    local rad = math.atan2(t.pos.x-Player.pos.x, t.pos.z-Player.pos.z)
                    GUI:Text("Rad: "..string.format("%.2f",rad)) GUI:SameLine() GUI:Text("Deg: "..string.format("%.2f",math.deg(rad)))
                    --GUI:Text("DOT1: "..tostring(ac.HasDOT1(t)).." DOT2: "..tostring(ac.HasDOT2(t)))
                end
                --local c1 = ac.GetMaxEnemiesInsideConePoint(12)
                if (c1) then
                    GUI:Text("Cone2: "..tostring(c1.id).." Count: "..tostring(c1.ents))
                end
                --local t = ac.GetMaxEnemiesInsideRadiusRangePoint(5,10)
                if (t2) then
                    GUI:Text("RRadius: "..tostring(t.id))
                    local a = ActionList:Get(1,ac.Actions.BurstShot)
                    if (ac.GCD() and t.ents >= ac.settings.aoethreshold) then
                        Player:SetTarget(t.id)
                        a:Cast(t.id)
                    end
                end
                GUI:Text("Damaged: "..tostring(ac.flags.damagedfriends)) GUI:SameLine()
                GUI:Text("Friends: "..tostring(#ac.friends)) GUI:SameLine()
                GUI:Text("TD: "..tostring(ac.flags.teamdamage)) GUI:SameLine()
                GUI:Text("AOEHG: "..tostring(ac.IsAOEHealGood()))
                local pos = Player.pos
                GUI:Text("H:"..string.format("%.2f",Player.camera.h).." P:"..string.format("%.2f",Player.camera.pitch).." x:"..string.format("%.2f",Player.camera.x).." y:"..string.format("%2.f",Player.camera.y).." z:"..string.format("%.2f",Player.camera.z))
                czoom = GetGameSettings()[200].value
                if czoom == nil then d("[EASECore]-Something wrong with minion, can't query CameraZoom!") end
                cdeg = -1*(math.deg(Player.camera.pitch)-5)
                GUI:Text("cdeg:"..string.format("%2.f",cdeg).." czoom:"..tostring(czoom))
                if ac.targets.manual then GUI:Text("manual:"..tostring(ac.targets.manual.name)) end
                if not ac.flags.lastaction then GUI:Text("lastaction:"..tostring(ac.flags.lastaction)) end
                local mx, my = ac.W2S(GetMouseInWorldPos())
                GUI:Text("mx:"..tostring(mx).." my:"..tostring(my).." driving:"..tostring(PlayerDriving()))
                --local x, y = RenderManager:WorldToScreen({pos.x,pos.y,pos.z}, true)
                --GUI:Text("x: "..tostring(x).." y: "..tostring(y))
                --GUI:AddCircleFilled( x/2, 1-y, 100,GUI:ColorConvertFloat4ToU32(0.9,0.1,0.12,0.5),32)
            end
        end
        GUI:End()
        GUI:PopStyleVar(1)
        if ac.settings.autocombat then ac.DrawHitbox() end
    end
end
function ac.GCD()   -- returns true if Off GCD
    if (ac.IsBard()) then if (ActionList:Get(1,ac.Actions.BurstShot).isoncd) then return false else return true end end
    if (ac.IsPaladin()) then if (ActionList:Get(1,ac.Actions.FastBlade).isoncd) then return false else return true end end
    if (ac.IsWhiteMage()) then if (ActionList:Get(1,ac.Actions.Stone).isoncd) then return false else return true end end
end
function ac.GetDistance(ppos,tpos) return math.sqrt((tpos.x-ppos.x )^2 + (tpos.y-ppos.y)^2 + (tpos.z-ppos.z)^2) end
function ac.GetEnemiesInsideCone(radius, heading)
    local el = nil
    local entities = nil
    el = MEntityList("alive,attackable,targetable,maxdistance2d="..tostring(ac.range.cone))
    entities = {}
    for _, e in pairs(el) do
        if (e.attackable and e.targetable) then
            local target = e
            local entityHeading = nil
            if (heading < 0) then entityHeading = heading + 2 * math.pi else entityHeading = heading end
            local targetPos = target.pos
            local entityAngle = math.atan2(targetPos.x - Player.pos.x, targetPos.z - Player.pos.z) 
            local deviation = entityAngle - entityHeading
            local absDeviation = math.abs(deviation)
            local leftover = math.abs(absDeviation - math.pi)
            if (leftover > (math.pi * .75) and leftover < (math.pi * 1.25)) then
                table.insert(entities, e) -- entity is in front
            end
        end
    end
    ac.flags.enemiesinsidecone = #entities
    return #entities
end
function ac.GetEnemiesInsideRadius(radius)
    local el = EntityList("alive,attackable,targetable,maxdistance2d="..tostring(radius))
    local entities = {}
    for _, e in pairs(el) do table.insert(entities, e) end
    return entities
end
function ac.GetDeadFriends(radius)
    local el = EntityList.myparty or EntityList.crossworldparty
    local deadfriends = {}
    for _, e in pairs(el) do
        if (not e.alive and ac.GetDistance(Player.pos,e.pos) < radius and e.hp.percent == 0) then table.insert(friends, e) end
    end
    return deadfriends
end
function ac.GetFriends(radius)
    local el = EntityList.myparty or EntityList.crossworldparty
    local friends = {}
    ac.flags.damagedfriends = 0
    for _, e in pairs(el) do
        if (ac.GetDistance(Player.pos,e.pos) < radius) then
            table.insert(friends, e)
            if (e.hp.percent <= ac.settings.hpthreshold1) then
                ac.flags.damagedfriends = ac.flags.damagedfriends + 1
            end
        end
    end
    table.sort(friends, function(l,r) return (l.hp.percent) < (r.hp.percent) end)
    return friends
end
function ac.GetHeading(target)
    ac.flags.heading = math.atan2(target.pos.x-Player.pos.x,target.pos.z-Player.pos.z)
    return ac.flags.heading
end
function ac.GetJob()
    if ac.IsBard() then return "BaRD" end
    if ac.IsPaladin() then return "PLDin" end
    if ac.IsSage() then return "SaGE" end
    if ac.IsSummoner() then return "SMNer" end
    if ac.IsWhiteMage() then return "WHMage" end
end
function ac.GetMaxEnemiesInsideConePoint(radius)
    local el = MEntityList("alive,attackable,targetable,maxdistance2d="..tostring(ac.range.cone))
    local enemycone = {}
    if (el) then
        for _, e in pairs(el) do
            if (e.attackable and e.targetable and e.aggro) then
                local numEnts = ac.GetEnemiesInsideCone(radius, ac.GetHeading(e))
                table.insert(enemycone, {id=e.id, ents=numEnts})
            end
        end
        if (#enemycone > 1) then table.sort(enemycone, function(l,r) return (l.ents) > (r.ents) end) end
        return enemycone[1]
    end
end
function ac.GetBoss(range)
    local el = EntityList("alive,attackable,targetable,aggressive,maxdistance2d="..tostring(range))
    local boss = {}
    for _, e in pairs(el) do
        if (e.incombat and e.attackable and e.targetable and e.distance2d < range) then
            table.insert(boss, e)
        end
    end
    return boss[1]
end
function ac.GetMaxEnemiesInsideRadiusRangePoint(radius, range)
    local el = EntityList("alive, attackable, targetable")
    local enemyrangecircle = {}
    local entities = {}
    for _, e in pairs(el) do
        if (e.distance2d < range + radius and e.attackable and e.targetable) then
            table.insert(entities, e)
        end
    end
    --d("ENTS: "..tostring(#entities))
    for _, e in pairs(entities) do
        local numEnts = 0
        for i, j in pairs(entities) do
            if (ac.GetDistance(e.pos,j.pos) <= radius and e.aggro and e.distance2d < range) then
                numEnts = numEnts + 1
                --d("ADDED TO ENT "..tostring(numEnts).." id:"..tostring(e.id))
            end
        end
        if (numEnts > 0) then
            table.insert(enemyrangecircle,{id=e.id,ents=numEnts})
        end
    end
    --d("EENTS "..tostring(#enemyrangecircle))
    if (#enemyrangecircle > 1) then
        table.sort(enemyrangecircle, function(l,r) return (l.ents) > (r.ents) end)
    end
    --d(enemyrangecircle[1].id)
    return enemyrangecircle[1]
end
function ac.GetMobsInRange(range,incombat)
    local el = EntityList("alive,attackable,maxdistance2d="..tostring(range))
    ac.enemies = {}
    for _, e in pairs(el) do
        if (e.incombat == incombat and (true or e.name == "Striking Dummy") and e.distance2d < range and e.los2) then
            table.insert(ac.enemies, e)
        end
    end
    return ac.enemies
end
function ac.GetPositional(target)
    if (IsFront(target,false)) then return "front"
    elseif (IsFlanking(target,false)) then return "flank"
    elseif (IsBehind(target,false)) then return "rear" end
    return "undefined"
end
function ac.GetPrioritySingleHeal()
    ac.friends = ac.GetFriends(ac.range.heal)
    return ac.friends[1] or Player
end
function ac.GetPrioritySingleRevive()
    ac.deadfriends = ac.GetDeadFriends(ac.range.heal)
    table.sort(ac.deadfriends, function(l,r) return (ac.IsTank(l)) and not (ac.IsTank(r)) end)
    table.sort(ac.deadfriends, function(l,r) return (ac.IsHealer(l)) and not (ac.IsHealer(r)) end)
    return ac.deadfriends[1]
end
function ac.GetPrioritySingleTarget()
    local angrymobs = {}
    if ac.IsBard() then
        angrymobs = ac.GetMobsInRange(ac.range.basic,true)
        table.sort(angrymobs, function(l,r) return (l.hp.current) < (r.hp.current) end)
        --table.sort(angrymobs, function(l,r) return () < () end)
        table.sort(angrymobs, function(l,r) return not (ac.HasDOT(l,1) and ac.HasDOT(l,2)) and (ac.HasDOT(r,1) and ac.HasDOT(r,2)) end)
        table.sort(angrymobs, function(l,r)
            local dotl1, ownerl1, durl1 = ac.HasDOT(l,1) local dotl2, ownerl2, durl2 = ac.HasDOT(l,2) local dotr1, ownerr1, durr1 = ac.HasDOT(r,1) local dotr2, ownerr2, durr2 = ac.HasDOT(r,2)
            if not durl1 then durl1 =0 end if not durl2 then durl2 =0 end if not durr1 then durr1 =0 end if not durr2 then durr2 =0 end
            return (durl1 < ac.settings.dotrefresh or durl2 < ac.settings.dotrefresh) and not (durr1 < ac.settings.dotrefresh or durr2 < ac.settings.dotrefresh) end)
    end
    if ac.IsPaladin() then
        angrymobs = ac.GetMobsInRange(ac.range.long,true)
        table.sort(angrymobs, function(l,r) return (l.aggropercentage) < (r.aggropercentage) end)
        table.sort(angrymobs, function(l,r) return not (l.aggro) and (r.aggro) end)
    end
    if ac.IsSage() or ac.IsSummoner() or ac.IsWhiteMage() then
        angrymobs = ac.GetMobsInRange(ac.range.basic,true)
        table.sort(angrymobs, function(l,r) return (l.hp.current) < (r.hp.current) end)
    end
    return angrymobs[1]
end
function ac.GetPriorityTankPoke()
    if ac.IsPaladin() then
        local innocentmobs = ac.GetMobsInRange(ac.range.long,false)
        return innocentmobs[1]
    end
end
function ac.GetTeamDamageReached(damage) if (damage >= ac.flags.teamdamage) then return true else return false end end
function ac.HasBuff(name, target)
    local target = target or Player
    if (table.valid(target.buffs)) then
        for k, v in pairs(target.buffs) do
            local found = nil
            if (v.name == name) then
                return true, v.ownerid, v.duration
            end
        end
    end
    return false, "none", 0
end
function ac.HasDOT(target,dotnum)
    if ac.IsBard() then
        if dotnum == 1 then
            local a,b,c = ac.HasBuff("Venomous Bite",target) local d,e,f = ac.HasBuff("Caustic Bite",target)
            if Player.level < 64 then return a and b == Player.id else return d and e == Player.id end
        elseif dotnum == 2 then
            local a,b,c = ac.HasBuff("Windbite",target) local d,e,f = ac.HasBuff("Stormbite",target)
            if Player.level < 64 then return a and b == Player.id else return d and e == Player.id end
        end
    end
    if ac.IsWhiteMage() then
        if dotnum == 1 then
            local a,b,c = ac.HasBuff("Aero",target)
            return a and b == Player.id
        end
    end
end
function ac.InGame() return MGetGameState() == FFXIV.GAMESTATE.INGAME end
function ac.IsActionReady(action) return (action.level <= Player.level and not action.isoncd) end
function ac.IsAOECandidate(target) if (target and target.ents >= ac.settings.aoethreshold) then return target else return false end end
function ac.IsAOEGood(radius) return #ac.GetEnemiesInsideRadius(radius) >= ac.settings.aoethreshold end
function ac.IsAOEHealGood() return (ac.flags.damagedfriends >= #ac.friends/2) end
function ac.IsCombo(action) return ac.flags.lastaction == action end
function ac.IsBard(target) local t = target or Player return (t.job == ac.jobs.Archer or t.job == ac.jobs.Bard) end
function ac.IsPaladin(target) local t = target or Player return (t.job == ac.jobs.Gladiator or t.job == ac.jobs.Paladin) end
function ac.IsSage(target) local t = target or Player return (t.job == ac.jobs.Sage) end
function ac.IsSummoner(target) local t = target or Player return (t.job == ac.jobs.Arcanist or t.job == ac.jobs.Summoner) end
function ac.IsWhiteMage(target) local t = target or Player return (t.job == ac.jobs.Conjurer or t.job == ac.jobs.WhiteMage) end
function ac.IsTank(target) local t = target or Player return (ac.IsPaladin(t)) end
function ac.IsHealer(target) local t = target or Player return (ac.IsSage(t) or ac.IsWhiteMage(t)) end
function ac.IsMelee(target) end
function ac.IsRange(target) local t = target or Player return (ac.IsBard(t)) end
function ac.IsOnline(target) return target.onlinestatus == 43 end
function ac.IsDOTexpiring(target,dotnum)
    if ac.IsBard() then
        if dotnum == 1 then
            local a, b, c = ac.HasBuff("Venomous Bite", target) local d, e, f = ac.HasBuff("Caustic Bite", target)
            if (Player.level >= 64) then return d and f < ac.settings.dotrefresh else return a and c < ac.settings.dotrefresh end
        elseif dotnum == 2 then
            local a, b, c = ac.HasBuff("Windbite", target) local d, e, f = ac.HasBuff("Stormbite", target)
            if (Player.level >= 64) then return d and f < ac.settings.dotrefresh else return a and c < ac.settings.dotrefresh end
        end
    end
end
function ac.IsValidAttackTarget()
    local target = MGetTarget()
    if (target and target.alive and target.attackable) then --FUCKING LOS2 gave me a headache bug against Pandaemonium
        target.ents = 1
        ac.targets.manual = target
        return target
    else ac.targets.manual = nil return false end
end
function ac.IsValidHealTarget()
    local target = MGetTarget()
    if (target and target.alive and not target.attackable and target.los2) then ac.targets.manual = target return target else ac.targets.manual = nil return false end
end
function ac.IsValidReviveTarget()
    local target = MGetTarget()
    if (target and not target.alive and not target.attackable and target.los2) then ac.targets.manual = target return target else ac.targets.manual = nil return false end
end
function ac.IsInBossDungeon()
    if (Duty:GetQueueStatus() == 4 and not table.valid(Duty:GetActiveDutyObjectives()) or #ac.friends > 4) then
        return true
    end
    return false
end
function ac.IsSupported() if ac.IsBard() or ac.IsPaladin() or ac.IsWhiteMage() or ac.IsSage() or ac.IsSummoner() then return true else return false end end
function ac.SaveSettings() local save = FileSave(GetLuaModsPath().."EASECore\\settings.ini", ac.settings) end
function ac.ToggleDebug() ac.settings.debug = not ac.settings.debug ac.SaveSettings() end
function ac.Update()
    -- TIME SLICES --Player.targetable means game is in loading screen when false
    if (TimeSince(ac.timer.heartbeat.last) > ac.timer.heartbeat.frequency and Player.targetable) then ac.UpdateHeartbeat() end
    if (TimeSince(ac.timer.pulse.last) > ac.timer.pulse.frequency and Player.targetable) then ac.UpdatePulse() end
    -- TICKS
    if ac.settings.autocombat then
        if ac.IsBard() then ac.CombatBard() end
        if ac.IsPaladin() then ac.CombatPaladin() end
        if ac.IsSage() then ac.CombatSage() end
        if ac.IsSummoner() then ac.CombatSummoner() end
        if ac.IsWhiteMage() then ac.CombatWhiteMage() end
    end
end
function ac.UpdateTeamHealth()
    ac.friends = ac.GetFriends(ac.range.aoeheal)
    local teamdamage = 0
    for _, e in pairs(ac.friends) do
        teamdamage = teamdamage + (100 - e.hp.percent)
    end
    ac.flags.teamdamage = teamdamage
end
function ac.UpdateCombo()
    local lc = Player.castinginfo.lastcastid
    for _, e in pairs(ac.combo) do
        if e == lc then ac.flags.lastaction = e end
    end
end
function ac.UpdateGauge()
    if ac.IsSage() then
        ac.gauge.SGEcharges = Player.gauge[2]
        ac.gauge.SGEmeter = Player.gauge[1]
    end
    if ac.IsSummoner() then
        ac.gauge.SMNactivesummon = Player.gauge[9]
        ac.gauge.SMNaetherflow = Player.gauge[10]
        ac.gauge.SMNlockdown = Player.gauge[1]
        ac.gauge.SMNsummontime = Player.gauge[2]
        ac.gauge.SMNstacks = Player.gauge[3]
        ac.gauge.SMNruby = Player.gauge[5]
        ac.gauge.SMNtopaz = Player.gauge[6]
        ac.gauge.SMNemerald = Player.gauge[7]
    end
end
function ac.UpdateHeartbeat()
    ac.timer.heartbeat.last = Now()
    if(not table.valid(ml_navigation.path) and Player.settings.movemode == 0) then Player:SetMoveMode(1) end
    if IsControlOpen("RecommendList") then UseControlAction("RecommendList","Close") end
    if IsControlOpen("PlayGuide") then UseControlAction("PlayGuide","Destroy") end
    local sprint = ActionList:Get(5,4)
    if (ac.flags.movetime >= 5 and ac.settings.autocombat and not sprint.isoncd and Player.Incombat == false and not IsMounted() and Player:IsMoving() and not ac.IsInBossDungeon()) then -- need proper logic here when to cast, preferrably trying to avoidAOE
        sprint:Cast()
    end
end
function ac.UpdatePulse()
    ac.timer.pulse.last = Now()
    --if IsControlOpen("SelectYesno") then UseControlAction("SelectYesno", "Yes") end
    
    if Player:IsMoving() and ac.flags.ismoving then ac.flags.movetime = ac.flags.movetime + (ac.timer.pulse.frequency/1000) end
    if not Player:IsMoving() and not ac.flags.ismoving then ac.flags.idletime = ac.flags.idletime + (ac.timer.pulse.frequency/1000) end
    if Player:IsMoving() and not ac.flags.ismoving then ac.flags.ismoving = not ac.flags.ismoving ac.flags.idletime = 0
    elseif not Player:IsMoving() and ac.flags.ismoving then ac.flags.ismoving = not ac.flags.ismoving ac.flags.movetime = 0 end
    ac.UpdateCombo()
    ac.UpdateGauge()
    ac.UpdateSongs()
    ac.UpdateTarget()
    ac.UpdateTeamHealth()
    ac.UpdateWeave()
end
function ac.UpdateSongs()
    if (ac.HasBuff("The Wanderer's Minuet")) then ac.flags.songlist = 2 end
    if (ac.HasBuff("Mage's Ballad")) then ac.flags.songlist = 3 end
    if (ac.HasBuff("Army's Paeon")) then ac.flags.songlist = 1 end
end
function ac.UpdateTarget()      -- Needs rework and abstraction.. but working for now
    if ac.IsBard() then
        --ac.friends = ac.GetFriends(ac.range.heal)
        ac.targets.cone = ac.GetMaxEnemiesInsideConePoint(ac.range.cone)
        ac.targets.rangecircle = ac.GetMaxEnemiesInsideRadiusRangePoint(ac.range.radiusRainOfDeath, ac.range.basic)
        ac.targets.single = ac.GetPrioritySingleTarget()
        ac.targets.boss = ac.GetBoss(ac.range.basic)
    end
    if ac.IsPaladin() then
        ac.targets.tankpoke = ac.GetPriorityTankPoke()
        ac.targets.single = ac.GetPrioritySingleTarget()
        ac.targets.short = ac.GetEnemiesInsideRadius(ac.range.short)
    end
    if ac.IsSage() then
        ac.targets.heal = ac.GetPrioritySingleHeal()
        ac.targets.revive = ac.GetPrioritySingleRevive()
        ac.targets.single = ac.GetPrioritySingleTarget()
    end
    if ac.IsSummoner() then
        ac.targets.rangecircle = ac.GetMaxEnemiesInsideRadiusRangePoint(5, ac.range.basic)
        ac.targets.heal = ac.GetPrioritySingleHeal()
        ac.targets.revive = ac.GetPrioritySingleRevive()
        ac.targets.single = ac.GetPrioritySingleTarget()
        ac.targets.boss = ac.GetBoss(ac.range.basic)
    end
    if ac.IsWhiteMage() then --section still needs converting to new design
        local el = EntityList("alive, aggro, attackable")
        ac.enemies = {}
        for _, entity in pairs(el) do
            if (entity.distance2d < ac.range.basic and entity.los2 and entity.aggropercentage > 0) then
                table.insert(ac.enemies, entity)
            end
        end
        table.sort(ac.enemies, function (l,r) return (l.hp.current) < (r.hp.current) end)
        table.sort(ac.enemies, function (l,r) return (l.aggropercentage) > (r.aggropercentage) end)
        table.sort(ac.enemies, function(l,r) return not ac.HasDOT(l,1) and ac.HasDOT(r,1) end)
        if (#ac.enemies > 0) then
            Player:SetTarget(ac.enemies[1].id)
            d("ATTACKING!: "..tostring(#ac.enemies))
            for _, e in pairs(ac.enemies) do
                d(tostring(e.name))
            end
        end
    end
end
function ac.UpdateWeave() -- needs abstraction
    if ac.IsBard() then
        local a = ActionList:Get(1, ac.Actions.BurstShot)
        if (a.cd > a.cdmax / 4 and a.cd < a.cdmax / 4 * 3) then ac.flags.canweave = true else ac.flags.canweave = false end
    end
    if ac.IsPaladin() then
        local a = ActionList:Get(1, ac.Actions.FastBlade)
        if (a.cd > a.cdmax / 3 and a.cd < a.cdmax / 4 * 3) then ac.flags.canweave = true else ac.flags.canweave = false end
    end
    if ac.IsSage() or ac.IsSummoner() or ac.IsWhiteMage() then
        if not (Player.castinginfo.channeltime > 0) then ac.flags.canweave = true else ac.flags.canweave = false end
    end
end
function ac.W2S(pos) return RenderManager:WorldToScreen(pos,true) end
RegisterEventHandler("Gameloop.Update", ac.Update, "EASECore")
RegisterEventHandler("Gameloop.Draw", ac.Draw, "EASECore")