NCfg:AddAddon('Saver')
NCfg:Set('Saver','Max. Items Spawn Distance', 500,'num')
NCfg:Set('Saver','Delay Between Single Propspawn',0.5,'num')
NCfg:Set('Saver','Save Cooldown',5,'num')
NCfg:Set('Saver','Classes To Save',{'prop_physics'},'table')
NCfg:Set('Saver','Create Indestructible Items',true,'bool')
-- NCfg:Set('Saver','Текстовое поле 1','300','text')

util.AddNetworkString(ENL.Saver.netstr)