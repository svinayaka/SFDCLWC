import { LightningElement,api,track } from 'lwc';

export default class TmAddServicesLwc extends LightningElement {
    @api recordId;
    @api firstPage=false;
    @api secondPage=false;
    @track searchServiceVal;
    ProdSearch = false;

    //Shift to second Page view
    selectedRecords(event){
        if(event.detail){
            //alert('YES::');
            this.secondPage = true;
            this.firstPage = true;
        }
    }

    closeHandler(event){
        if(event.detail){
        const closeQA = new CustomEvent('close');
        this.dispatchEvent(closeQA);
        }
    }

    
    onChangeOfserviceSearch(event){
        clearTimeout(this.timeoutId);
        this.timeoutId = setTimeout(this.doAction.bind(this, event.target), 500);
    }
    doAction(target) {
        this.searchServiceVal = target.value;
        console.log('@@:::'+this.searchServiceVal.length);
        this.ProdSearch = true;
        if(this.searchServiceVal.length == 0){
            this.template.querySelector('c-tm-service-data-table').resetProdData(true);
            this.ProdSearch = false;
        }
    }

    onClickOfSearchServiceRcds(){
        if(this.ProdSearch){
            this.template.querySelector('c-tm-service-data-table').searchServicesFilter(true);
        }
    }
    
}