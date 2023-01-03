-- // Configuration \\ --
local TestBoard = 'w0j1CQz2'

-- // Services \\ --
local HttpService = game:GetService('HttpService')

-- // Main Code \\ --
local TrelloAPI = {}

function TrelloAPI.new(Key, Token)
	
	local s, e = pcall(function()
		HttpService:GetAsync('https://api.trello.com/1/boards/'..TestBoard..'?key='..Key..'&token='..Token)
	end)
	
	if not s then
		error('The provided Key and Token are invalid. Please try initiating again with valid information.')
	else
		warn('TrelloAPI successfully initiated.')
	end
	
	return {
		Cards = require(script.CardAPI)(Key, Token),
		Lists = require(script.ListAPI)(Key, Token),
		Boards = require(script.BoardAPI)(Key, Token)
	}
	
end

return TrelloAPI
