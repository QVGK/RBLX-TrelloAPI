-- // Services \\ --
local HttpService = game:GetService('HttpService')

-- // Main Code \\ --
return function(Key, Token)
	local TrelloAPI = {}
	
	--[=[
		Gets all the cards in a Trello list

		@param ListID string -- The ID of the list
		@return table -- A table containing all the cards in the list
	]=]
	function TrelloAPI:GetCardsInList(ListID: string)
		local r
		
		if not ListID then
			warn('GetCardsInList failed. Missing arguments.')
			return false
		end
		
		local s, e = pcall(function()
			local tempr = HttpService:GetAsync(
				'https://api.trello.com/1/lists/'..ListID..'/cards?key='..Key..'&token='..Token
			)
			
			r = HttpService:JSONDecode(tempr)
		end)
		
		if not s then
			warn('GetCardsInList failed.')
			warn(e)
			return false 
		else
			warn('GetCardsInList successful.')
			return r
		end
	end
	
	--[=[
		Gets a card in a Trello list by its name

		@param ListID string -- The ID of the list
		@param CardName string -- The name of the card
		@return table -- A table containing the card data
	]=]
	function TrelloAPI:GetCardByName(ListID: string, CardName: string)
		local cards
		
		if not ListID or not CardName then
			warn('GetCardByName failed. Missing arguments.')
			return false
		end
		
		local s, e = pcall(function()
			local tempr = HttpService:GetAsync('https://api.trello.com/1/lists/'..ListID..'/cards?key='..Key..'&token='..Token)
			cards = HttpService:JSONDecode(tempr)
		end)
		
		if not s then
			warn('GetCardByName failed.')
			warn(e)
			return false 
		end

		for _, Object in pairs(cards) do
			if CardName == Object.name then
				warn('GetCardByName successful.')
				return Object
			end
		end
	end
	
	--[=[
		Creates a card in a Trello list

		@param Name string -- The name of the card
		@param ListID string -- The ID of the list
		@param ExtraData table -- Extra data to send to the API
		@return table -- A table containing the card data
	]=]
	function TrelloAPI:CreateCard(Name: string, ListID: string, ExtraData)
		local r
		
		if not Name or not ListID then
			warn('CreateCard failed. Missing arguments.')
			return false
		end
		
		if not ExtraData then
			ExtraData = {}
		end
		
		local SendData = {
			['Description'] = ExtraData.Description or '',
			['Labels'] = ExtraData.Labels or {}
		}
		
		local s, e = pcall(function()
			local tempr = HttpService:PostAsync(
				'https://api.trello.com/1/cards?key='..Key..'&token='..Token,
				HttpService:JSONEncode({
					name = Name,
					idList = ListID,
					desc = SendData.Description,
					idLabels = SendData.Labels
				})
			)
			
			r = HttpService:JSONDecode(tempr)
		end)
		
		if not s then
			warn('CreateCard failed.')
			warn(e)
			return false 
		else
			warn('CreateCard successful.')
			return r
		end
	end
	
	--[=[
		Deletes a card in a Trello list

		@param CardID string -- The ID of the card
		@return boolean -- Whether the card was deleted or not
	]=]
	function TrelloAPI:DeleteCard(CardID: string)
		if not CardID then
			warn('DeleteCard failed. Missing arguments.')
			return false
		end
		
		local s, e = pcall(function()
			HttpService:RequestAsync({
				Url = 'https://api.trello.com/1/cards/'..CardID..'?key='..Key..'&token='..Token,
				Method = 'DELETE'
			})
		end)
		
		if not s then
			warn('DeleteCard failed.')
			warn(e)
			return false 
		else
			warn('DeleteCard successful.')
			return true
		end
	end
	
	return TrelloAPI
end
