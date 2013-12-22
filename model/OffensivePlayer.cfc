/**
 * Created with IntelliJ IDEA.
 * User: jason
 * Date: 12/18/13
 * Time: 11:05 PM
 * To change this template use File | Settings | File Templates.
*/
component mappedSuperClass="true" accessors="true" implements="IPlayer" {

    property name="name";
    property name="position";

    property name="passingAttempts";
    property name="passingCompletions";
    property name="passingYards";
    property name="passingTouchdowns";
    property name="interceptions";

    property name="rushingAttempts";
    property name="rushingYards";
    property name="rushingTouchdowns";

    property name="receptions";
    property name="receivingYards";
    property name="receivingTouchdowns";

    property name="points";

    property name="fumbles";
    property name="2pc";
    property name="otherTD";

    public any function init() {

        setPassingAttempts(0);
        setPassingCompletions(0);
        setPassingYards(0);
        setPassingTouchdowns(0);
        setInterceptions(0);

        setRushingAttempts(0);
        setRushingYards(0);
        setRushingTouchdowns(0);

        setReceptions(0);
        setReceivingYards(0);
        setReceivingTouchdowns(0);

        setPoints(0);

        setFumbles(0);
        set2PC(0);
        setOtherTD(0);


        return this;
    }

}
