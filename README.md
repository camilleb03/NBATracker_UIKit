<h1 align="center"> NBATracker </h1>

> Personal iOS project to display NBA infos on current teams, players and season with scoreboards of the day using data.nba.net and cdn.nba.net APIs.

## Table of Contents
1. [General Info](#general-info)
2. [Project Screenshots](#project-screenshots)
3. [Technologies](#technologies)
4. [Features](#features)
5. [TODOs](#todo-list)

<hr>

## General Info

* iOS Deployment Target :

**PROJECT STATUS: IN DEVELOPMENT**

<hr>

## Project Screenshots
<img src="https://user-images.githubusercontent.com/43909779/117401180-14303180-aed2-11eb-8b01-dbb12a718c23.png" width="25%" height="25%">
<hr>

## Technologies
A list of technologies used within the project:
* Xcode 12.4
* Swift 5
* data.nba.net API
* cdn.nba.net API

<hr>

## Features

A few of the things you can do with NBATracker:

* View live scoreboards of the current games

<hr>

## TODO list

List of features coming :

- Live Scoreboards
  - Add info to scoreboard (current period, clock, game status) &#9745;
  - Refresh swipe (drag down view) refreshes scores &#9745;
  - Improve UI of scoreboard &#9745;
  - Add team logos (with caching) &#9745;
  - Select row (game) leads to detailed view of the game
- DetailScoreboard View
  - Pass data from LiveScoreboards View to DetailScoreboard View
  - Fetch more interesting data i.e.
    - Points per quarter
    - Stats for each team (field goals, freethrows, steals, blocks, rebounds, assists, fouls, turnovers, fouls, etc.)
    - Players with most points, most rebounds, most assists
    - BoxScore of the game
- Playoff Bracket
  - Retrieve info from API
  - Make UI
- Standings
  - Retrieve info from API
  - Make UI
