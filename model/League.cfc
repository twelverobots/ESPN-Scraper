/**
 * Created with IntelliJ IDEA.
 * User: jason
 * Date: 12/18/13
 * Time: 10:35 PM
 * To change this template use File | Settings | File Templates.
*/
component accessors="true" {

    property name="leagueID";
    property name="leagueName";
    property name="teams";
    property name="week";

    public any function init() {
        setTeams([]);

        return this;
    }

    public any function addTeamToLeague(team) {
        arrayAppend(getTeams(), team);
    }

    public any function getMostPassingYards() {
        var teamIndex = "";
        var teams = getTeams();
        var currentTeam = "";
        var highestTeam = new model.Team();

        for (teamIndex = 1; teamIndex <= arraylen(teams); teamIndex++) {
            currentTeam = teams[teamIndex];

            if (currentTeam.getPassingYards() GT highestTeam.getPassingYards()) {
                highestTeam = currentTeam;
            }
        }

        return highestTeam;

    }

    public any function getMostRushingYards() {
        var teamIndex = "";
        var teams = getTeams();
        var currentTeam = "";
        var highestTeam = new model.Team();

        for (teamIndex = 1; teamIndex <= arraylen(teams); teamIndex++) {
            currentTeam = teams[teamIndex];

            if (currentTeam.getRushingYards() GT highestTeam.getRushingYards()) {
                highestTeam = currentTeam;
            }
        }

        return highestTeam;

    }

    public any function getMostReceivingYards() {
        var teamIndex = "";
        var teams = getTeams();
        var currentTeam = "";
        var highestTeam = new model.Team();

        for (teamIndex = 1; teamIndex <= arraylen(teams); teamIndex++) {
            currentTeam = teams[teamIndex];

            if (currentTeam.getReceivingYards() GT highestTeam.getReceivingYards()) {
                highestTeam = currentTeam;
            }
        }

        return highestTeam;

    }

    public any function getHighestScore() {
        var teamIndex = "";
        var teams = getTeams();
        var currentTeam = "";
        var highestTeam = new model.Team();

        for (teamIndex = 1; teamIndex <= arraylen(teams); teamIndex++) {
            currentTeam = teams[teamIndex];

            if (currentTeam.getScore() GT highestTeam.getScore()) {
                highestTeam = currentTeam;
            }
        }

        return highestTeam;
    }

    public any function getLowestScore() {
        var teamIndex = "";
        var teams = getTeams();
        var currentTeam = "";

        var lowestTeam = teams[1];

        for (teamIndex = 1; teamIndex <= arraylen(teams); teamIndex++) {
            currentTeam = teams[teamIndex];

            if (currentTeam.getScore() LT lowestTeam.getScore()) {
                lowestTeam = currentTeam;
            }
        }

        return lowestTeam;
    }
    
    public any function getLargestMarginOfVictory(){
    	var teams = getTeams();
    	var highestTeam = teams[ 1 ];
    	for( var currentTeam in teams ){
    		if( currentTeam.getMargin() > highestTeam.getMargin()  ){
    			highestTeam = currentTeam;
    		}
    	}
    	
    	return highestTeam;
    }
    
    public any function getLargestMarginOfDefeat(){
    	var teams = getTeams();
    	var lowestTeam = teams[ 1 ];
    	for( var currentTeam in teams ){
    		if( currentTeam.getMargin() < lowestTeam.getMargin()  ){
    			lowestTeam = currentTeam;
    		}
    	}
    	
    	return lowestTeam;
    }
    
    public any function getSmallestMarginOfVictory(){
    	var teams = getTeams();
    	var smallestTeam = teams[ 1 ];
    	for( var currentTeam in teams ){
    		if( currentTeam.getMargin() > 0 && currentTeam.getMargin() < smallestTeam.getMargin()  ){
    			smallestTeam = currentTeam;
    		}
    	}
    	return smallestTeam;
    }
    
    public any function getSmallestMarginOfDefeat(){
    	var teams = getTeams();
    	var smallestTeam = teams[ 1 ];
    	for( var currentTeam in teams ){
    		if( currentTeam.getMargin() < 0 && abs( currentTeam.getMargin() ) < abs( smallestTeam.getMargin() ) ){
    			smallestTeam = currentTeam;
    		}
    	}
    	return smallestTeam;
    }
    
    public any function getCloseMatches( Numeric diff ){
    	var ret = [];
    	for( var team in getTeams() ){
    		if( abs( team.getMargin() ) < diff ){
    			arrayAppend( ret, team );
    		}
    	}
    	return ret;
    }
}