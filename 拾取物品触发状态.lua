function AplicarBuff(e)
--按照需求自己改参数，a=itemNeeded，b=buffId，c=buffLevel，d=buffTime
    local result,uin=Player:getMainPlayerUin()
    local i=e.itemid
    if i==a then
         Actor:addBuff(uin,b,c,d)
    end
end
    
ScriptSupportEvent:registerEvent([=[Player.ConsumeItem]=],AplicarBuff)
