import { LightningElement, wire, track } from 'lwc';
import fetchData  from '@salesforce/apex/PricingProposal.getStatusOfPricingProposalList';   

export default class PricingProposalStatus extends LightningElement {

    @track StatusData=[];
    
    connectedCallback(){
        fetchData()
        .then(result => {
            var conts=result;
            for(var key in conts){
                this.StatusData.push({value:conts[key], key:key}); 
            }
        }).
    
    catch(error => {
        this.error=error;
    })
}
  /*  @wire(fetchData)
    wiredResult(result) { 
        this.StatusData=[];
        this.connectedCallback();
        this.refreshResult=result;
        if (result.data) {
            //mapData = [];
            var conts = result.data;
            for(var key in conts){
                this.StatusData.push({value:conts[key], key:key}); 
            }
        }
    }  */
  
}