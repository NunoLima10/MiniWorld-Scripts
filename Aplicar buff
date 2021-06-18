function AplicarBuff(e)
    
 local itemDesejado=236 --colocar id do item da condição 
 local buffID=50000001-- colocar id do buff
 
 local result,uin=Player:getMainPlayerUin()  
 
 local itemId=e.itemid
if itemId== itemDesejado then 
    
Actor:addBuff(uin,buffID,1,10000)
    end
    
end 
    

ScriptSupportEvent:registerEvent([=[Player.ConsumeItem]=],AplicarBuff)
