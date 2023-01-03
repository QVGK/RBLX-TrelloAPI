-- Services --
local HttpService = game:GetService('HttpService')
-- End of Services --

-- Return --
return function(Key, Token, DebugEnabled)
	local TrelloAPI = {}
	local Extension = '?key='..Key..'&token='..Token
	
	-- Gets a board's information by it's ID.
	function TrelloAPI:GetBoard(BoardID: string)
		
		local BoardInfo
		
		if not BoardID then
			if not BoardID then
				warn('GetBoard failed. Missing arguments.')
			end
			return false
		end
		
		local TrelloSuccess, TrelloError = pcall(function()
			local TempResponse = HttpService:GetAsync('https://api.trello.com/1/boards/'..BoardID..Extension)
			BoardID = HttpService:JSONDecode(TempResponse)
		end)
		
		if not TrelloSuccess then
			if DebugEnabled then
				warn('GetBoard failed.')
				warn('Error: '..TrelloError)
			end
			return false
		else
			if DebugEnabled then
				warn('GetBoard successful.')
			end
			return BoardInfo
		end
		
	end

	return TrelloAPI
end
-- End of Return --