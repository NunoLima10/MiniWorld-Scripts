--ID dos encantamenros
--[[
    Espada
5 Ataque Voador*
6 Afiado*
7 Caçador de Humanos
8 Caçador de animais
9 Caçador de demonios*
10 Inflamar* 
11 Repelir
29 Caçador de selvagens]]--


RedBlockId=681
GreenBlockId=680
BlueBlockId=678
IdEnchant=0
SwordEnchants={5,6,10,29,9}
PickaxeEnchants={15,25}
ArmorEnchants={23,16,22,18,19}
function encantar(e)
    
  local player =e.eventobjid
  local BlockId=e.blockid
    
    if BlockId==RedBlockId then
        for i=1,#SwordEnchants do
            IdEnchant=SwordEnchants[i]
            Actor:addEnchant(player ,5,IdEnchant,5)
        end
        end
     if BlockId==GreenBlockId then
        for i=1,#PickaxeEnchants do
            IdEnchant=PickaxeEnchants[i]
            Actor:addEnchant(player ,5,IdEnchant,5)
           end  
        Actor:addEnchant(player,5,26,3)
     end
if BlockId==BlueBlockId then
        for i=1,#ArmorEnchants do
            IdEnchant=ArmorEnchants[i]
            Actor:addEnchant(player ,5,IdEnchant,5)
           end  
  end
    
    
    
    
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],encantar)





