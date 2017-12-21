DakTekDamagePermissionsClientPanel = nil
DakTekDamagePermissionsAdminPanel = nil
DakTekDamagePermissionsConVarsLastCheck = 0

CreateConVar( "DakTekDamagePermissionWarMode", "0" )
CreateConVar( "DakTekDamagePermissionBuildMode", "0" )

local function DakTekDamagePermissionsPopulateClientPanel(panel)
	if not(LocalPlayer():IsBot()) then
		if (!DakTekDamagePermissionsClientPanel) then
			DakTekDamagePermissionsClientPanel = panel
		end
		if !GetConVar( "DakTekDamagePermission"..LocalPlayer():SteamID64()..LocalPlayer():SteamID64() ) then
			CreateClientConVar( "DakTekDamagePermission"..LocalPlayer():SteamID64()..LocalPlayer():SteamID64(), "1", true, true )
		end

		local PlayerList = player.GetAll()	
		for i=1, #PlayerList do
			if not(PlayerList[i]:IsBot()) then
				if not(PlayerList[i]:SteamID64()==LocalPlayer():SteamID64()) then
					if !GetConVar( "DakTekDamagePermission"..LocalPlayer():SteamID64()..PlayerList[i]:SteamID64() ) then
						CreateClientConVar( "DakTekDamagePermission"..LocalPlayer():SteamID64()..PlayerList[i]:SteamID64(), "1", true, true )
					end
					
					if !GetConVar( LocalPlayer():SteamID64() .. PlayerList[i]:SteamID64() .. "DakTekDP" ) then
						panel:AddControl("CheckBox", {
							Label = PlayerList[i]:GetName(),
							Command = "DakTekDamagePermission"..LocalPlayer():SteamID64()..PlayerList[i]:SteamID64()
						})
						CreateClientConVar( LocalPlayer():SteamID64() .. PlayerList[i]:SteamID64() .. "DakTekDP", "1", false, false )
					end
				end
			end
		end
	end
end

function DakTekDamagePermissionsOnPopulateToolMenu()
	spawnmenu.AddToolMenuOption("Options", "DakTek", "DakTekDamagePermissions", "Damage Permission", "", "", DakTekDamagePermissionsPopulateClientPanel)
end

hook.Add("PopulateToolMenu", "DakTekDamagePermissionsMenuClient", DakTekDamagePermissionsOnPopulateToolMenu)

function DakTekDamagePermissionsSpawnMenuOpen()	
	if (DakTekDamagePermissionsClientPanel) then
		DakTekDamagePermissionsPopulateClientPanel(DakTekDamagePermissionsClientPanel)
	end
end
hook.Add("SpawnMenuOpen", "DakTekDamagePermissionsSpawnMenuOpen", DakTekDamagePermissionsSpawnMenuOpen)

local function DakTekDamagePermissionConVarsThink()
	if CLIENT then
		if DakTekDamagePermissionsConVarsLastCheck+5<CurTime() then
			local ply = LocalPlayer()
			if not(ply:IsBot()) then
				if !GetConVar( "DakTekDamagePermission"..ply:SteamID64()..ply:SteamID64() ) then
					CreateClientConVar( "DakTekDamagePermission"..ply:SteamID64()..ply:SteamID64(), "1", true, true )
				end
				local PlayerList = player.GetAll()
				for i=1, #PlayerList do
					if not(PlayerList[i]:IsBot()) then
						if !GetConVar( "DakTekDamagePermission"..ply:SteamID64()..PlayerList[i]:SteamID64() ) then
							CreateClientConVar( "DakTekDamagePermission"..ply:SteamID64()..PlayerList[i]:SteamID64(), "1", true, true )
						end
					end
				end
			end
			DakTekDamagePermissionsConVarsLastCheck = CurTime()
		end
	end
end
hook.Add("Think","DakTekDamagePermissionsConVarsThinkHook",DakTekDamagePermissionConVarsThink)


hook.Add( "PlayerSay", "DakTekDamageModeChatChecks", function( ply, text, team )
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		if text == "!DakTekWarMode 1" then
			RunConsoleCommand( "DakTekDamagePermissionWarMode", 1 )
			for k, ply in pairs( player.GetAll() ) do
				ply:ChatPrint( "DakTek War Mode Enabled" )
			end
		end
		if text == "!DakTekWarMode 0" then
			RunConsoleCommand( "DakTekDamagePermissionWarMode", 0 )
			for k, ply in pairs( player.GetAll() ) do
				ply:ChatPrint( "DakTek War Mode Disabled" )
			end
		end
		if text == "!DakTekBuildMode 1" then
			RunConsoleCommand( "DakTekDamagePermissionBuildMode", 1 )
			for k, ply in pairs( player.GetAll() ) do
				ply:ChatPrint( "DakTek Build Mode Enabled" )
			end
		end
		if text == "!DakTekBuildMode 0" then
			RunConsoleCommand( "DakTekDamagePermissionBuildMode", 0 )
			for k, ply in pairs( player.GetAll() ) do
				ply:ChatPrint( "DakTek Build Mode Disabled" )
			end
		end
	end
end )