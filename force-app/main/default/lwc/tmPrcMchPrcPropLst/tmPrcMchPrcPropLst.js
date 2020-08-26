import { LightningElement,wire,track} from 'lwc';
import fatchPickListValue from '@salesforce/apex/TM_PriceMachine_PropList.fatchPickListValue';
import getAccountList from '@salesforce/apex/TM_PriceMachine_PropList.getPriceProposalList';

const actions = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' },
];

const actions1 = [
    { label: 'Clone', name: 'clone_details' },
    { label: 'Share', name: 'share' },
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


export default class TmPrcMchPrcPropLst extends LightningElement {
    @track data = [];
    columns = columns;
    record = {};
    @wire(fatchPickListValue, {objInfo: {'sobjectType' : 'TM_Price_Proposal__c'},
                            picklistFieldApi: 'TM_Profitability_Status__c'}) propStatus;
    
    onChngTimeFrameHndlr(event){
        
        alert(event.target.value);
    }

    onChngStatusHndlr(event){
        alert(event.target.value);
    }

    //New check
    @track error;
    
    @wire(getAccountList)
    wiredAccounts({
        error,
        data
    }) {
        if (data) {
            this.data = data;
            this.template.querySelector('c-tm-pmpp-data-table').getProposalDate(this.data);
        } else if (error) {
            this.error = error;
        }
    }

    

    

    prcPropRowAction1(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'clone_details':
                alert('CLONE::::LOGIC:::');
                //clone logic
                break;
            case 'share':
                alert('SHARE::::LOGIC:::');
                //share logic
                break;
            default:
        }
    }

    

}