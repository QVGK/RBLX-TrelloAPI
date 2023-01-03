-- Services --
local HttpService = game:GetService('HttpService')
-- End of Services --

-- Return --
return function(Key, Token, DebugEnabled)
	local TrelloAPI = {}
	local Extension = '?key='..Key..'&token='..Token
	
	-- Get all the cards in a Trello list.
	function TrelloAPI:GetCardsInList(ListID: string)

		local Response
		
		if not ListID then
			warn('GetCardsInList failed. Missing arguments.')
			return false
		end
		
		local TrelloSuccess, TrelloError = pcall(function()
			local TempResponse = HttpService:GetAsync('https://api.trello.com/1/lists/'..ListID..'/cards'..Extension)
			Response = HttpService:JSONDecode(TempResponse)
		end)
		
		if not TrelloSuccess then
			if DebugEnabled then
				warn('GetCardsInList failed.')
				warn('Error: '..TrelloError)
			end
			return false
		else
			if DebugEnabled then
				warn('GetCardsInList successful.')
			end
			return Response
		end

	end
	
	-- Get a card by it's name in a Trello list.
	function TrelloAPI:GetCardByName(ListID: string, CardName: string)

		local TrelloCards
		
		if not ListID or not CardName then
			if DebugEnabled then
				warn('GetCardByName failed. Missing arguments.')
			end
			return false
		end
		
		local TrelloSuccess, TrelloError = pcall(function()
			local TempResponse = HttpService:GetAsync('https://api.trello.com/1/lists/'..ListID..'/cards'..Extension)
			TrelloCards = HttpService:JSONDecode(TempResponse)
		end)
		
		if not TrelloSuccess then
			if DebugEnabled then
				warn('GetCardByName failed.')
				warn('Error: '..TrelloError)
			end
			return false 
		end

		for _, CardObject in pairs(TrelloCards) do
			if CardName == CardObject.name then
				if DebugEnabled then
					warn('GetCardByName successful.')
				end
				return CardObject
			end
		end

	end
	
	-- Creates a card in a Trello list.
	function TrelloAPI:CreateCard(Name: string, ListID: string, ExtraData)

		local TrelloCard
		
		if not Name or not ListID then
			if DebugEnabled then
				warn('CreateCard failed. Missing arguments.')
			end
			return false
		end
		
		if not ExtraData then
			ExtraData = {}
		end
		
		local DataToSend = {
			['Description'] = ExtraData.Description or '',
			['Labels'] = ExtraData.Labels or {}
		}
		
		local TrelloSuccess, TrelloError = pcall(function()
			local TempResponse = HttpService:PostAsync(
				'https://api.trello.com/1/cards'..Extension,
				HttpService:JSONEncode({
					name = Name,
					idList = ListID,
					desc = DataToSend.Description,
					idLabels = DataToSend.Labels
				})
			)
			
			TrelloCard = HttpService:JSONDecode(TempResponse)
		end)
		
		if not TrelloSuccess then
			if DebugEnabled then
				warn('CreateCard failed.')
				warn('Error: '..TrelloError)
			end
			return false 
		else
			if DebugEnabled then
				warn('CreateCard successful.')
			end
			return TrelloCard
		end

	end
	
	-- Deletes a card in a Trello list.
	function TrelloAPI:DeleteCard(CardID: string)

		if not CardID then
			if DebugEnabled then
				warn('DeleteCard failed. Missing arguments.')
			end
			return false
		end
		
		local TrelloSuccess, TrelloError = pcall(function()
			HttpService:RequestAsync({
				Url = 'https://api.trello.com/1/cards/'..CardID..Extension,
				Method = 'DELETE'
			})
		end)
		
		if not TrelloSuccess then
			if DebugEnabled then
				warn('DeleteCard failed.')
				warn('Error: '..TrelloError)
			end
			return false 
		else
			if DebugEnabled then
				warn('DeleteCard successful.')
			end
			return true
		end
		
	end
	
	return TrelloAPI
end
-- End of Return --
