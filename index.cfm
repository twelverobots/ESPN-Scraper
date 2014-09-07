<!DOCTYPE html>
<html>
  <head>
    <title>ESPN Fantasy Football Scraper</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/custom.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
<!---
  Created with IntelliJ IDEA.
  User: jason
  Date: 12/18/13
  Time: 10:34 PM
  To change this template use File | Settings | File Templates.
--->
<cfsilent>
	<cfimport taglib="tags" prefix="v">
    <cfparam name="URL.leagueID" default="" />
    <cfparam name="URL.season" default="#year(now())#" />
    <cfparam name="URL.week" default="1" />
    <cfparam name="closeMatchDiff" default="1" >
    <cfparam name="losingStreak" default="3" >

    <cfset leagueID = listFirst(URL.leagueID, "_") />
    
</cfsilent>

<cfoutput>
<nav class="navbar navbar-default" role="navigation">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##bs-example-navbar-collapse-1">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="##">ESPN Fantasy Football Scraper</a>
  </div>

  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    <form class="navbar-form navbar-left" role="form" action="#cgi.SCRIPT_NAME#" method="get" >
      <div class="form-group">
        <label for="league">League: </label>

        <select name="leagueID" id="league" class="form-control">
            <option value="860205" <cfif leagueID EQ "860205">selected</cfif>>Silver Waffle</option>
            <option value="183196" <cfif leagueID EQ "183196">selected</cfif>>9 Men and a Romo-Sexual</option>
        </select>
      </div>
      <div class="form-group">
        <label for="season">Season: </label>
        <select name="season" id="season" class="form-control">
            <cfloop from="#year(now())#" to="#year(now())-1#" step="-1" index="yearIndex">
                <option value="#yearIndex#" <cfif URL.season EQ yearIndex>selected</cfif>>#yearIndex#</option>
            </cfloop>
        </select>
    </div>
    <div class="form-group">
        <label for="week">Week: </label>
        <select name="week" id="week" class="form-control">
            <cfloop from="1" to="17" step="1" index="weekIndex">
                    <option value="#weekIndex#" <cfif URL.week EQ weekIndex>selected</cfif>>#weekIndex#</option>
            </cfloop>
        </select>
    </div>
      <button type="submit" class="btn btn-primary btn-sm">Get The Awesome</button>
      <a href="index.cfm?reload=1&leagueId=#url.leagueId#&season=#url.season#&week=#url.week#" class="btn btn-primary" title="Refresh Data"><span class="glyphicon glyphicon-refresh"></span></a>
    </form>
  </div><!-- /.navbar-collapse -->
</nav>

</cfoutput>
<cfif structKeyExists( url, 'reload' )>
	<div class="alert alert-info" role="alert">
      <strong>Data Refreshed</strong> The data cache has been cleared.
    </div>
</cfif>

<cfif isNumeric(leagueID) AND isNumeric(URL.season) AND URL.season LTE year(now()) AND isNumeric(URL.week) AND URL.week LTE 17>

    <cfset league = application.gateway.getLeague(leagueId=leagueID, season=url.season, week=url.week, clearcache = structKeyExists( url, 'reload' ) ) />
    <cfset teams = duplicate( league.getTeams() ) />
    <cfoutput>
      
    <div class="container">
    	 <h3>Week #league.getWeek()#  - #league.getLeagueName()#</h3>
    	<div class="row">
		    <v:statPod title="Highest Score" method="getscore()" teams="#league.getByHighestScore()#" />
		    <v:statPod title="Lowest Score" method="getscore()" teams="#league.getByLowestScore()#" />
		    <v:statPod title="Most Bench Points" method="getBenchPoints()" teams="#league.getByMostBenchPoints()#" />
            <v:statPod title="Bench Points > Roster Points" method="getBenchOutscoredRoster()" teams="#league.getByMostBenchPointsVsRosterPoints()#" />
		    <v:statPod title="Most Passing Yards" method="getpassingYards()" teams="#league.getByMostPassingYards()#" />
		    <v:statPod title="Most Rushing Yards" method="getrushingYards()" teams="#league.getByMostRushingYards()#" />
		    <v:statPod title="Most Receiving Yards" method="getreceivingYards()" teams="#league.getByMostReceivingYards()#" />
		    <v:statPod title="Fewest Points Allowed by D/ST" method="getpointsAllowed()" teams="#league.getByFewestPointsAllowed()#" />
		    <v:statPod title="Most Points Allowed by D/ST" method="getpointsAllowed()" teams="#league.getByMostPointsAllowed()#" />
		    <v:statPod title="Most Sacks" method="getsacks()" teams="#league.getByMostSacks()#" />
		    <v:statPod title="Most Stuffs" method="getStuffs()" teams="#league.getByMostStuffs()#" />
		    <v:statPod title="Widest Margin of Victory" method="getmargin()" teams="#league.getByWidestMarginVictory()#" />
		    <v:statPod title="Widest Margin of Defeat" method="getmargin()" teams="#league.getByWidestMarginDefeat()#" />
		    <v:statPod title="Narrowest Margin of Victory" method="getmargin()" teams="#league.getByNarrowestMarginOfVictory()#" />
		    <v:statPod title="Narrowest Margin of Defeat" method="getmargin()" teams="#league.getByNarrowestMarginOfDefeat()#" />
		    <v:statPod title="Most Fumbles" method="getfumbles()" teams="#league.getByMostFumbles()#" />
		    <v:statPod title="Most Interceptions" method="getinterceptions()" teams="#league.getByMostInterceptions()#" />
		    <v:statPod title="Win/Loss by less than 1 point" method="getmargin()" teams="#league.getByCloseMatch()#" />
	    	<v:statPod title="Most Points By Losing Team" method="getscore()" teams="#league.getByHighScoringLosers()#" />
		    <v:statPod title="Bench QB &gt; Starting QB" method="getBestBenchQBPoints()" teams="#league.getByBadQB()#" />
	    	<v:statPod title="Kicker &gt; Starting QB" method="getactiveKicker().getPoints()" teams="#league.getByRinger()#" />
	    	<v:statPod title="3 or more game losing streak" method="getstreak()" teams="#league.getByLosingStreak()#" />
            <v:statPod title="Most Players P, Q, or D" method="getRisks()" teams="#league.getByMostRisks()#" />
            <v:statPod title="Worst Rushing Average" method="getRushingAverage()" teams="#league.getByWorstRushingAverage()#" />
            <v:statPod title="Worst Receiving Average" method="getReceivingAverage()" teams="#league.getByWorstReceivingAverage()#" />
            <v:statPod title="D/ST TDs > QB TD/s" method="getOffensiveDefense()" teams="#league.getByOffensiveDefense()#" />
	    </div>
    </div>
    <div class="container"> 
    <h3>Individual Team Data</h3>
    <div class="container">
       <cfset count = 0 />
            <cfloop array="#league.getTeams()#" index="teamIndex">
                <cfset count++ />
                <cfif count eq 1 OR count % 3 EQ 0>
                     <div class="row">
                </cfif>
                    <div class="team-pod col-md-3 <cfif count neq 1 or count % 3 eq 1>col-md-offset-1</cfif>">
                        <h4>#teamIndex.getTeamName()#</h4>
                        <h5>Record: #teamIndex.getRecord()# <cfif len(trim( teamIndex.getStreak() ) )> ( Current Streak:  #teamIndex.getStreak()# )</cfif></h5>
                        
                        <cfset playerIndex = "" />
                        
                        <table class="table table-striped table-hover table-condensed">
                            <caption>Active Roster</caption>
                            <thead>
                                <tr>
                                    <th>Player</th>
                                    <th>Team</th>
                                    <th>Pos.</th>
                                    <th class="text-right">Pts.</th>
                                </tr>
                            </thead>
                            <tbody>
                        <cfloop array="#teamIndex.getRoster()#" index="playerIndex">
                            <tr>
                                <td>#playerIndex.getName()#</td>
                                <td class="text-center">#playerIndex.getTeam()#</td>
                                <td class="text-center">#playerIndex.getPosition()#</td>
                                <td class="text-right">#numberFormat(playerIndex.getPoints(), '-999.0')#</td>
                            </tr>
                        </cfloop>
                            </tbody>
                        </table>
                        <table class="table table-striped table-hover table-condensed">
                            <caption>Bench</caption>
                            <thead>
                                <tr>
                                    <th>Player</th>
                                    <th>Pos.</th>
                                    <th>Pts.</th>
                                </tr>
                            </thead>
                            <tbody>
                        <cfloop array="#teamIndex.getBench()#" index="playerIndex">
                            <tr>
                                <td>#playerIndex.getname()#</td>
                                <td>#playerIndex.getTeam()#</td>
                                <td class="text-center">#playerIndex.getPosition()#</td>
                                <td class="text-right">#numberFormat(playerIndex.getPoints(), '-999.0')#</td>
                            </tr>
                        </cfloop>
                            </tbody>
                        </table>
                        <table class="table table-striped table-hover table-condensed">
                            <caption>Totals</caption>
                            <tr>
                                <th scope="row">Passing Yards</th>
                                <td>#teamIndex.getPassingYards()#</td>
                            </tr>
                            <tr>
                                <th scope="row">Rushing Yards</th>
                                <td>#teamIndex.getRushingYards()#</td>
                            </tr>
                            <tr>
                                <th scope="row">Receiving Yards</th>
                                <td>#teamIndex.getReceivingYards()#</td>
                            </tr>
                            <tr>
                                <th scope="row">Active Roster Pts.</th>
                                <td>#teamIndex.getRosterPoints()#</td>
                            </tr>
                            <tr>
                                <th scope="row">Bench Points</th>
                                <td>#teamIndex.getBenchPoints()#</td>
                            </tr>
                        </table>
                    </div>
                <cfif count % 3 EQ 0 OR count EQ arrayLen( league.getTeams())>
                     </div>
                </cfif>
            </cfloop>
        
    </div>
    </cfoutput>
    </div>
</cfif>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</body>
</html>