import { LightningElement,track ,wire,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getPricingProposalList from '@salesforce/apex/PricingProposal.getRecentViewedPricingProposalList';

export default class SampledataLwc extends NavigationMixin(LightningElement) {
@wire(getPricingProposalList) pplist;  
@track getRecentlyViewedPPList=[];
@api recordId;
connectedCallback(){
    getPricingProposalList()
    .then(result => { 
        
        let i;
            for (i = 0; i < result.length; i++) {
                
                this.getRecentlyViewedPPList.push(result[i]);
                
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