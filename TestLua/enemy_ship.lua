function process(npc_ship)

 -- get the location of the player's ship
    player_x, player_y = ship.player_ship_position()
    
    -- get the location npc ship
    x, y = ship.get_ship_position(npc_ship)
    
    -- move this ship toward the player
    if player_x < x then
          ship.press_left_button(npc_ship)
    elseif player_x > x then
    ship.press_right_button(npc_ship)
    end
    
    if player_y < y then
        ship.press_bottom_button(npc_ship)
    elseif player_y > y then
        ship.press_top_button(npc_ship)
    end

end