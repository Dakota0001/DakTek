if SERVER then
	hook.Add( "InitPostEntity", "DakTekRunOnLoadHook", function()
		local Settings = physenv.GetPerformanceSettings() // copy table from physenfv
		Settings.MaxVelocity = 1000000 // change max velocity
		Settings.MaxAngularVelocity = 1000000
		physenv.SetPerformanceSettings(Settings) // push max velocity back into engine.
		print("DakTekLoaded")
	end)

	DakTekEntList = {} --Create Entity list for storing things people spawn
	--Setup global daktek function for setting up affected entities.
	function DakTekSetupNewEnt(ent)
		if IsValid(ent) and not (string.Explode("_",ent:GetClass(),false)[1] == "dak") then --make sure its not daktek stuff
	 		--setup values
	 		ent.DakHealth = ent:GetPhysicsObject():GetMass()/20
	 		ent.DakRed = ent:GetColor().r
			ent.DakGreen = ent:GetColor().g
			ent.DakBlue = ent:GetColor().b
			ent.DakName = "Armor"
	 		ent.DakMaxHealth = ent:GetPhysicsObject():GetMass()/20
	 		--DakTekEntList[ ent:EntIndex() ] = ent -- add to list
	 		ent.DakPooled = 0
		else
			--exceptions for bots
			if ent:GetClass()=="dak_bot" then
				--ent.DakHealth = ent:GetPhysicsObject():GetMass()/20
				ent.DakHealth = 10
		 		ent.DakRed = ent:GetColor().r
				ent.DakGreen = ent:GetColor().g
				ent.DakBlue = ent:GetColor().b
				ent.DakName = "Armor"
				ent.DakMaxHealth = 10
		 		--ent.DakMaxHealth = ent:GetPhysicsObject():GetMass()/20
		 		--DakTekEntList[ ent:EntIndex() ] = ent -- add to list
		 		ent.DakPooled = 0
			end
		end
	end
end
if CLIENT or game.SinglePlayer() then
	hook.Add( "InitPostEntity", "DakTekDupeAdderHook", function()
		if not(file.Exists( "advdupe2/daktek public dupes/", "DATA" )) then
			file.CreateDir( "advdupe2/daktek public dupes/" )
		end
		--example line to not have it overwrite files
		--if not(file.Exists( "advdupe2/daktek public dupes/centurion.txt", "DATA" )) then
		--	file.Write( "advdupe2/daktek public dupes/centurion.txt", file.Read( "centurion.lua", "LUA" ) )
		--end
		file.Write( "advdupe2/daktek public dupes/centurion.txt", file.Read( "centurion.lua", "LUA" ) )
		file.Write( "advdupe2/daktek public dupes/hellbringer.txt", file.Read( "hellbringer.lua", "LUA" ) )
		file.Write( "advdupe2/daktek public dupes/shadow cat.txt", file.Read( "shadowcat.lua", "LUA" ) )
		file.Write( "advdupe2/daktek public dupes/summoner.txt", file.Read( "summoner.lua", "LUA" ) )
		file.Write( "advdupe2/daktek public dupes/urbanmech.txt", file.Read( "urbanmech.lua", "LUA" ) )
	end)
end


