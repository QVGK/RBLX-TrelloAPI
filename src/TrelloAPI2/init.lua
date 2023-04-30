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

		DevForum Post: https://devforum.roblox.com/t/2090796
		Documentation: https://docs.qvgk.org/trelloapi

		Made with ❤️ by QVGK.
		Licensed under the MIT License.
--]]
		
-- CONFIGURATION --
local testBoard = 'w0j1CQz2' -- The Trello board used to test if the Key and Token are valid.

-- !!!!!!!!! DO NOT EDIT BELOW THESE LINES UNLESS YOU UNDERSTAND WHAT YOU'RE DOING !!!!!!!!!! --
-- !!!!!!!!! DO NOT EDIT BELOW THESE LINES UNLESS YOU UNDERSTAND WHAT YOU'RE DOING !!!!!!!!!! --
-- !!!!!!!!! DO NOT EDIT BELOW THESE LINES UNLESS YOU UNDERSTAND WHAT YOU'RE DOING !!!!!!!!!! --
-- !!!!!!!!! DO NOT EDIT BELOW THESE LINES UNLESS YOU UNDERSTAND WHAT YOU'RE DOING !!!!!!!!!! --
-- !!!!!!!!! DO NOT EDIT BELOW THESE LINES UNLESS YOU UNDERSTAND WHAT YOU'RE DOING !!!!!!!!!! --
-- !!!!!!!!! DO NOT EDIT BELOW THESE LINES UNLESS YOU UNDERSTAND WHAT YOU'RE DOING !!!!!!!!!! --
-- !!!!!!!!! DO NOT EDIT BELOW THESE LINES UNLESS YOU UNDERSTAND WHAT YOU'RE DOING !!!!!!!!!! --

-- GAME SERVICES --
local HttpService = game:GetService('HttpService')

-- VARIABLES --
local TrelloAPI = {}
TrelloAPI.__index = TrelloAPI

-- Create Trello Object
function TrelloAPI.new(key: string, token: string, debugEnabled: boolean)
	local newTrelloAPI = {}
	setmetatable(newTrelloAPI, TrelloAPI)

	newTrelloAPI.key = key
	newTrelloAPI.token = token
	newTrelloAPI.debugEnabled = debugEnabled

	return newTrelloAPI and {
		BoardsAPI = require(script.BoardsAPI)(key, token, debugEnabled)
	}
end

-- Verify Trello Object
function TrelloAPI:Verify()
	local verifySuccess, verifyError = pcall(function()
		HttpService:GetAsync('https://api.trello.com/1/boards/'..testBoard..'?key='..self.key..'&token='..self.token)
	end)

	if not verifySuccess then
		warn('TrelloAPI2 is not working as intended. Please check the key and token.')
		error('Error: '..verifyError)
		return false
	else
		if self.debugEnabled then
			warn('TrelloAPI2 is working as intended.')
		end
		return true
	end
end

-- Return TrelloAPI
return TrelloAPI
