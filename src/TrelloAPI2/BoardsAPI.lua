-- GAME SERVICES --
local HttpService = game:GetService('HttpService')

return function(key, token, debugEnabled)
    ----------------------------------------------------------------------------------------------

	local TrelloAPI = {}
	local Extension = '?key='..key..'&token='..token
	
	-- Get Board By ID
	function TrelloAPI:PullBoardInfo(boardID: string)
		local boardInformation
		
		if not boardID then
			warn('PullBoardInfo failed. Missing arguments.')
			return false
		end
		
		local getSuccess, getError = pcall(function()
			local getResponse = HttpService:GetAsync('https://api.trello.com/1/boards/'..boardID..Extension)
			boardInformation = HttpService:JSONDecode(getResponse)
		end)
		
		if not getSuccess then
			if debugEnabled then
				warn('PullBoardInfo failed.')
				error('Error: '..getError)
			end
			return false
		else
			if debugEnabled then
				warn('PullBoardInfo successful.')
			end
			return boardInformation
		end
	end

    -- Pull Cards From Board
    function TrelloAPI:PullCardsFromBoard(boardID: string)
        local cardsInformation
		
		if not boardID then
			warn('PullCardsFromBoard failed. Missing arguments.')
			return false
		end
		
		local getSuccess, getError = pcall(function()
			local getResponse = HttpService:GetAsync('https://api.trello.com/1/boards/'..boardID..'/cards'..Extension)
			cardsInformation = HttpService:JSONDecode(getResponse)
		end)
		
		if not getSuccess then
			if debugEnabled then
				warn('PullCardsFromBoard failed.')
				error('Error: '..getError)
			end
			return false
		else
			if debugEnabled then
				warn('PullCardsFromBoard successful.')
			end
			return cardsInformation
		end
    end

    -- Pull Card From Board
    function TrelloAPI:PullCardFromBoard(boardID: string, cardName: string)
        local cardInformation
        local cardID
        local cards = TrelloAPI:PullCardsFromBoard(boardID)
            
        if not boardID then
            warn('PullCardFromBoard failed. Missing arguments.')
            return false
        end
        if not cardName then
            warn('PullCardFromBoard failed. Missing arguments.')
            return false
        end
        if not cards then
            warn('PullCardFromBoard failed. Ensure BoardID is correct.')
            return false
        end

        for _, v in pairs(cards) do
            if v.name == cardName then
                cardID = v.id
            end
        end
            
        local getSuccess, getError = pcall(function()
            local getResponse = HttpService:GetAsync('https://api.trello.com/1/boards/'..boardID..'/cards/'..cardID..Extension)
            cardInformation = HttpService:JSONDecode(getResponse)
        end)
            
        if not getSuccess then
            if debugEnabled then
                warn('PullCardFromBoard failed.')
                error('Error: '..getError)
            end
            return false
        else
            if debugEnabled then
                warn('PullCardFromBoard successful.')
            end
            return cardInformation
        end
    end

    ----------------------------------------------------------------------------------------------
	return TrelloAPI
end