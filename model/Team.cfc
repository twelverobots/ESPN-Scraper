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

    public any function init() {
        setRoster([]);
        setBench([]);

        return this;
    }

    public void function addPlayerToRoster(IPlayer player) {

        arrayAppend(getRoster(), player);

    }

    public void function addPlayerToBench(IPlayer player) {
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


    public numeric function getScore() {
        return getRosterPoints();
    }
    
    public numeric function getMargin(){
    	return getScore() - getOpponentScore();
    }

    public numeric function getBenchPoints() {
        var roster = getBench();
        var playerIndex = "";
        var points = 0;

        for (playerIndex = 1; playerIndex <= arrayLen(roster); playerIndex++) {

            points+= roster[playerIndex].getPoints();

        }

        return points;
    }
}
