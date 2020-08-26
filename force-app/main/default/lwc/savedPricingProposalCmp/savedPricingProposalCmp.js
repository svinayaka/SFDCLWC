import { LightningElement,track ,wire,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getPricingProposalList from '@salesforce/apex/PricingProposal.getSavedPricingProposalList';
export default class PricingProposalCmp extends  NavigationMixin(LightningElement) {
   
    @track getSavedPPList=[];
    @api recordId;

    connectedCallback(){
        getPricingProposalList()
        .then(result => { 
         
           let i;
                for (i = 0; i < result.length; i++) {
                   
                    this.getSavedPPList.push(result[i]);
                   
                }
           
        }).
        catch(error => {
            this.error=error;
        })
    }
    handleClick(event) { 
       
        event.preventDefault();
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.target.dataset.id,
                objectApiName: 'TM_Price_Proposal__c', 
                actionName: 'view'
            }
        });
    }
}