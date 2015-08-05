-------------------------------------------------------
-- Made By: Logan
-------------------------------------------------------

local CATEGORY_NAME = "MerrU ULX"

-------------------------------------------------------
-- Arrest Commands
-------------------------------------------------------

function ulx.arrest( calling_ply, target_ply )
	local name = target_ply:GetName()
	if target_ply:isArrested() == true then
		ULib.tsayError( calling_ply, "That player is already arrested!", true )
	else
		RunConsoleCommand( "rp_arrest", name )
		ulx.fancyLogAdmin( calling_ply, false, "#A force-arrested #T", target_ply )
	end
end
local arrest = ulx.command( CATEGORY_NAME, "ulx arrest", ulx.arrest, "!arrest", true )
arrest:addParam{ type=ULib.cmds.PlayerArg }
arrest:defaultAccess( ULib.ACCESS_ADMIN )
arrest:help( "Arrests a player." )

function ulx.unarrest( calling_ply, target_ply )
	local name = target_ply:GetName()
	if target_ply:isArrested() == true then
	RunConsoleCommand( "rp_unarrest", name )
	ulx.fancyLogAdmin( calling_ply, false, "#A force-unarrested #T", target_ply )
	else
		ULib.tsayError( calling_ply, "That player is not arrested!", true )
	end
end
local unarrest = ulx.command( CATEGORY_NAME, "ulx unarrest", ulx.unarrest, "!unarrest", true )
unarrest:addParam{ type=ULib.cmds.PlayerArg }
unarrest:defaultAccess( ULib.ACCESS_SUPERADMIN )
unarrest:help( "Un-Arrests a player." )

-------------------------------------------------------
-- TellAll Commands
-------------------------------------------------------

function ulx.tellall( calling_ply, message )
	RunConsoleCommand( "rp_tellall", message )
end
local tellall = ulx.command( CATEGORY_NAME, "ulx tellall", ulx.tellall, "@@rp", true )
tellall:addParam{ type=ULib.cmds.StringArg, hint="Message", ULib.cmds.takeRestOfLine }
tellall:defaultAccess( ULib.ACCESS_ADMIN )
tellall:help( "Sends a message to ALL players online." )

function ulx.tell( calling_ply, target_ply, message )
	local name = target_ply:GetName()
	RunConsoleCommand( "rp_tell", name, message )
end
local tell = ulx.command( CATEGORY_NAME, "ulx tell", ulx.tell, "!rptell", true )
tell:addParam{ type=ULib.cmds.PlayerArg }
tell:addParam{ type=ULib.cmds.StringArg, hint="Message", ULib.cmds.takeRestOfLine }
tell:defaultAccess( ULib.ACCESS_SUPERADMIN )
tell:help( "Sends a message to a player." )

-------------------------------------------------------
-- End Hit/End Hits
-------------------------------------------------------

function ulx.rpEndHit( calling_ply, target_ply )
	local callname = calling_ply:GetName()
	if target_ply:hasHit() then
		target_ply:abortHit( "The hit was aborted by a Admin " )
		ulx.fancyLogAdmin( calling_ply, "#A ended hit for #T", target_ply )
	else
		ULib.tsayError( calling_ply, "That player does not have a hit!" )
	end
end
local rpEndHit = ulx.command( CATEGORY_NAME, "ulx rpendhit", ulx.rpEndHit, "!endhit" )
rpEndHit:addParam{ type=ULib.cmds.PlayerArg }
rpEndHit:defaultAccess( ULib.ACCESS_SUPERADMIN )
rpEndHit:help( "End the hit of the target(s)." )

-------------------------------------------------------
-- RPNAME
-------------------------------------------------------

function ulx.rpname( calling_ply, target_ply, newname )
	local target = target_ply
	local name = tostring(newname)
	------------
	local oldname = target:Nick()
	oldname = tostring(oldname)
	------------
	DarkRP.storeRPName(target, name)
	target:setDarkRPVar("rpname", name)
	target:PrintMessage(2, DarkRP.getPhrase("x_set_your_name", "ULX", name))

	ulx.fancyLogAdmin( calling_ply, "#A set the name of #T to " .. name .. ".", target_ply )
end
local rpName = ulx.command( CATEGORY_NAME, "ulx rpname", ulx.rpname, "!rpname" )
rpName:addParam{ type=ULib.cmds.PlayerArg }
rpName:addParam{ type=ULib.cmds.StringArg, hint="John Doe", ULib.cmds.takeRestOfLine }
rpName:defaultAccess( ULib.ACCESS_SUPERADMIN )
rpName:help( "Set a persons RP name." )
