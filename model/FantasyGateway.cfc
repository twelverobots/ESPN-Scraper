/**
 * Created with IntelliJ IDEA.
 * User: jason
 * Date: 12/18/13
 * Time: 10:35 PM
 * To change this template use File | Settings | File Templates.
*/
component accessors="true" {
    property name="remoteService";

    public any function init() {

        return this;
    }

    public any function getTeams(leagueid, season) {
        doc = getRemoteService().getTeams(leagueid=arguments.leagueid, season=arguments.season);

        var links = doc.select(".games-teams-btn li a");
        var link ="";
        var league_values = "";
        for (link in links) {
            league_values = listAppend(league_values, rematch("[0-9]+", link.attr("href"))[2]);
        }

        return league_values;

    }

    public any function getLeague(leagueid, season, week) {

        var teamIndex = 1;
        var doc = "";
        var stuffDoc = "";
        var off = "";
        var def = "";
        var tables = "";
        var kicker = "";
        var tableIndex = "";
        var player = "";
        var teamName = "";
        var teamdata = {};

        var league = new model.League();

        league.setWeek(arguments.week);
        league.setLeagueID(arguments.leagueid);
        var teamList = getTeams(arguments.leagueid, arguments.season);
		var streak = getRemoteService().getStreak( leagueId, season);
        var all = [];

        for (teamIndex = 1; teamIndex <= listLen(teamList); teamIndex++) {
        	teamdata = getRemoteService().getTeamData(leagueid=arguments.leagueid, teamid=listGetAt(teamList, teamIndex), season=arguments.season, week=arguments.week); 
            doc = teamdata.doc;
			stuffDoc = teamData.stuffDoc;
			var defenseRow = stuffdoc.select("##playertable_2 tr.pncPlayerRow td.playerTableStat");
			var stuffs = defenseRow[16].child(0).text() * 10;
            league.setLeagueName(doc.select(".nav-main-breadcrumbs")[1].child(2).text());

            teamName = doc.select("##teamInfos")[1].child(0).child(0).child(1).child(0).child(0).text();
            tables = doc.select("##playertable_0")[1].parent().getElementsByClass("playerTableTable");
            record = doc.select("##teamInfos")[1].child(0).child(0).child(1).childNodes()[8].text();
            var opponentScore = doc.select(".totalScore")[2].text();
                        
            all = [];
            bench = [];
            for (tableIndex=1; tableIndex <= arrayLen(tables); tableIndex++) {
                if (tableIndex <= 3) {
                    all.addAll(tables[tableIndex].getElementsByClass("pncPlayerRow"));
                } else {
                    bench.addAll(tables[tableIndex].getElementsByClass("pncPlayerRow"));
                }
            }

            var team = createObject("component", "model.Team").init();
            var teamStreak = structKeyExists( streak, teamName ) ? streak[ teamName ] : "";
            team.setTeamName(teamName);
            team.setRecord(record);
            team.setStreak( teamStreak );
			team.setOpponentScore( opponentScore );
            addPlayersToTeam(all, team);
            addPlayersToTeam(bench, team, true);
			team.getActiveDefense().setStuffs( stuffs );
            league.addTeamToLeague(team);

        }

        return league;
    }

    private any function addPlayersToTeam(playerData, team, bench="false") {
        var playerIndex = "";

        for (playerIndex=1; playerIndex <= arrayLen(playerData); playerIndex++) {

            var name = playerData[playerIndex].child(1).text();
            

            if (NOT len(name) GTE 5) { continue; }
			name = replace( name, ',', '', 'ALL' );
            name = reReplace( name, '[^a-zA-z0-9\/\.\-]', ' ', 'ALL' );
            name = listToArray( name, ' ' );
            var position = name[ arrayLen( name ) ];
            arrayDeleteAt( name, arrayLen( name ) );
            var teamname = name[ arrayLen( name ) ];
            arrayDeleteAt( name, arrayLen( name ) );
            var playerName = arrayToList( name, ' ' );
            var stats = playerData[playerIndex].getElementsByClass("playertableStat");

            switch (position) {

            case "RB": case "WR": case "TE": case "QB": case "TQB":
                player = createObject("component", "model.OffensivePlayer").init();

                var attCompl = stats[1].text();
                player.setPassingAttempts(assureNumeric(listFirst(attCompl, "/")));
                player.setPassingCompletions(assureNumeric(listLast(attCompl, "/")));
                player.setPassingYards(assureNumeric(stats[2].text()));
                player.setPassingTouchdowns(assureNumeric(stats[3].text()));
                player.setInterceptions(assureNumeric(stats[4].text()));
                player.setRushingAttempts(assureNumeric(stats[5].text()));
                player.setRushingYards(assureNumeric(stats[6].text()));
                player.setRushingTouchdowns(assureNumeric(stats[7].text()));
                player.setReceptions(assureNumeric(stats[8].text()));
                player.setReceivingYards(assureNumeric(stats[9].text()));
                player.setReceivingTouchdowns(assureNumeric(stats[10].text()));
                player.set2PC(assureNumeric(stats[11].text()));
                player.setFumbles(assureNumeric(stats[12].text()));
                player.setOtherTD(assureNumeric(stats[13].text()));
                player.setPoints(assureNumeric(stats[14].text()));
                break;
            case "D/ST":
                player = createObject("component", "model.DefensivePlayer").init();
                player.setTouchdowns(assureNumeric(stats[1].text()));
                player.setInterceptions(assureNumeric(stats[2].text()));
                player.setFumbleRecoveries(assureNumeric(stats[3].text()));
                player.setSacks(assureNumeric(stats[4].text()));
                player.setSafeties(assureNumeric(stats[5].text()));
                player.setBlocks(assureNumeric(stats[6].text()));
                player.setPointsAllowed(assureNumeric(stats[7].text()));
                player.setPoints(assureNumeric(stats[8].text()));
                break;
            case "K":
                player = createObject("component", "model.Kicker").init();
                var short = stats[1].text();
                player.setShortAttempts(assureNumeric(listFirst(short, "/")));
                player.setShortFG(assureNumeric(listLast(short, "/")));

                var medium = stats[2].text();
                player.setMediumAttempts(assureNumeric(listFirst(medium, "/")));
                player.setMediumFG(assureNumeric(listLast(medium, "/")));

                var long = stats[3].text();
                player.setLongAttempts(assureNumeric(listFirst(long, "/")));
                player.setLongFG(assureNumeric(listLast(long, "/")));

                var xp = stats[5].text();
                player.setExtraPointAttempts(assureNumeric(listFirst(xp, "/")));
                player.setExtraPoints(assureNumeric(listLast(xp, "/")));

                player.setPoints(assureNumeric(stats[6].text()));
                break;
            }

            player.setPosition(position);
            player.setName(playerName);
            player.setTeam( teamname );

            if (bench) {
                team.addPlayerToBench(player);
            } else {
                team.addPlayerToRoster(player);
            }

        }

    }

    private numeric function assureNumeric(input) {
        if (not isNumeric(input)) {
            return 0;
        } else {
            return input;
        }
    }
}
