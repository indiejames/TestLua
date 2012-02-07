function print_player_ship_position()

    -- get the location of the player's ship
    player_x, player_y = ship.player_ship_position()
    
      -- print position to console
    print(string.format("Lua says player ship is at (%f, %f)", player_x,player_y))
    
end