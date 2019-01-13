/*
    Description: Test class for RootInclusionCaseAddAuditInfoController
*/
@isTest
public with sharing class RootInclusionCaseAddAuditInfoCtrlTest {
    static testmethod void TestAddAuditInfo(){  
        //create the parent account  - record type = Owner
        Account parentAccount = TestUtils.getCAOwner();
        insert parentAccount;
        
        // create the contact associated with the parent account
        Contact parentContact = TestUtils.getContact(parentAccount.id);
        insert parentContact;
        
        // create the child account - record type = Root
        Account childAccount = TestUtils.getRootCertificate(parentAccount.id);
        insert childAccount;
        
        // create a case
        Case accountCaseA = TestUtils.getCase(parentAccount.id);
        accountCaseA.request_status__c  = 'Initial Request Received';         
        insert accountCaseA;
        
        RootInclusionCaseAddAuditInfoController objcontroller = new RootInclusionCaseAddAuditInfoController(new Apexpages.standardcontroller(accountCaseA));
        objcontroller.SelectDifferentRootCerts();
        objcontroller.lstWrapAllRootCerts[0].isSelected = true;
        objcontroller.ViewAuditDetails();
        objcontroller.UpdateCaseInfo();
        
    }
}