public with sharing class CustomAcceptButtonController {
    private ApexPages.StandardController standardController;

    // Constructor
    public CustomAcceptButtonController(ApexPages.StandardController standardController) {
        this.standardController = standardController;
    }

    // Action method for the Accept button
    public PageReference acceptRecord() {
        Case customObjectRecord = (Case)standardController.getRecord();
        
        // Perform any necessary logic here, e.g., updating fields, setting status, etc.

        // Save the record
        try {
            update customObjectRecord;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Record accepted successfully.'));
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error accepting record: ' + e.getMessage()));
        }

        return null; // Stay on the same page
    }

    // Action method for the Cancel button
    public PageReference cancel() {
        return new ApexPages.StandardController(new Case()).view();
    }
}
