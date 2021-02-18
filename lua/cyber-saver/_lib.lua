-- [do not obfuscate]

CW = CW or {}
CW.Saver = CW.Saver or {}
CW.Saver.tool = 'cyber_saver'
CW.Saver.netstr = 'Cyber Saver'
CW.Saver.freezeCvarName = CW.Saver.tool..'_freeze'
CW.Saver.dataDir = CW.Saver.tool

local Ents = CW:Lib('ents')
local l = CW:Lib('translator')

function CW.Saver:IsPlyHolding(ply)
  local act = ply:GetActiveWeapon()
  local tool = ply:GetTool()
  return (IsValid(act) and act:GetClass() == 'gmod_tool' and tool
    and tool.Mode == CW.Saver.tool)
end

function CW.Saver:CanProceedEnt(ply,ent,bDontNotify)
  if !IsValid(ply) or !IsValid(ent) then return end
  local function Notify(ply,message)
    if !bDontNotify then
      ply:Notify(message)
    end
  end

  if !table.HasValue(NCfg:Get('Saver','Classes To Save'), ent:GetClass())
  and ent:GetClass() != 'class C_PhysPropClientside'
  then
    Notify(ply,l('The item must be a prop',ply:GetLang())..'!')
    return
  end

  if ply:GetPos():Distance(ent:GetPos()) > NCfg:Get('Saver','Max. Items Spawn Distance') then
    Notify(ply,l('There is too far for the object',ply:GetLang())..'!')
    return false
  end

  local tr = util.TraceLine({start=ply:EyePos(),endpos=ent:WorldSpaceCenter(),
    filter = function(e) if e.SID != ply.SID then return true end end
  })

  if tr.Hit then
    Notify(ply,l('The item is not in your view area',ply:GetLang())..'!')
    return false
  end

  if Ents:IsStuckingPly(ent) then
    Notify(ply,l('Player is blocking item spawn',ply:GetLang())..'!')
    return false
  end
  
  return true
end