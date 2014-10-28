/**
 * Created with IntelliJ IDEA.
 * User: jason
 * Date: 12/18/13
 * Time: 10:35 PM
 * To change this template use File | Settings | File Templates.
*/
component accessors="true" {
    property name="teamName";
    property name="roster" type="array";
    property name="bench" type="array";
    property name="record";
    property name="opponentScore";
    property name="streak";
    property name="activeDefense";
    property name="activeOffense" type="array";
    property name="activeKicker"; 
    property name="activeQB";
    property name="benchQBs" type="array"; 
    property name="bestBenchQB";
    property name="interceptions";
    property name="fumbles";
    property name="score";
    property name="benchPoints";
    property name="opponentBenchPoints";

    public any function init() {
        setRoster([]);
        setBench([]);
		setActiveOffense( [] );
		setBenchQBs( [] );
		setOpponentscore( 0 );
		setBenchPoints( 0 );
        setFumbles(0);
        setInterceptions(0);
        setScore(0);

        return this;
    }

    public void function addPlayerToRoster(IPlayer player) {
		switch( player.getPosition() ){
			case 'D/ST':
			setActiveDefense( player );
			break;
			case 'K':
			setActiveKicker( player );
			break;
			case "QB": case "TQB":
			setActiveQB( player );
			default:
			arrayAppend( getActiveOffense(), player );
			setFumbles( getFumbles() + player.getFumbles() );
			setInterceptions( getInterceptions() + player.getInterceptions() );
		}
		//setScore( getScore() + player.getPoints() );
        arrayAppend(getRoster(), player);

    }

    public void function addPlayerToBench(IPlayer player) {
    	switch( player.getPosition() ){
    		case "QB" : case "TQB":
    		arrayAppend( getBenchQBs(), player );
    		if( isNull( getBestBenchQB() ) || player.getPoints() > getBestBenchQB().getPoints() ){
    			setBestBenchQB( player );
    		}
    	}
    	//setBenchPoints( getBenchPoints() + player.getPoints() );
        arrayAppend(getBench(), player);

    }

    public numeric function getPassingYards() {
        var roster = getRoster();
        var playerIndex = "";
        var yards = 0;

        for (playerIndex = 1; playerIndex <= arrayLen(roster); playerIndex++) {
            if (isInstanceOf(roster[playerIndex], "model.OffensivePlayer")) {
                yards+= roster[playerIndex].getPassingYards();
            }

        }

        return yards;
    }

    public numeric function getRushingYards() {
        var roster = getRoster();
        var playerIndex = "";
        var yards = 0;

        for (playerIndex = 1; playerIndex <= arrayLen(roster); playerIndex++) {
            if (isInstanceOf(roster[playerIndex], "model.OffensivePlayer")) {
                yards+= roster[playerIndex].getRushingYards();
            }

        }

        return yards;
    }

    public numeric function getRushingAverage() {
        var roster = getRoster();
        var playerIndex = "";
        var yards = 0;
        var pCount = 0;

        for (playerIndex = 1; playerIndex <= arrayLen(roster); playerIndex++) {
            if (isInstanceOf(roster[playerIndex], "model.OffensivePlayer")) {
                yards+= roster[playerIndex].getRushingYards();
                if (roster[playerIndex].getPosition() EQ "RB") {
                    pCount++;
                }
            }

        }

        var avg = (yards NEQ 0 AND pCount NEQ 0) ? (yards / pCount) : 0;

        return avg;
    }

    public numeric function getReceivingAverage() {
        var roster = getRoster();
        var playerIndex = "";
        var yards = 0;
        var pCount = 0;

        for (playerIndex = 1; playerIndex <= arrayLen(roster); playerIndex++) {
            if (isInstanceOf(roster[playerIndex], "model.OffensivePlayer")) {
                yards+= roster[playerIndex].getReceivingYards();

                if ( roster[playerIndex].getPosition() CONTAINS "WR" OR roster[playerIndex].getPosition() CONTAINS "TE" ) {
                    pCount++;
                }
            }

        }

        var avg = (yards NEQ 0 AND pCount NEQ 0) ? (yards / pCount) : 0;

        return avg;
    }

    public numeric function getReceivingYards() {
        var roster = getRoster();
        var playerIndex = "";
        var yards = 0;

        for (playerIndex = 1; playerIndex <= arrayLen(roster); playerIndex++) {
            if (isInstanceOf(roster[playerIndex], "model.OffensivePlayer")) {
                yards+= roster[playerIndex].getReceivingYards();
            }

        }

        return yards;
    }

    public numeric function getRosterPoints() {
        var roster = getRoster();
        var playerIndex = "";
        var points = 0;

        for (playerIndex = 1; playerIndex <= arrayLen(roster); playerIndex++) {

            points+= roster[playerIndex].getPoints();

        }

        return points;
    }

    public numeric function getQBTouchDowns() {
        var roster = getRoster();
        var playerIndex = "";
        var points = 0;

        for (playerIndex = 1; playerIndex <= arrayLen(roster); playerIndex++) {
            if (roster[playerIndex].getPosition() CONTAINS "QB") {
                return roster[playerIndex].getPassingTouchdowns();
            }

        }

        return 0;
    }

    public numeric function getBenchOutscoredRoster() {
        return getScore() < getBenchPoints();
    }

    public numeric function getDefenseTouchDowns() {
        return getActiveDefense().getTOuchdowns();
    }

    public numeric function getOffensiveDefense() {
        return getDefenseTouchDowns() - getQBTouchDowns();
    }
    
    public numeric function getMargin(){
    	return getScore() - getOpponentScore();
    }

    
    public numeric function getPointsAllowed(){
    	return getActiveDefense().getPointsAllowed();
    }
    
    public numeric function getSacks(){
    	return getActiveDefense().getSacks();
    }
    
    public numeric function getStuffs(){
    	return getActiveDefense().getStuffs();
    }
    
    public Boolean function isBenchQBBetter(){
    	return !isNull( getActiveQB() ) ? getActiveQB().getPoints() < getBestBenchQBPoints() : false;
    }
    
    public function getBestBenchQBPoints(){
    	var ret = 0;
    	if( !isNull( getBestBenchQB() ) ){
    		ret = getbestBenchQB().getPoints();
    	}
    	return ret;
    }
    
    public function getStartingQBDifference(){
    	return getActiveQB().getPoints() - getBestBenchQBPoints();
    }

    public function getRisks() {
        var roster = getRoster();
        var playerIndex = "";
        var risks = 0;

        for (playerIndex = 1; playerIndex <= arrayLen(roster); playerIndex++) {

            if ( listFind( "P,D,Q", roster[playerIndex].getPlayProbability() ) ) {
                risks++;
            }

        }

        return risks;
    }
    
    public function getBenchMargin(){
    	return getBenchPoints() - getOpponentBenchPoints();
    }
    
    public function getBenchStarterMargin(){
    	return getBenchPoints() - getOpponentScore();
    }
    
    public function getCompositeScore(){
    	return getBenchPoints() + getScore();
    }

}
