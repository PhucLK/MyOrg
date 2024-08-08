public with sharing class QuickTextUsageController {
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getQuickTextUsageData(Integer pageSize, Integer pageNumber, String country, String quickTextMessage) {
        Integer offset = (pageNumber - 1) * pageSize;
        String query = 'SELECT Id, CreatedById, CreatedBy.Name, CreatedDate, LastModifiedById, LastModifiedDate, SystemModstamp, Channel, Message, Name, OwnerId FROM QuickText WHERE Id <> null';
        
        if (country != null && country != '') {
            query += ' AND CreatedById IN (SELECT Id FROM User WHERE Country__c = :country)';
        }
        if (quickTextMessage != null && quickTextMessage != '') {
            query += ' AND Message = :quickTextMessage';
        }
        
        query += ' LIMIT :pageSize OFFSET :offset';
        
        List<Map<String, Object>> results = new List<Map<String, Object>>();
        for (QuickText qt : Database.query(query)) {
            Map<String, Object> result = new Map<String, Object>();
            result.put('Id', qt.Id);
            result.put('CreatedById', qt.CreatedById);
            result.put('CreatedBy', qt.CreatedBy.Name);
            result.put('CreatedDate', qt.CreatedDate);
            result.put('LastModifiedById', qt.LastModifiedById);
            result.put('LastModifiedDate', qt.LastModifiedDate);
            result.put('SystemModstamp', qt.SystemModstamp);
            result.put('Channel', qt.Channel);
            result.put('Message', qt.Message);
            result.put('Name', qt.Name);
            result.put('OwnerId', qt.OwnerId);
            results.add(result);
        }
        
        return results;
    }
}
