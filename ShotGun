--Script by Play Craft
-- Caso usar bala custumizada recomendo aumentar a velociade de atenuação
id_Arma=15000  -- substitui pelo id da sua arma
id_bala=15003  -- substitui pelo id da sua bala
velociade_bala=450   
function shotgun(e)
   
    local itemID = e.itemid
    local player = e.eventobjid
  
    local  res,xpos,ypos,zpos = Player:getPosition(player)
    local  res,dirx,diry,dirz = Actor:getFaceDirection(player) 
    
   if itemID==id_Arma then
      Player:playMusic(player,10631,100,1,false)
      World:spawnProjectileByDir(player,id_bala, xpos, ypos+1, zpos,dirx+0.1, diry,dirz+0.2,velociade_bala)
      World:spawnProjectileByDir(player,id_bala, xpos, ypos+1, zpos,dirx-0.1, diry-0.1,dirz-0.2,velociade_bala)
      World:spawnProjectileByDir(player,id_bala, xpos, ypos+1, zpos,dirx-0.05, diry,dirz-0.07,velociade_bala)
      World:spawnProjectileByDir(player,id_bala, xpos, ypos+1, zpos,dirx+0.05, diry,dirz+0.07,velociade_bala)
       
       World:spawnProjectileByDir(player,id_bala, xpos, ypos+1, zpos,dirx+0.1, diry-0.1,dirz+0.2,velociade_bala)
       World:spawnProjectileByDir(player,id_bala, xpos, ypos+1, zpos,dirx, diry-0.1,dirz-0.2,velociade_bala)
       World:spawnProjectileByDir(player,id_bala, xpos, ypos+1, zpos,dirx+0.05, diry,dirz-0.07,velociade_bala)
       World:spawnProjectileByDir(player,id_bala, xpos, ypos+1, zpos,dirx-0.05, diry,dirz+0.07,velociade_bala)
   end
end 
ScriptSupportEvent:registerEvent([=[Player.UseItem]=],shotgun)
  
