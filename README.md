<div align=center>

# QVGK's TrelloAPI
[Documentation](https://docs.qvgk.org/trelloapi/) | [DevForum](https://devforum.roblox.com/t/qvgks-trelloapi/2090796) | [Trello](https://trello.com)

---

</div>

### What is QVGK's TrelloAPI?
QVGK's TrelloAPI is an API wrapper for [Trello's REST API](https://developer.atlassian.com/cloud/trello/rest/). This module simplifies the process of interacting with Trello's API, by turning messy HTTP Requests into easy-to-use functions.

### What is Trello?
Trello is a web application used for teams to track progress or issues with their own applications. For example, I use it to track what my team or I are going to add to my Roblox games, and see what my team has already added.

Some Roblox developers use Trello with their game to track data, or log data that failed to save. Even some application centers on Roblox use Trello to store responses.
Now, Trello is not an alternative for a database. You could use it as one, but it isn't designed to be one.

### Getting Started

![Enable HTTP Requests](https://img.shields.io/static/v1?label=%E2%9A%A0&message=Enable%20HTTP%20Requests&color=orange&style=for-the-badge)

Now, I've tried to make the process of using this module as easy as possible, especially for beginners developers. I apologize if you think this is difficult, or the code is clunky. I'm thinking of re-writing the entire module.

Before we continue, we need to get our Trello API Info. First, we'll get our Trello Personal Key. You can get it by clicking [here](https://trello.com/app-key). Scroll down a bit and you should see it. An example is shown below.

![image|587x139, 75%](https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/7/d/5/7d512eb7cc94916bf924630be725b351b7818775.png)

Your token should also be right under the Personal Key section. Click on the red text shown below and you'll be redirected to get your Trello key.

![image|602x177, 75%](https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/b/1/8/b185511c4bc81539c5a8a98b004445f83b1daee4.png)

### Using the Module
Now that you've got both the information you need, we can start using the module. Below, I've shown an example on how we can use the TrelloAPI.

```
local TrelloModule = require(Path.To.Module) -- requiring the module

local TrelloKey = 'ExampleKey' -- our Trello key variable
local TrelloToken = 'ExampleToken' -- our Trello token variable
local DebugEnabled = true

local BoardID = 'ExampleBoardID' -- our Trello BoardID

local Trello = TrelloModule.new(TrelloKey, TrelloToken, DebugEnabled) -- us creating a new Trello object, and enabling Debugging.
local TrelloLists = Trello.Lists -- ListsAPI
local TrelloCards = Trello.Cards -- CardsAPI
local TrelloBoards = Trello.Boards -- BoardsAPI

local MyBoard = TrelloBoards:GetBoard(BoardID) -- getting the board's info
local MyList = TrelloLists:GetListID(BoardID, 'ExampleList') -- getting an existing list
local NewCard = TrelloCards:CreateCard('Test Card', MyList) -- creating a new card

print(MyBoard.name)
```

Now, I'm not going to go through everything here. You can visit the [documentation](https://docs.qvgk.org/trelloapi) for a thorough guide on how to use everything in this module.

### Support & Contributions
You can request support or contribute to this project by commenting on the [DevForum](https://devforum.roblox.com/t/qvgks-trelloapi/2090796) thread, or by creating a pull request here.

### Change Logs
***Version 1.0.0 (WIP):***
- Rewrite & Optimize Code
- Enable Debugging Option (Logs All Functions)
- Rewrite Documentation

***Version 0.14 (LATEST):***
- Change to Rojo
- Rewrited DevForum Post

***Version 0.13:***
- BoardsAPI Introduced
- `:GetBoard()` Function Introduced
- GitHub Repository Created
