# QVGK's TrelloAPI
**Version 0.13**

[Documentation](https://docs.qvgk.org/trelloapi/) | [Model](https://www.roblox.com/library/11958316793/TrelloAPI) | [DevForum](https://devforum.roblox.com/t/qvgks-trelloapi/2090796)

---

QVGK's TrelloAPI is a module for Roblox that allows developers to use Trello's API more simpler. This module handles all API requests for the developer, and creates them into easy-to-use functions.

I've tried to make it so it's super simple to get started with this module. Before you continue, you'll need to get your Trello key and token. To do this, you need to go to the [Trello App Key](https://trello.com/app-key) page. Scroll down a bit and you should see your **Personal Key**.

![image|587x139, 75%](https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/7/d/5/7d512eb7cc94916bf924630be725b351b7818775.png)

Your token should also be right under the Personal Key section. Click on the red text shown below and you'll be redirected to get your Trello key.

![image|602x177, 75%](https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/b/1/8/b185511c4bc81539c5a8a98b004445f83b1daee4.png)

Now that you've got both the information you need, I've decided to show you an example.

```
local TrelloModule = require(Path.To.Module) -- requiring the module

local TrelloKey = 'ExampleKey' -- our Trello key variable
local TrelloToken = 'ExampleToken' -- our Trello token variable
local BoardID = 'ExampleBoardID' -- our Trello BoardID

local Trello = TrelloModule.new(TrelloKey, TrelloToken) -- us creating a new Trello object
local TrelloLists = Trello.Lists -- ListsAPI
local TrelloCards = Trello.Cards -- CardsAPI
local TrelloBoards = Trello.Boards -- BoardsAPI

local MyBoard = TrelloBoards:GetBoard(BoardID) -- getting the board's info
local MyList = TrelloLists:GetListID(BoardID, 'ExampleList') -- getting an existing list
local NewCard = TrelloCards:CreateCard('Test Card', MyList) -- creating a new card

print(MyBoard.name)
```

You can view the [full documentation](https://docs.qvgk.org/trelloapi) for a thorough guide on how to use this module.

### Support & Contributions
You can request support or contribute to this project by commenting on the [DevForum](https://devforum.roblox.com/t/qvgks-trelloapi/2090796) thread.

#### Thank You!
