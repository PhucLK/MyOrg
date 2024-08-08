public class AcceptCasesController {

    private Case c;

    public AcceptCasesController(ApexPages.StandardController stdController) {
        this.c = (Case)stdController.getRecord();
        // Some code... changed
    }

    public void massAccept() {
        List<Id> caseIds = ApexPages.currentPage().getParameters().get('caseIds').split(',');
        // Your mass accept logic here using the caseIds
        // For example:
        List<Case> casesToUpdate = [SELECT Id, Status FROM Case WHERE Id IN :caseIds AND Status != 'Accepted'];
        for (Case c : casesToUpdate) {
            c.Status = 'Accepted';
        }
        update casesToUpdate;
    }
}
