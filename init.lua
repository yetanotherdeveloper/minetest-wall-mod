
print("Wall mod started!")

local function make_z_wall(start_pos, length, height, node_type)
   for tmp_pos=start_pos.z,start_pos.z+length-1 do
	   local npos = {x = start_pos.x, y = start_pos.y, z = tmp_pos}
	   for i=npos.y,npos.y+height-1 do
		--print("Buduje sciane Z "..npos.z)
		minetest.set_node(npos, { name = node_type})
		npos = vector.add(npos, {x = 0, y=1, z=0})
	   end
   end
end

local function make_x_wall(start_pos, length, height, node_type)
   for tmp_pos=start_pos.x,start_pos.x+length-1 do
	   local npos = {x = tmp_pos, y = start_pos.y, z = start_pos.z}
	   for i=npos.y,npos.y+height-1 do
		--print("Buduje sciane X x="..npos.x.." y="..npos.y.." z="..npos.z)
		minetest.set_node(npos, { name = node_type})
		npos = vector.add(npos, {x = 0, y=1, z=0})
	   end
   end
end


local function register_wall(node_type , node_texture)
        local node_type_stripped = string.gsub(node_type, "default:", "")
	local node_name = "wall:"..node_type_stripped .. "_fence"

	minetest.register_node(node_name, {
		    description = "Fence around you",
			tiles = { node_texture },
			diggable = true,
			sunlight_propagates = true,
			on_use = function(itemstack, user, pointed_thing)
			print("Lets build a house together!")
			-- Remove original thrown node
			local halflength = 30 
			local height = 8
			local npos = vector.subtract(user:get_pos(), {x = halflength, y = 0, z = halflength})
			--print("Middle point of wall x="..npos.x.." y="..npos.y.." z="..npos.z)
			make_x_wall(npos, 2*halflength, height, node_type)
			make_z_wall(npos, 2*halflength, height, node_type)
			make_x_wall(vector.add(npos, {x = 0, y = 0, z = 2*halflength}),2*halflength, height, node_type)
			make_z_wall(vector.add(npos, {x = 2*halflength, y = 0, z = 0}),2*halflength, height, node_type)
	    end,
			})
	--  b   b
	--  b   b
	--  b b b 
	minetest.register_craft({
		output = node_name .. " 3",
		recipe = {
			{node_type, "", 		    node_type  },
			{node_type, "", 		    node_type  },
			{node_type, node_type,  node_type}
		}
	})
end

register_wall("default:brick",  "brick_fence.png")
register_wall("default:dirt_with_grass",  "dirt_with_grass_fence.png")
register_wall("default:silver_sandstone_brick",  "silver_standstone_brick_fence.png")

