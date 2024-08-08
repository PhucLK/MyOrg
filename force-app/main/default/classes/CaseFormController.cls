public with sharing class CaseFormController {
    @AuraEnabled
    public static Id createCase(String subject, String description, String priority) {
        Case newCase = new Case();
        newCase.Subject = subject;
        newCase.Description = description;
        newCase.Priority = priority;
        insert newCase;
        return newCase.Id;
    }
}
