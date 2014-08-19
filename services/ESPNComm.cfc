component accessors="true" {

    property name="parser";


    public any function init() {
        return this;
    }

    public any function getTeams(leagueid, season) {
        var cacheKey = hash(leagueid & season);
        var teamData = cacheGet(cachekey);

        if (true OR isNull(cachedData)) {
            var httpService = new HTTP();

            httpService.setMethod("get");
            httpService.setCharset("utf-8");
            httpService.setURL("http://games.espn.go.com/ffl/scoreboard");
            httpService.addParam(name="leagueId", type="url", value=arguments.leagueid);
            httpService.addParam(name="seasonId", type="url", value=arguments.season);

            var result = httpService.send().getPrefix();

            var teamData = getParser().parse(result.filecontent);

            cachePut(cacheKey, teamData, createTimespan(0,3,0,0));

        }

        return teamData;

    }

    public any function getTeamData(leagueid, teamid, week, season) {

        var cacheKey = hash(leagueid & teamid & week & season);
        var teamData = cacheGet(cachekey);

        if (true OR isNull(cachedData)) {
            var httpService = new HTTP();

            httpService.setMethod("get");
            httpService.setCharset("utf-8");
            httpService.setURL("http://games.espn.go.com/ffl/boxscorefull");
            httpService.addParam(name="leagueId", type="url", value=arguments.leagueid);
            httpService.addParam(name="teamId", type="url", value=arguments.teamid);
            httpService.addParam(name="scoringPeriodId", type="url", value=arguments.week);
            httpService.addParam(name="seasonId", type="url", value=arguments.season);
            httpService.addParam(name="view", type="url", value="scoringperiod");
            httpService.addParam(name="version", type="url", value="full");

            var result = httpService.send().getPrefix();

            var teamData = getParser().parse(result.filecontent);

            cachePut(cacheKey, teamData, createTimespan(0,3,0,0));

        }

        return teamData;


    }

}

