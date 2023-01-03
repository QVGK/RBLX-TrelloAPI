-- // Services \\ --
local HttpService = game:GetService('HttpService')

-- // Main Code \\ --
return function(Key, Token)
	local TrelloAPI = {}
	
	--[=[
		Gets a list's ID by its name

		@param BoardID string -- The ID of the board
		@param ListName string -- The name of the list
		@return string -- The ID of the list
	]=]
	function TrelloAPI:GetListID(BoardID: string, ListName: string)
		local lists
		
		if not BoardID or not ListName then
			warn('GetListID failed. Missing arguments.')
			return false
		end
		
		local s, e = pcall(function()
			local tempr = HttpService:GetAsync('https://api.trello.com/1/boards/'..BoardID..'/lists?key='..Key..'&token='..Token)
			lists = HttpService:JSONDecode(tempr)
		end)
		
		if not s then
			warn('GetListID failed.')
			warn(e)
			return false 
		end
		
		for _, Object in pairs(lists) do
			if ListName == Object.name then
				warn('GetListID successful.')
				return Object.id
			end
		end
		
	end

	return TrelloAPI
end
