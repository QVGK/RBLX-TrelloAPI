-- // Configuration \\ --
local TestBoard = 'w0j1CQz2'

-- // Services \\ --
local HttpService = game:GetService('HttpService')

-- // Main Code \\ --
local TrelloAPI = {}

--[=[
    Initializes the Trello API

    @param Key string -- The Trello API Key
    @param Token string -- The Trello API Token
	@param DebugEnabled boolean -- Whether or not to print debug messages
    @return table -- A table containing all the API modules
]=]
function TrelloAPI.new(Key: string, Token: string, DebugEnabled: boolean)
	
	local s, e = pcall(function()
		HttpService:GetAsync('https://api.trello.com/1/boards/'..TestBoard..'?key='..Key..'&token='..Token)
	end)

	if DebugEnabled ~= true then
		DebugEnabled = false
	end

	if not s then
		warn('Failed to initialize TrelloAPI. Please check if the Key and Token are correct.')
		warn('Error: '..e)
		return false
	else
		if DebugEnabled == true then
			warn('TrelloAPI successfully initiated.')
		end
	end
	
	return {
		Cards = require(script.CardAPI)(Key, Token, DebugEnabled),
		Lists = require(script.ListAPI)(Key, Token, DebugEnabled),
		Boards = require(script.BoardAPI)(Key, Token, DebugEnabled)
	}
	
end

return TrelloAPI
