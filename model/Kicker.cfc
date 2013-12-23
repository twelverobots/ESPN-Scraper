/**
 * Created with IntelliJ IDEA.
 * User: jason
 * Date: 12/18/13
 * Time: 11:07 PM
 * To change this template use File | Settings | File Templates.
*/
component accessors="true" implements="IPlayer" {

    property name="name";
    property name="position";
    property name="points";
    property name="shortAttempts";
    property name="shortFG";
    property name="mediumAttempts";
    property name="mediumFG";
    property name="longAttempts";
    property name="longFG";
    property name="extraPointAttempts";
    property name="extraPoints";

    public any function init() {

        setShortAttempts(0);
        setShortFG(0);
        setMediumAttempts(0);
        setMediumFG(0);
        setLongAttempts(0);
        setLongFG(0);
        setExtraPointAttempts(0);
        setExtraPoints(0);
        setPoints(0);

        return this;
    }

    public numeric function getFG() {
        return getShortFG() + getMediumFG() + getLongFG();
    }

    public String function getCleanName(){
        return REReplace(listFirst(getName() ), "[^ a-zA-Z\']", "", "ALL");
    }

    public String function getTeam(){
        var str = trim(listLast( getName() ));
        var subEx = REFind( "[a-zA-Z]{2,3}", str, 1, true);
        if( arraylen( subEx.len ) ){
           str =  mid( str, subEx.pos[1], subEx.len[1] ); 
        }
        return str;
    }
}
