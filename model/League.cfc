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
    property name="mostPassingYards";
    property name="mostPassingYardsTeam";
    property name="mostRushingYards";
    property name="mostRushingYardsTeam";

    public any function init() {
        setTeams([]);
		variables.mostPassingYards = 0;
		variables.mostRushingYards = 0;
        return this;
    }

    public any function addTeamToLeague(team) {
        arrayAppend(getTeams(), team);
        setMostPassingYards( team );
        setMostRushingYards( team );
    }
    

    public any function getMostPassingYards() {
    	var highestTeam = getMostPassingYardsTeam();
    	if( isNull( highestTeam ) ){
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
    	}
        return highestTeam;
    }

    public any function getMostRushingYards() {
    	var highestTeam = getMostRushingYardsTeam();
    	if( isNull( highestTeam ) ){
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
    	var smallestTeam = new Team().setOpponentScore(-5000 ) ;
    	for( var currentTeam in teams ){
    		if( currentTeam.getMargin() > 0 && currentTeam.getMargin() < smallestTeam.getMargin()  ){
    			smallestTeam = currentTeam;
    		}
    	}
    	return smallestTeam;
    }
    
    public any function getSmallestMarginOfDefeat(){
    	var teams = getTeams();
    	var smallestTeam = new Team().setOpponentScore(5000);
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
    
    public any function getLosingStreaks( Numeric streak ){
    	var ret = [];
    	for( var team in getTeams() ){
    		var type = reReplace( team.getStreak(), '[^a-zA-z]', '', 'all' );
    		var count = reReplace( team.getStreak(), '[^0-9]', '', 'all' );
    		if (type == 'l' && count >= streak ){
    			arrayAppend( ret, team );
    		}
    	}
    	return ret;
    }
    
    public any function getBadStartingQBs(){
    	var ret = [];
    	for( var team in getTeams() ){
    		if ( team.isBenchQBBetter()  ){
    			arrayAppend( ret, team );
    		}
    	}
    	return ret;
    }
    
    public any function getFewestPointsAllowed(){
    	var teams = getTeams();
    	var leastTeam = teams[ 1 ];
    	for( var currentTeam in teams ){
    		if( currentTeam.getPointsAllowed() < leastTeam.getPointsAllowed() ) {
    			leastTeam = currentTeam;
    		}
    	}
    	return leastTeam;
    }
    
    public any function getMostPointsAllowed(){
    	var teams = getTeams();
    	var mostTeam = teams[ 1 ];
    	for( var currentTeam in teams ){
    		if( currentTeam.getPointsAllowed() > mostTeam.getPointsAllowed() ) {
    			mostTeam = currentTeam;
    		}
    	}
    	return mostTeam;
    }
    
    public any function getMostSacks(){
    	var teams = getTeams();
    	var mostTeam = teams[ 1 ];
    	for( var currentTeam in teams ){
    		if( currentTeam.getSacks() > mostTeam.getSacks() ) {
    			mostTeam = currentTeam;
    		}
    	}
    	return mostTeam;
    }
    
     public any function getMostFumbles(){
    	var teams = getTeams();
    	var mostTeam = teams[ 1 ];
    	for( var currentTeam in teams ){
    		if( currentTeam.getFumbles() > mostTeam.getFumbles() ) {
    			mostTeam = currentTeam;
    		}
    	}
    	return mostTeam;
    }
    
    public any function getMostinterceptions(){
    	var teams = getTeams();
    	var mostTeam = teams[ 1 ];
    	for( var currentTeam in teams ){
    		if( currentTeam.getInterceptions() > mostTeam.getinterceptions() ) {
    			mostTeam = currentTeam;
    		}
    	}
    	return mostTeam;
    }
    
    //get teams sorted by category

    public function onMissingMethod(String methodName, Struct arguments){
    	if( left( methodName, 5 ) == 'getBy' ){
    		var teams = duplicate( getTeams() );
    		switch( methodName ){
    			case "getByHighestScore":
	    			arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getScore() GT r.getScore() ){
			    			ret = -1;
			    		}
			    		if( l.getScore() LT r.getScore() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getScore() == teams[1].getScore();
				    	});
			    	}
		    	break;
		    	case "getByLowestScore":
		    		arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getScore() LT r.getScore() ){
			    			ret = -1;
			    		}
			    		if( l.getScore() GT r.getScore() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getScore() == teams[1].getScore();
				    	});
			    	}
			    break;
			    case "getByMostBenchPoints":
	    			arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getBenchPoints() GT r.getBenchPoints() ){
			    			ret = -1;
			    		}
			    		if( l.getBenchPoints() LT r.getBenchPoints() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getBenchPoints() == teams[1].getBenchPoints();
				    	});
			    	}
		    	break;
			    case "getByMostPassingYards":
			    	arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getPassingYards() GT r.getPassingYards() ){
			    			ret = -1;
			    		}
			    		if( l.getPassingYards() LT r.getPassingYards() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getPassingYards() == teams[1].getPassingYards();
				    	});
			    	}
			    break;
			    case "getByMostRushingYards":
			    	arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getRushingYards() GT r.getRushingYards() ){
			    			ret = -1;
			    		}
			    		if( l.getRushingYards() LT r.getRushingYards() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getRushingYards() == teams[1].getRushingYards();
				    	});
			    	}
			    break;
			    case "getByMostReceivingYards":
			    	arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getReceivingYards() GT r.getReceivingYards() ){
			    			ret = -1;
			    		}
			    		if( l.getReceivingYards() LT r.getReceivingYards() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getReceivingYards() == teams[1].getReceivingYards();
				    	});
			    	}
			    break;
			    case "getByFewestPointsAllowed":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getPointsAllowed() LT r.getPointsAllowed() ){
			    			ret = -1;
			    		}
			    		if( l.getPointsAllowed() GT r.getPointsAllowed() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getPointsAllowed() == teams[1].getPointsAllowed();
				    	});
			    	}
			    break;
			    case "getByMostPointsAllowed":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getPointsAllowed() GT r.getPointsAllowed() ){
			    			ret = -1;
			    		}
			    		if( l.getPointsAllowed() LT r.getPointsAllowed() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getPointsAllowed() == teams[1].getPointsAllowed();
				    	});
			    	}
			    break;
			    case "getByMostSacks":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getSacks() GT r.getSacks() ){
			    			ret = -1;
			    		}
			    		if( l.getSacks() LT r.getSacks() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getSacks() == teams[1].getSacks();
				    	});
			    	}
			    break;
			    case "getByMostStuffs":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getStuffs() GT r.getStuffs() ){
			    			ret = -1;
			    		}
			    		if( l.getStuffs() LT r.getStuffs() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getStuffs() == teams[1].getStuffs();
				    	});
			    	}
			    break;
			    case "getByWidestMarginVictory":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getMargin() GT r.getMargin() ){
			    			ret = -1;
			    		}
			    		if( l.getMargin() LT r.getMargin() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getMargin() == teams[1].getMargin();
				    	});
			    	}
			    break;
			    case "getByWidestMarginDefeat":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getMargin() LT r.getMargin() ){
			    			ret = -1;
			    		}
			    		if( l.getMargin() GT r.getMargin() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getMargin() == teams[1].getMargin();
				    	});
			    	}
			    break;
			     case "getByNarrowestMarginOfVictory":
				     teams = arrayFilter( teams, function( team){
				     	return team.getMargin() >= 0;
				     } );
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getMargin() LT r.getMargin() ){
			    			ret = -1;
			    		}
			    		if( l.getMargin() GT r.getMargin() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getMargin() == teams[1].getMargin();
				    	});
			    	}
			    break;
			    case "getByNarrowestMarginOfDefeat":
				     teams = arrayFilter( teams, function( team){
				     	return team.getMargin() <= 0;
				     } );
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getMargin() GT r.getMargin() ){
			    			ret = -1;
			    		}
			    		if( l.getMargin() LT r.getMargin() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getMargin() == teams[1].getMargin();
				    	});
			    	}
			    break;
			    case "getByMostFumbles":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getFumbles() GT r.getFumbles() ){
			    			ret = -1;
			    		}
			    		if( l.getFumbles() LT r.getFumbles() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getFumbles() == teams[1].getFumbles();
				    	});
			    	}
			    break;
			    case "getByMostInterceptions":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getInterceptions() GT r.getInterceptions() ){
			    			ret = -1;
			    		}
			    		if( l.getInterceptions() LT r.getInterceptions() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getInterceptions() == teams[1].getInterceptions();
				    	});
			    	}
			    break;
			    case "getByCloseMatch":
				     teams = arrayFilter( teams, function( team){
				     	return abs( team.getMargin() ) < 1;
				     } );
			    break;
			    case "getByLosingStreak":
			    	teams = arrayFilter( teams, function( team ){
			    		var type = reReplace( team.getStreak(), '[^a-zA-z]', '', 'all' );
    					var count = reReplace( team.getStreak(), '[^0-9]', '', 'all' );
    					return type == 'l' && count >= 3;
			    	});
			    break;
			    case "getByBadQB":
			    	teams = arrayFilter( teams, function( team ){
			    		return team.isBenchQBBetter();
			    	});
			    break;
			    case "getByHighScoringLosers":
			    	teams = arrayFilter( teams, function( team ) {
			    		return team.getMargin() < 0;
			    	});
			    	arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getScore() GT r.getScore() ){
			    			ret = -1;
			    		}
			    		if( l.getScore() LT r.getScore() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getScore() == teams[1].getScore();
				    	});
			    	}
			    break;
                case "getByMostRisks":
			    	arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getRisks() GT r.getRisks() ){
			    			ret = -1;
			    		}
			    		if( l.getRisks() LT r.getRisks() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getRisks() == teams[1].getRisks();
				    	});
			    	}
			    break;
                case "getByWorstRushingAverage":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getRushingAverage() LT r.getRushingAverage() ){
			    			ret = -1;
			    		}
			    		if( l.getRushingAverage() GT r.getRushingAverage() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getRushingAverage() == teams[1].getRushingAverage();
				    	});
			    	}
			    break;
                case "getByWorstReceivingAverage":
				    arraySort( teams, function( l, r ){
			    		var ret = 0;
			    		if( l.getReceivingAverage() LT r.getReceivingAverage() ){
			    			ret = -1;
			    		}
			    		if( l.getReceivingAverage() GT r.getReceivingAverage() ){
			    			ret = 1;
			    		}
			    		return ret;
			    	});
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getReceivingAverage() == teams[1].getReceivingAverage();
				    	});
			    	}
			    break;
                case "getByOffensiveDefense":
			    	if( arrayLen( teams ) ){
			    		teams = arrayFilter( teams, function( team ){
				    		return team.getQBTouchdowns() < team.getDefenseTouchdowns();
				    	});
			    	}
			    break;
                case "getByMostBenchPointsVsRosterPoints":
                    teams = arrayFilter( teams, function( team ){
			    		return team.getBenchOutscoredRoster();
			    	});
			    break;
			    case "getByRinger":
			    teams = arrayFilter( teams, function( team ) {
			    	return !isNull( team.getActiveKicker() ) && !isNull( team.getActiveQB() ) ? team.getActiveKicker().getPoints() > team.getActiveQB().getPoints() : false;
			    });
			    break;
    		}
    		return teams;
    	}
    	
    	else{
    		throw( message="No method named #methodname# exists in the League CFC");
    	}
    }
    
    // private methods
    private function setMostPassingYards( team ){
    	if( team.getPassingYards() > variables.mostPassingYards ){
    		variables.mostPassingYards = team.getPassingYards();
    		setMostPassingYardsTeam( team );
    	}
    }
    
    private function setMostRushingYards( team ){
    	if( team.getRushingYards() > variables.mostRushingYards ){
    		variables.mostRushingYards = team.getRushingYards();
    		setMostRushingYardsTeam( team );
    	}
    }
}