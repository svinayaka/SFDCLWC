import { LightningElement,track,api } from 'lwc';

const actions = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' },
];
const columns = [
    { label: 'PRICING PROPOSAL NAME', fieldName: 'Name' },
    { label: 'LAST SAVED DATE', fieldName: 'LastModifiedDate', type: 'date' },
    { label: 'CUSTOMER', fieldName: 'Phone', type: 'text' },
    { label: 'AREA', fieldName: 'TM_Area__c', type: 'text' },
    { label: 'DISTRICT', fieldName: 'TM_District__c', type: 'text' },
    { label: 'TOTAL REVENUE', fieldName: 'TM_Total_Revenue__c', type: 'currency' },
    { label: 'DISCOUNT', fieldName: 'TM_Total_Discount_From_List__c', type: 'percent' },
    { label: 'PRICING MODE', fieldName: 'TM_Pricing__c', type: 'text' },
    { label: 'PRODUCTS', fieldName: 'TM_Products__c', type: 'number' },
    { label: 'STATUS', fieldName: 'TM_Profitability_Status__c', type: 'text' },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
    
];





export default class TmPmppDataTable extends LightningElement {
    @track data = [];
    columns = columns;

    @api
    getProposalDate(data){
        //alert('@@@ the data:::'+JSON.stringify(data)); 
        this.data = data;
    }

    prcPropRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.deleteRow(row);
                break;
            case 'show_details':
                //this.showRowDetails(row);
                break;
            default:
        }
    }

    deleteRow(row) {
        const { id } = row;
        const index = this.findRowIndexById(id);
        if (index !== -1) {
            this.data = this.data
                .slice(0, index)
                .concat(this.data.slice(index + 1));
        }
    }

    findRowIndexById(id) {
        let ret = -1;
        this.data.some((row, index) => {
            if (row.id === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }

    
}