-- // Services \\ --
local HttpService = game:GetService('HttpService')

-- // Main Code \\ --
return function(Key, Token)
	local TrelloAPI = {}
	
	function TrelloAPI:GetBoard(BoardID: string)
		local board
		
		if not BoardID then
			warn('GetBoard failed. Missing arguments.')
			return false
		end
		
		local s, e = pcall(function()
			local tempr = HttpService:GetAsync('https://api.trello.com/1/boards/'..BoardID..'?key='..Key..'&token='..Token)
			board = HttpService:JSONDecode(tempr)
		end)
		
		if not s then
			warn('GetBoard failed.')
			warn(e)
			return false 
		else
			warn('GetBoard successful.')
			return board
		end
		
	end

	return TrelloAPI
end
