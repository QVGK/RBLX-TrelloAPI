--[[

			
		░██████╗░██╗░░░██╗░██████╗░██╗░░██╗██╗░██████╗  ████████╗██████╗░███████╗██╗░░░░░██╗░░░░░░█████╗░
		██╔═══██╗██║░░░██║██╔════╝░██║░██╔╝╚█║██╔════╝  ╚══██╔══╝██╔══██╗██╔════╝██║░░░░░██║░░░░░██╔══██╗
		██║██╗██║╚██╗░██╔╝██║░░██╗░█████═╝░░╚╝╚█████╗░  ░░░██║░░░██████╔╝█████╗░░██║░░░░░██║░░░░░██║░░██║
		╚██████╔╝░╚████╔╝░██║░░╚██╗██╔═██╗░░░░░╚═══██╗  ░░░██║░░░██╔══██╗██╔══╝░░██║░░░░░██║░░░░░██║░░██║
		░╚═██╔═╝░░░╚██╔╝░░╚██████╔╝██║░╚██╗░░░██████╔╝  ░░░██║░░░██║░░██║███████╗███████╗███████╗╚█████╔╝
		░░░╚═╝░░░░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝░░░╚═════╝░  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝░╚════╝░

		░█████╗░██████╗░██╗
		██╔══██╗██╔══██╗██║
		███████║██████╔╝██║
		██╔══██║██╔═══╝░██║
		██║░░██║██║░░░░░██║
		╚═╝░░╚═╝╚═╝░░░░░╚═╝

		QVGK’s TrelloAPI is an API wrapper for Trello’s REST API, based
		off of Aiden_12114’s Trello API (2020). This module simplifies the process of
		interacting with Trello’s API, by turning messy HTTP Requests into easy-to-use functions.

		It is advised that you read the documentation, or have some basic knowledge about
		this module before you use, or edit it. The documentation and DevForum post can be found below.
--]]
		-- Configuration --
		local TestBoard = 'w0j1CQz2' -- The Trello board used to test if the Key and Token are valid.
		-- End of Configuration --
--[[
		DevForum Post: https://devforum.roblox.com/t/2090796
		Documentation: https://docs.qvgk.org/trelloapi

		Made with ❤️ by QVGK.
		Licensed under the MIT License.
--]]

-- Services --
local HttpService = game:GetService('HttpService')
-- End of Services --

-- Variables --
local TrelloAPI = {}
-- End of Variables --

-- Initializes the TrelloAPI module.
function TrelloAPI.new(Key: string, Token: string, DebugEnabled: boolean)
	
	if DebugEnabled ~= true then
		DebugEnabled = false
	end

	local TrelloSuccess, TrelloError = pcall(function()
		HttpService:GetAsync('https://api.trello.com/1/boards/'..TestBoard..'?key='..Key..'&token='..Token)
	end)

	if not TrelloSuccess then
		warn('TrelloAPI failed to intialize. Please check your Key and Token.')
		error('Error: '..TrelloError)
		return false
	else
		if DebugEnabled then
			warn('TrelloAPI initialized successfully.')
		end
	end
	
	return {
		Cards = require(script.CardAPI)(Key, Token, DebugEnabled),
		Lists = require(script.ListAPI)(Key, Token, DebugEnabled),
		Boards = require(script.BoardAPI)(Key, Token, DebugEnabled)
	}
	
end

-- Return --
return TrelloAPI
-- End of Return --
