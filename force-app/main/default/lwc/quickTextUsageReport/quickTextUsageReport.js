import { LightningElement, track, wire } from 'lwc';
import getQuickTextUsageData from '@salesforce/apex/QuickTextUsageController.getQuickTextUsageData';

const pageSize = 10;
const columns = [
    { label: 'User Name', fieldName: 'CreatedById', type: 'text' },
    { label: 'User', type: 'text', 
      typeAttributes: { label: { fieldName: 'CreatedBy' }, target: '_blank' },
      cellAttributes: { iconName: 'utility:user', iconPosition: 'left' }
    },
    { label: 'Message', fieldName: 'Message', type: 'text' },
    // Add more columns as needed
];


export default class QuickTextUsageReport extends LightningElement {
    @track quickTextUsageData;
    @track currentPage = 1;
    @track totalItemCount = 0;
    @track isLoading = false;
    @track country = '';
    @track quickTextMessage = '';

    columns = columns;

    @track isFirstPage = true;
    @track isLastPage = false;
    totalPages = 0;

    handleCountryChange(event) {
        this.country = event.target.value;
    }

    handleQuickTextMessageChange(event) {
        this.quickTextMessage = event.target.value;
    }

    handleSearch() {
        this.currentPage = 1;
        this.loadQuickTextUsageData();
    }

    @wire(getQuickTextUsageData, { pageSize: pageSize, pageNumber: '$currentPage', country: '$country', quickTextMessage: '$quickTextMessage' })
    wiredQuickTextUsageData({ error, data }) {
        console.log(data);
        if (data) {
            console.log(data);
            this.quickTextUsageData = data;
            this.isLoading = false;
            this.totalItemCount = this.quickTextUsageData.length;
            this.showPagination = this.totalItemCount > pageSize;
            this.totalPages = Math.ceil(this.totalItemCount / pageSize);
            this.isFirstPage = this.currentPage === 1;
            this.isLastPage = this.currentPage === this.totalPages;
        } else if (error) {
            console.error('Error fetching quick text usage data:', error);
            this.quickTextUsageData = null;
            this.isLoading = false;
        }
    }

    loadQuickTextUsageData() {
        this.isLoading = true;
    }

    handleNext() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            this.loadQuickTextUsageData();
        }
    }

    handlePrevious() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.loadQuickTextUsageData();
        }
    }
}
