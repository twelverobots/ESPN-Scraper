/**
 * Created with IntelliJ IDEA.
 * User: jason
 * Date: 12/18/13
 * Time: 10:30 PM
 * To change this template use File | Settings | File Templates.
*/
component {

    this.name = "ESPNScrape";
    this.mappings["/services"] = getDirectoryFromPath(getCurrentTemplatePath()) & "services";
    this.mappings["/model"] = getDirectoryFromPath(getCurrentTemplatePath()) & "model";
    this.mappings["/data"] = getDirectoryFromPath(getCurrentTemplatePath()) & "data";
    public void function onApplicationStart() {

        var jsoup = createObject("java", "org.jsoup.Jsoup");

        var espnComm = createObject("component", "services.ESPNComm").init();

        espnComm.setParser(jsoup);

        application.gateway = createObject("component", "model.FantasyGateway").init();

        application.gateway.setRemoteService(espnComm);

    }

    public void function onRequestStart() {
    	if( structKeyExists( url, 'reload' ) ){
    		onApplicationStart();
    	}
        
    }
}
