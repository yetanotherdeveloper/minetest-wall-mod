
print("Wall mod started!")

local function make_z_wall(start_pos, length, height)
   for tmp_pos=start_pos.z,start_pos.z+length-1 do
	   local npos = {x = start_pos.x, y = start_pos.y, z = tmp_pos}
	   for i=npos.y,npos.y+height-1 do
		--print("Buduje sciane Z "..npos.z)
		minetest.set_node(npos, { name = "default:brick" })
		npos = vector.add(npos, {x = 0, y=1, z=0})
	   end
   end
end

local function make_x_wall(start_pos, length, height)
   for tmp_pos=start_pos.x,start_pos.x+length-1 do
	   local npos = {x = tmp_pos, y = start_pos.y, z = start_pos.z}
	   for i=npos.y,npos.y+height-1 do
		--print("Buduje sciane X x="..npos.x.." y="..npos.y.." z="..npos.z)
		minetest.set_node(npos, { name = "default:brick" })
		npos = vector.add(npos, {x = 0, y=1, z=0})
	   end
   end
end


minetest.register_node("wall:brick_fence", {
	    description = "Brick Fence around you",
	        tiles = { "brick_fence.png" },
		diggable = true,
		sunlight_propagates = true,
		on_use = function(itemstack, user, pointed_thing)
		print("Lets build a house together!")
		-- Remove original thrown node
		local halflength = 30 
		local npos = vector.subtract(user:get_pos(), {x = halflength, y = 0, z = halflength})
                --print("Middle point of wall x="..npos.x.." y="..npos.y.." z="..npos.z)
		make_x_wall(npos, 2*halflength, 5)
		make_z_wall(npos, 2*halflength, 5)
		make_x_wall(vector.add(npos, {x = 0, y = 0, z = 2*halflength}),2*halflength, 5)
		make_z_wall(vector.add(npos, {x = 2*halflength, y = 0, z = 0}),2*halflength, 5)
    end,
		})
--  b   b   b
--  b   b   b
--  b b b b b
--
minetest.register_craft({
	output = "wall:brick_fence 99",
	recipe = {
		{"default:brick", "", 		    "default:brick"  },
		{"default:brick", "", 		    "default:brick"  },
		{"default:brick", "default:brick",  "default:brick"  }
	}
})
