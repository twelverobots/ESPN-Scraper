/**
 * Created with IntelliJ IDEA.
 * User: jason
 * Date: 12/18/13
 * Time: 11:07 PM
 * To change this template use File | Settings | File Templates.
*/
component mappedSuperClass="true" accessors="true" implements="IPlayer" {

    property name="name";
    property name="position";
    property name="touchdowns";
    property name="points";
    property name="interceptions";
    property name="fumbleRecoveries";
    property name="sacks";
    property name="safeties";
    property name="blocks";
    property name="pointsAllowed";


    public any function init() {

        setInterceptions(0);
        setfumblerecoveries(0);
        setSacks(0);
        setSafeties(0);
        setBlocks(0);
        setPointsAllowed(0);
        setTouchdowns(0);
        setPoints(0);

        return this;
    }

    public String function getCleanName(){
        return listFirst(getName(), ' ');
    }

    public String function getTeam(){
        return "";
    }
}
