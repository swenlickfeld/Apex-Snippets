public with sharing class CreateAccounts {
    public CreateAccounts() {
        c21pay__Client_Bank_Account__c cba  = [SELECT Id FROM c21pay__Client_Bank_Account__c WHERE Name = 'ACH Connect'];
        AcctSeed__GL_Account__c glacc = [SELECT Id FROM AcctSeed__GL_Account__c WHERE Name = 'Default Bank'];
        AcctSeed__Ledger__c ledger = [SELECT Id FROM AcctSeed__Ledger__c WHERE Name = 'Actual 1'];
        List<Account> aList = new List<Account>();
        List<c21pay__Customer_Account__c> caList = new List<c21pay__Customer_Account__c>();
        Integer n = 5;
        do {
            Account a = new Account();
            a.Name = 'Account Number' + n;
            a.BillingState = 'FL';
            a.BillingCity = 'Hollywood';
            a.BillingPostalCode = '33021';
            a.BillingCountry = 'US';
            a.BillingStreet = '42 S 31 Ave Suite 9';
            a.ShippingCity = a.BillingCity;
            a.ShippingCountry = a.BillingCountry;
            a.ShippingState = a.BillingState;
            a.ShippingPostalCode = a.BillingPostalCode;
            a.ShippingStreet = a.BillingStreet;
            a.c21payas__Use_ACH_Connect__c = true;
            a.c21payas__Bank_Account__c = glacc.Id;
            a.c21pay__Debit_Bank_Account__c = cba.Id;
            a.c21pay__Credit_Bank_Account__c = cba.Id;
            a.c21payas__Ledger__c = ledger.Id;
            //a.c21payas__Group_Payables__c = true;
            //a.c21payas__Group_Billings__c = true;
            aList.add(a);
            n--;
        } while (n > 0);
        insert aList;
        Integer acnum = 1010318;
        for (Account a : aList){
            c21pay__Customer_Account__c ca = new c21pay__Customer_Account__c();
            ca.c21pay__Account__c = a.Id;
            ca.c21pay__Routing_Number__c = '063100277';
            ca.c21pay__Account_Number__c = String.valueOf(acnum);
            ca.c21pay__Payment_Type__c = 'ACH';
            ca.c21pay__Status__c = 'Pending';
            ca.c21pay__Is_Default__c = true;
            ca.c21pay__Account_Type__c = 'Checking';
            ca.c21pay__Entry_Class__c = 'CCD - Corporate Credit or Debit';
            caList.add(ca);
            acnum ++;
        }
        insert caList;
        //Change For demo - Swen 1
    }
}
