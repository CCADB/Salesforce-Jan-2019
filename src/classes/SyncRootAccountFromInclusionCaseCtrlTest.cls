/*
    Description: Test class for SyncRootAccountFromInclusionCaseCtrl. Sync program for New Inclusion type root case.
*/
@isTest
public class SyncRootAccountFromInclusionCaseCtrlTest {
    
    @testsetup static void testdata(){
        String PEMinfo = '-----BEGIN CERTIFICATE-----' +
               'MIIDg6P3qMZLWh1K8F/30ltoN10igQ35y' +
               'Bx4GG+Ub/zMhkrtTClipcItkEwu7fHEdZN6/wQKh' +
               '-----END CERTIFICATE-----';
               
        // create the parent account  - record type = Owner
        Account parentAccount = TestUtils.getCAOwner();
        parentAccount.X_509_Certificate_PEM__c = PEMinfo;
        insert parentAccount;
        
        // create the contact associated with the parent account
        Contact parentContact = TestUtils.getContact(parentAccount.id);
        insert parentContact;
        
        // create the child account - record type = Root
        Account childAccount = TestUtils.getRootCertificate(parentAccount.id);
        childAccount.SHA_256_Fingerprint__c = '6FDB3F76C8B801A75338D8A50A7C02879F6198B57E594D318D3832900FEDCD70';
        childAccount.X_509_Certificate_PEM__c = PEMinfo;
        childAccount.Name = 'child root account 1';
        
        // create the child account - record type = Root
        Account childAccount1 = TestUtils.getRootCertificate(parentAccount.id);
        childAccount1.X_509_Certificate_PEM__c = PEMinfo;
        childAccount1.SHA_256_Fingerprint__c = '6FDB3F76C8B801A75338D8A50A7C02879F6198B57E594D318D3832900FEDCD79';
        childAccount1.Name = 'child root account 2';
        
        // create the child account - record type = Root
        Account childAccount2 = TestUtils.getRootCertificate(parentAccount.id);
        childAccount2.X_509_Certificate_PEM__c = PEMinfo;
        childAccount2.SHA_256_Fingerprint__c = '6FDB3F76C8B801A75338D8A50A7C02879F6198B57E594D318D3832900FEDCD71';
        childAccount2.Name = 'child root account 3';
        
        insert new list<Account>{childAccount, childAccount1, childAccount2};
        
        // create a case
        Case accountCaseA = TestUtils.getCase(parentAccount.id);
        accountCaseA.request_status__c  = 'Initial Request Received';         
        accountCaseA.Status = 'Open';
        accountCaseA.Request_Status__c = 'Data Verified';
        accountCaseA.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CA Root Inclusion Request').getRecordTypeID();
        accountCaseA.Case_Progress__c = 'Verification by Root Store';
        accountCaseA.CA_Owner_Information_Verified__c  = 'Data Verified';
        accountCaseA.Auditor_Verified__c = 'Data Verified';
        accountCaseA.Case_Progress__c = 'Verification by Root Store';
        accountCaseA.Standard_Audit_Verified__c = 'Data Verified';
        accountCaseA.Code_Signing_Audit_Verified__c = 'Not Applicable';
        accountCaseA.BR_Audit_Statement_Link_Verified__c = 'Data Verified';
        accountCaseA.EV_Audit_Statement_Link_Verified__c = 'Data Verified';
        accountCaseA.EV_Code_Signing_Verified__c = 'Data Verified';
        accountCaseA.CP_CPS_Links_Verified__c = 'Data Verified';
        accountCaseA.Required_Practices_Verified__c  = 'Not Applicable';
        accountCaseA.Forbidden_Practices_Verified__c = 'Not Applicable';
        insert accountCaseA;
            
        // create the root case and associate it with the case
        Root_Case__c rootCaseA1 = TestUtils.getRootCase(accountCaseA.id, parentAccount.Id);
        rootCaseA1.SHA_256_Fingerprint__c = '6FDB3F76C8B801A75338D8A50A7C02879F6198B57E594D318D3832900FEDCD70';
        rootCaseA1.X_509_Certificate_PEM__c = PEMinfo;
        rootCaseA1.Request_Status__c = 'Initial Request Received';
        rootCaseA1.RecordTypeId = Schema.SObjectType.Root_Case__c.getRecordTypeInfosByName().get('CA Root Inclusion Request').getRecordTypeID();
        
        Root_Case__c rootCaseA2 = TestUtils.getRootCase(accountCaseA.id, parentAccount.Id);
        rootCaseA2.SHA_256_Fingerprint__c = '6FDB3F76C8B801A75338D8A50A7C02879F6198B57E594D318D3832900FEDCD79';
        rootCaseA2.X_509_Certificate_PEM__c = PEMinfo;
        rootCaseA2.Request_Status__c = 'Initial Request Received';
        rootCaseA2.RecordTypeId = Schema.SObjectType.Root_Case__c.getRecordTypeInfosByName().get('CA Root Inclusion Request').getRecordTypeID();
        
        Root_Case__c rootCaseA3 = TestUtils.getRootCase(accountCaseA.id, parentAccount.Id);
        rootCaseA3.SHA_256_Fingerprint__c = '6FDB3F76C8B801A75338D8A50A7C02879F6198B57E594D318D3832900FEDCD71';
        rootCaseA3.X_509_Certificate_PEM__c = PEMinfo;
        rootCaseA3.Request_Status__c = 'Initial Request Received';
        rootCaseA3.RecordTypeId = Schema.SObjectType.Root_Case__c.getRecordTypeInfosByName().get('CA Root Inclusion Request').getRecordTypeID();
        
        insert new List<Root_Case__c>{rootCaseA1, rootCaseA2, rootCaseA3};
        
        //changes request_status__c in proper sequence
        rootCaseA1.request_status__c  = 'Information Verification In Process';
        rootCaseA2.request_status__c  = 'Information Verification In Process';
        rootCaseA3.request_status__c  = 'Information Verification In Process';
        update new List<Root_Case__c>{rootCaseA1,rootCaseA2,rootCaseA3};
        
        rootCaseA1.request_status__c  = 'In Detailed CP/CPS Review';
        rootCaseA1.Application_Information_Verified__c = 'Data Verified';
        rootCaseA1.PKI_Hierarchy_Verified__c = 'Data Verified';
        rootCaseA1.Apply_Audit_Verified__c = 'Data Verified';
        rootCaseA1.Test_Website_Verified__c = 'Data Verified';
        rootCaseA1.Test_Results_Verified__c = 'Data Verified';
        rootCaseA1.Mozilla_fields_Verified__c = 'Data Verified';
        rootCaseA2.request_status__c  = 'In Detailed CP/CPS Review';
        rootCaseA2.Application_Information_Verified__c = 'Data Verified';
        rootCaseA2.PKI_Hierarchy_Verified__c = 'Data Verified';
        rootCaseA2.Apply_Audit_Verified__c = 'Data Verified';
        rootCaseA2.Test_Website_Verified__c = 'Data Verified';
        rootCaseA2.Test_Results_Verified__c = 'Data Verified';
        rootCaseA2.Mozilla_fields_Verified__c = 'Data Verified';
        rootCaseA3.request_status__c  = 'In Detailed CP/CPS Review';
        rootCaseA3.Application_Information_Verified__c = 'Data Verified';
        rootCaseA3.PKI_Hierarchy_Verified__c = 'Data Verified';
        rootCaseA3.Apply_Audit_Verified__c = 'Data Verified';
        rootCaseA3.Test_Website_Verified__c = 'Data Verified';
        rootCaseA3.Test_Results_Verified__c = 'Data Verified';
        rootCaseA3.Mozilla_fields_Verified__c = 'Data Verified';
        update new List<Root_Case__c>{rootCaseA1,rootCaseA2,rootCaseA3};
        
        // Start the test
        Test.startTest();
        
        rootCaseA1.request_status__c  = 'In Public Discussion';
        rootCaseA2.request_status__c  = 'In Public Discussion';
        rootCaseA3.request_status__c  = 'In Public Discussion';
        update new List<Root_Case__c>{rootCaseA1,rootCaseA2,rootCaseA3};
        
        rootCaseA1.request_status__c   = 'Pending Approval';
        rootCaseA2.request_status__c  = 'Pending Approval';
        rootCaseA3.request_status__c  = 'Pending Approval';
        update new List<Root_Case__c>{rootCaseA1,rootCaseA2,rootCaseA3};
        
        
        
        rootCaseA1.request_status__c   = 'Approved, Pending Inclusion';
        rootCaseA2.request_status__c  = 'Approved, Pending Inclusion';
        rootCaseA3.request_status__c  = 'Approved, Pending Inclusion';
        update new List<Root_Case__c>{rootCaseA1,rootCaseA2,rootCaseA3};
        
        rootCaseA1.request_status__c  = 'Complete';
        rootCaseA2.request_status__c  = 'Complete';
        rootCaseA3.request_status__c  = 'Denied';
        update new List<Root_Case__c>{rootCaseA1,rootCaseA2,rootCaseA3};
        
        accountCaseA.request_status__c  = 'Complete';
        update accountCaseA;  
        
        Test.stopTest();
    }
    static testmethod void TestRootSync(){
     
        List<Case> lstCase = [select Id from Case];
        
        Case accountCaseA = lstCase[0];
        
        test.startTest();
        
        ApexPages.StandardController standardcontroller = new ApexPages.StandardController(accountCaseA);
        ApexPages.currentPage().getParameters().put('id', accountCaseA.Id);
        
        SyncRootAccountFromInclusionCaseCtrl syncRootAccController= new SyncRootAccountFromInclusionCaseCtrl(standardController);
        
        syncRootAccController.createNewAccountSoInstance('test account', accountCaseA.Id); 
        syncRootAccController.syncAccount(); 
        syncRootAccController.redirectToSyncContact(); 
        syncRootAccController.cancelSyncAccount(); 
        syncRootAccController.redirectToRootCase();
        syncRootAccController.next();
        
        syncRootAccController.getRootCase();
        syncRootAccController.getParentAccount();
        syncRootAccController.getTotalRootCaseCount();
        syncRootAccController.getCurrentRecordCount();
        syncRootAccController.getRootAccountExists();
        
        test.stopTest();
     
    }
}