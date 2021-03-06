/*
    Controller: Created a controller for Case Print View
*/

//public with sharing class PrintViewCaseController {

public class PrintViewCaseController {
    
    public Case objCase {get; set;}
    
    public List<Root_Case__c> lstRootCases {get; set;}
    
    public PrintViewCaseController(Apexpages.standardcontroller controller){
        objCase = new Case();
        lstRootCases = new List<Root_Case__c>();
        Id caseid = controller.getId();
        if(caseid != null || Apexpages.currentPage().getParameters().get('CaseNumber') != null) {
            string casenumber = string.valueof(Apexpages.currentPage().getParameters().get('CaseNumber'));
            // get case details
            Map<String, Schema.SObjectField> caseFields = Schema.getGlobalDescribe().get('Case').getDescribe().fields.getMap();
            string strCaseQuery = 'SELECT';
            for(String s : caseFields.keySet()) {
               strCaseQuery += ' ' + s + ',';
            }
            strCaseQuery += ' Case.Account.Name,';
            // Strip off the last comma if it exists.
            if (strCaseQuery.subString(strCaseQuery.Length()-1,strCaseQuery.Length()) == ','){
                strCaseQuery = strCaseQuery.subString(0,strCaseQuery.Length()-1);
            }
            
            strCaseQuery += ' FROM Case Where Id =: caseid or CaseNumber =: casenumber';
            system.debug('strCaseQuery  :: '+strCaseQuery );
            List<Case> lstCase = Database.Query(strCaseQuery);
            if(lstCase.size() > 0) {
                objCase = lstCase[0];
                caseid = objCase.Id;
            }
            
            // get case details
            Map<String, Schema.SObjectField> rootcaseFields = Schema.getGlobalDescribe().get('Root_Case__c').getDescribe().fields.getMap();
            string strRootCaseQuery = 'SELECT';
            for(String s : rootcaseFields.keySet()) {
               strRootCaseQuery += ' ' + s + ',';
            }
            // Strip off the last comma if it exists.
            if (strRootCaseQuery.subString(strRootCaseQuery.Length()-1,strRootCaseQuery.Length()) == ','){
                strRootCaseQuery = strRootCaseQuery.subString(0,strRootCaseQuery.Length()-1);
            }
            strRootCaseQuery += ' FROM Root_Case__c Where Case_No__c =: caseid ';
            system.debug('strRootCaseQuery :: '+strRootCaseQuery );
            lstRootCases = Database.Query(strRootCaseQuery);
        }
    }
}