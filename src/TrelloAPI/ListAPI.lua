-- Services --
local HttpService = game:GetService('HttpService')
-- End of Services --

-- Return --
return function(Key, Token, DebugEnabled)
	local TrelloAPI = {}
	local Extension = '?key='..Key..'&token='..Token
	
	-- Gets a list's ID by it's name.
	function TrelloAPI:GetListID(BoardID: string, ListName: string)
		
		local TrelloLists
		
		if not BoardID or not ListName then
			if DebugEnabled then
				warn('GetListID failed. Missing arguments.')
			end
			return false
		end
		
		local TrelloSuccess, TrelloError = pcall(function()
			local TempResponse = HttpService:GetAsync('https://api.trello.com/1/boards/'..BoardID..'/lists'..Extension)
			TrelloLists = HttpService:JSONDecode(TempResponse)
		end)
		
		if not TrelloSuccess then
			if DebugEnabled then
				warn('GetListID failed.')
				warn('Error: '..TrelloError)
			end
			return false
		end
		
		for _, ListObject in pairs(TrelloLists) do
			if ListName == ListObject.name then
				if DebugEnabled then
					warn('GetListID successful.')
				end
				return ListObject.id
			end
		end
		
	end

	return TrelloAPI
end
-- End of Return --
