<!---
  Created with IntelliJ IDEA.
  User: jason
  Date: 12/18/13
  Time: 10:34 PM
  To change this template use File | Settings | File Templates.
--->

<cfparam name="URL.leagueID" default="" />
<cfparam name="URL.season" default="2013" />
<cfparam name="URL.week" default="1" />

<cfset leagueID = listFirst(URL.leagueID, "_") />
<cfset teamList = listLast(urlDecode(URL.leagueID), "_") />

<cfoutput>
<form action="#cgi.SCRIPT_NAME#" method="get">
    <label for="league">League: </label>
    <select name="leagueID" id="league">
        <option value="860205_1,2,3,4,7,10,13,15,16,17,18,19" <cfif leagueID EQ "860205">selected</cfif>>Silver Waffle</option>
        <option value="183196_1,3,6,8,11,12,16,19,20,21" <cfif leagueID EQ "183196">selected</cfif>>9-Men and a Romo-Sexual</option>
    </select>
    <br />
    <label for="season">Season: </label>
    <select name="season" id="season">
        <cfloop from="#year(now())#" to="#year(now())-3#" step="-1" index="yearIndex">
            <option value="#yearIndex#" <cfif URL.season EQ yearIndex>selected</cfif>>#yearIndex#</option>
        </cfloop>
    </select>
    <br />
    <label for="week">Week: </label>
    <select name="week" id="week">
        <cfloop from="1" to="17" step="1" index="weekIndex">
                <option value="#weekIndex#" <cfif URL.week EQ weekIndex>selected</cfif>>#weekIndex#</option>
        </cfloop>
    </select>
    <br /><br />
    <input type="submit" name="btnSubmit" value="Get this awesome shit" />
</form>
</cfoutput>


<cfif isNumeric(leagueID) AND isNumeric(URL.season) AND URL.season LTE year(now()) AND isNumeric(URL.week) AND URL.week LTE 17>

    <cfset league = application.gateway.getLeague(leagueId=leagueID, season=url.season, week=url.week, teamList=teamList) />

    <cfoutput>
    <cfset passingYardsTeam = league.getMostPassingYards() />
    <cfset rushingYardsTeam = league.getMostRushingYards() />
    <cfset receivingYardsTeam = league.getMostReceivingYards() />


    <h3>Most Passing Yards for week #league.getWeek()#: #passingYardsTeam.getTeamName()# -- #passingYardsTeam.getPassingYards()#</h3>
    <h3>Most Rushing Yards for week #league.getWeek()#: #rushingYardsTeam.getTeamName()# -- #rushingYardsTeam.getRushingYards()#</h3>
    <h3>Most Receiving Yards for week #league.getWeek()#: #receivingYardsTeam.getTeamName()# -- #receivingYardsTeam.getReceivingYards()#</h3>

    <cfloop array="#league.getTeams()#" index="teamIndex">
        <h1>#teamIndex.getTeamName()#</h1>
        <cfset playerIndex = "" />
        <h2>Roster</h2>
        <cfloop array="#teamIndex.getRoster()#" index="playerIndex">
            #playerIndex.getName()# --- #playerIndex.getPosition()# --- #playerIndex.getPoints()#<br />
        </cfloop>
        <br /><br />
        <h2>Bench</h2>
        <cfloop array="#teamIndex.getBench()#" index="playerIndex">
            #playerIndex.getName()# --- #playerIndex.getPosition()# --- #playerIndex.getPoints()#<br />
        </cfloop>
        <br /><br />
        <h3>Passing Yards: #teamIndex.getPassingYards()#</h3>
        <h3>Rushing Yards: #teamIndex.getRushingYards()#</h3>
        <h3>Receiving Yards: #teamIndex.getReceivingYards()#</h3>
        <h3>Roster Points: #teamIndex.getRosterPoints()#</h3>
        <h3>Bench Points: #teamIndex.getBenchPoints()#</h3>
        <br /><br />

    </cfloop>
    </cfoutput>
</cfif>
