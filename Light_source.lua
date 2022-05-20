---- settings 
--cofigure  os IDS na sua escolha/configure the IDS of your choice

Block_id = 2001        --bloco de luz/light block
Item_id = 11055        -- id do item / item id
Battery_level = 60     -- 1 minuto -tempo em segundos/1 minute -time in seconds
Uses_battery = true    -- usa bateria ou não /use battery or not  true/false


 --- Code by PlayCraft uid 869061
 -- report contato.playcraft10@gmail.com
 --  version 0.1
 
 
Players_in_game = {}

-----------Light_source
Light_source = {
    position_x = 0,
    position_y = 0,
    position_z = 0,
    block_id = 0,
    item_id = 0,
    battery_level = 0,
    uses_battery = false,
    without_battery = false,
    active = false
}


function Light_source:new(table)
    table = table or {}
    setmetatable(table, self)
    self.__index = self
    return table  
end


function Light_source:remove_block()

    local result, id = Block:getBlockID(self.position_x, self.position_y, self.position_z)
    
    if id == self.block_id then
        Block:destroyBlock(self.position_x, self.position_y, self.position_z,false) 
    end 

end


function Light_source:palce_block(x, y, z)
  
    local air_block_id = Block:isSolidBlock(x,y,z)

    if self.active and air_block_id == 1001 and not self.without_battery then
        self.position_x = x
        self.position_y = y
        self.position_z = z
        Block:placeBlock(self.block_id, x, y, z, 0)
       
    end

end

  

function Light_source:update(x,y,z)
    self:remove_block()
    self:palce_block(x ,y ,z)
end



function Light_source:discharge_battery()
    
    if self.uses_battery and self.active and not self.without_battery then
       self.battery_level = self.battery_level - 1  
       if self.battery_level <= 0 then 
          self.without_battery = true
          self:remove_block()
       end
     end 

end



function Light_source:charge_battery(battery)
    if self.uses_battery then
       self.battery_level = battery  
    end
end



function Light_source:set_state(state)
    self.active = state
end


-------------------Player
Player = {
    uid = 0,
    Ligth = Light_source:new({
        position_x = 0,
        position_y = 0,
        position_z = 0,
        block_id = 0,
        item_id = 0,
        battery_level = 0,
        uses_battery = false,
        without_battery = false,
        active = false
    
    })
}

function Player:new(table)
    table = table or {}
    setmetatable(table, self)
    self.__index = self
    return table  
end

---------- Game Events

function login_player(e)
    
    local player_uid = e.eventobjid
    local result,id=Player:getCurToolID(player_uid)
    
    Players_in_game[#Players_in_game + 1] = Player:new({
    uid = player_uid,
    Ligth = Light_source:new({
        position_x = 0,
        position_y = 0,
        position_z = 0,
        block_id = Block_id,
        item_id = Item_id,
        battery_level = Battery_level,
        uses_battery = Uses_battery,
        without_battery = false,
        active = false
    })

})
    if id == Item_id then 
        local result,x ,y ,z = Actor:getPosition(player_uid)
        
        Players_in_game[#Players_in_game].Ligth:set_state(true)
        Players_in_game[#Players_in_game].Ligth:update(x,y,z)
    end



end
ScriptSupportEvent:registerEvent([=[Game.AnyPlayer.EnterGame]=],login_player)


function get_player(uid)
    for index = 1 ,#Players_in_game  do
        if Players_in_game[index].uid == uid then
            return Players_in_game[index]
        end
    end
    return nil
    
end


function item_selectShortcut(e)
    
    local player_uid = e.eventobjid
    local item = e.itemid
    local result,x ,y ,z = Actor:getPosition(player_uid)
    
    local player = get_player(player_uid)
    
    player.Ligth:set_state(player.Ligth.item_id == item)
    player.Ligth:update(x,y,z)

end
ScriptSupportEvent:registerEvent([=[Player.SelectShortcut]=],item_selectShortcut)    



function player_move(e)
    
    local player_uid = e.eventobjid
    
    local player = get_player(player_uid)
    
    local result,x,y,z=Actor:getPosition(player_uid)
    
    player.Ligth:update(x,y,z)
    
end 
ScriptSupportEvent:registerEvent([=[Player.MoveOneBlockSize]=],player_move)  



function player_drop_item(e)
    
    local player_uid = e.eventobjid
    
    local player = get_player(player_uid)
   
    
    if e.itemid == player.Ligth.item_id and player.Ligth.active then
        player.Ligth:remove_block()
        player.Ligth.active = false
    end 
end 
ScriptSupportEvent:registerEvent([=[Player.DiscardItem]=],player_drop_item)    



function update_battery(e)
    
    
   if  type(e.second) == "number" then
    for index = 1 ,#Players_in_game do
        Players_in_game[index].Ligth:discharge_battery()
    end 
  end

end 
ScriptSupportEvent:registerEvent([=[Game.RunTime]=],update_battery)  

