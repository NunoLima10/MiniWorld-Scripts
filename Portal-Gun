--Scrip by Play Craft
--Variaveis globais
Portal1={on=false,areaid=0,x=0,y=0,z=0}
Portal2={on=false,areaid=0,x=0,y=0,z=0}




function validar_local(x,y,z)
    
     bloco1=Block:isSolidBlock(x,y+1,z)
     bloco2=Block:isSolidBlock(x,y+2,z)
     
    if bloco1 == 1001 and bloco2 == 1001 then
        return  true
    else
        return false
    end

end

function criar_Portal(x,y,z)
    
    if not Portal1.on and not Portal2.on then 
        
       local result,areaid=Area:createAreaRect({x=x,y=y+1,z=z},{x=0,y=1,z=0})
         --Chat:sendSystemMsg("Areia criada com id"..areaid)
         --Area:fillBlock(areaid,104,0)
         World:playParticalEffect(x,y,z,1250,1)--portal
         World:playParticalEffect(x,y+1,z,1189,2)--circulo
         World:playSoundEffectOnPos({x=x,y=y,z=z},10082,100,1,false)
        
        Portal1.on=true
        Portal1.areaid=areaid
        Portal1.x=x
        Portal1.y=y
        Portal1.z=z
        
        
    elseif  Portal1.on and not Portal2.on then
   
    local result,areaid=Area:createAreaRect({x=x,y=y+1,z=z},{x=0,y=1,z=0})
         --Chat:sendSystemMsg("Areia criada com id"..areaid)
         --Area:fillBlock(areaid,104,0)
         
         World:playParticalEffect(x,y,z,1250,1)--portal
         World:playParticalEffect(x,y+1,z,1192,2)--circulo
         World:playSoundEffectOnPos({x=x,y=y,z=z},10082,100,1,false)
         
        Portal2.on=true
        Portal2.areaid=areaid
        Portal2.x=x
        Portal2.y=y
        Portal2.z=z
        
        
    else
        
        --Chat:sendSystemMsg("Areias destruidas")
        --Area:clearAllBlock(Portal1.areaid,104)
        --Area:clearAllBlock(Portal2.areaid,104)
        
        World:playParticalEffect(Portal1.x,Portal1.y+1,Portal1.z,1308,1)
        World:playParticalEffect(Portal2.x,Portal2.y+1,Portal2.z,1308,1)
         
        World:playSoundEffectOnPos({x=Portal1.x,y=Portal1.y,z=Portal1.z},10094,100,1,false)
        World:playSoundEffectOnPos({x=Portal2.x,y=Portal2.y,z=Portal2.z},10094,100,1,false)
        
        
        
        World:stopEffectOnPosition(Portal1.x,Portal1.y,Portal1.z,1250)
        World:stopEffectOnPosition(Portal1.x,Portal1.y+1,Portal1.z,1189)
        
        World:stopEffectOnPosition(Portal2.x,Portal2.y,Portal2.z,1250)
        World:stopEffectOnPosition(Portal2.x,Portal2.y+1,Portal2.z,1192)
         
        Area:destroyArea(Portal1.areaid)
        Area:destroyArea(Portal2.areaid)

        Portal1.on=false
        Portal2.on=false

   end
end
function Teleportar(e)
    local areaid=e.areaid
    local player=e.eventobjid
    
    
    if Portal1.areaid==areaid and Portal1.on then
        
        if Portal2.on then
             Portal2.on=false
             
             Actor:playBodyEffectById(0,1358,1)
             Player:playMusic(player,10471,100,1,false)
             
             Player:setPosition(player,Portal2.x,Portal2.y+1,Portal2.z)
             threadpool:wait(1)
             Portal2.on=true
             
        else
              Chat:sendSystemMsg("#WTeleporte não disponivel")
              Player:playMusic(player,10960,100,1,false)
        end
   end
    if Portal2.areaid==areaid and  Portal2.on then
        if Portal1.on then
             Portal1.on=false
             
             Actor:playBodyEffectById(0,1356,1)
             Player:playMusic(player,10471,100,1,false)
             
             Player:setPosition(player,Portal1.x,Portal1.y+1,Portal1.z)
             threadpool:wait(1)
             Portal1.on=true
        end
    end

end

function main(e)
    local x=e.x
    local y=e.y
    local z=e.z
    local teste=e.blockid
    
    Chat:sendSystemMsg(teste, 0)


    if validar_local(x,y,z) then
        --Chat:sendSystemMsg("Local Valido")
        criar_Portal(x,y,z)
        
    else 
    Chat:sendSystemMsg("#WLocal Invalido")
     World:playParticalEffect(x,y+1,z,1363,1)
     World:playSoundEffectOnPos({x=x,y=y,z=z},10960,100,1,false)
     
    return
    end
   
end
ScriptSupportEvent:registerEvent([=[Actor.Projectile.Hit]=], main)
ScriptSupportEvent:registerEvent([=[Player.AreaIn]=],Teleportar)
  
