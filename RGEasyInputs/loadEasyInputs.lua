-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015
-- =============================================================
-- 								License
-- =============================================================
--[[
	> SSK is free to use.
	> SSK is free to edit.
	> SSK is free to use in a free or commercial game.
	> SSK is free to use in a free or commercial non-game app.
	> SSK is free to use without crediting the author (credits are still appreciated).
	> SSK is free to use without crediting the project (credits are still appreciated).
	> SSK is NOT free to sell for anything.
	> SSK is NOT free to credit yourself with.
]]
-- =============================================================

if( not _G.ssk ) then
	print("ERROR! - SSK must be present and loaded before you use these modules.")
end

local easyInputs = {}
_G.ssk.easyInputs = easyInputs
easyInputs.joystick 		= require("RGeasyInputs.joystick")
easyInputs.cornerButtons 	= require("RGeasyInputs.cornerButtons")
easyInputs.oneTouch 		= require("RGeasyInputs.oneTouch")
easyInputs.twoTouch 		= require("RGeasyInputs.twoTouch")
easyInputs.oneStick 		= require("RGeasyInputs.oneStick")
easyInputs.twoStick 		= require("RGeasyInputs.twoStick")
easyInputs.oneStickOneTouch = require("RGeasyInputs.oneStickOneTouch")
--table.dump(easyInputs)
return easyInputs