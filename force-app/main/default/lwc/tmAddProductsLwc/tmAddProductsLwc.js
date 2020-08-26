import { LightningElement,wire,track,api } from 'lwc';
import fetchTierPickListValue from '@salesforce/apex/TM_PriceMachine_PropList.fatchPickListValue';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import getProdsList from '@salesforce/apex/TM_PriceMachine_PropList.getListOfProducts';


export default class TmAddProductsLwc extends LightningElement {
    @api recordId;
    @track error;
    @track data = [];
   
    @api firstPage=false;
    @api secondPage=false;
    @track searchVal;
    @track filterChanged = false;
    @track ProdSearch = false;
    searchProdVal;
    
    @wire(fetchTierPickListValue, {objInfo: {'sobjectType' : 'Product2'},
                            picklistFieldApi: 'GE_Tier4_PnL__c'}) tireVals;
    @wire(fetchTierPickListValue, {objInfo: {'sobjectType' : 'Product2'},
                            picklistFieldApi: 'TM_Product_L1__c'}) prod1Vals;
    @wire(fetchTierPickListValue, {objInfo: {'sobjectType' : 'Product2'},
                            picklistFieldApi: 'TM_Product_L2__c'}) prod2Vals;
    @wire(fetchTierPickListValue, {objInfo: {'sobjectType' : 'Product2'},
                            picklistFieldApi: 'TM_Product_L3__c'}) prod3Vals;
    @wire(fetchTierPickListValue, {objInfo: {'sobjectType' : 'Product2'},
                            picklistFieldApi: 'TM_Product_L4__c'}) prod4Vals;
    //FILTERS:::::
    onChngOfQuickViewHandler(event){
        //alert('@@:::'+event.target.value);
        this.template.querySelector('c-tm-prod-data-table').changeQucikView(event.target.value);
        this.filterChanged = true; 
    }
    onChnageOftierHandler(event){
        this.template.querySelector('c-tm-prod-data-table').changestrTier(event.target.value);
        this.filterChanged = true;
    }
    onChnageOfProd1Handler(event){
        this.template.querySelector('c-tm-prod-data-table').changeProdL1(event.target.value);
        this.filterChanged = true;
    }    
    onChnageOfProd2Handler(event){
        this.template.querySelector('c-tm-prod-data-table').changeProdL2(event.target.value);
        this.filterChanged = true;
    }
    onChnageOfProd3Handler(event){
        this.template.querySelector('c-tm-prod-data-table').changeProdL3(event.target.value);
        this.filterChanged = true;
    }
    onChnageOfProd4Handler(event){
        this.template.querySelector('c-tm-prod-data-table').changeProdL4(event.target.value);
        this.filterChanged = true;
    }
    onChangeOfSearchText(event){
        this.searchVal = event.target.value;        
        this.template.querySelector('c-tm-prod-data-table').changeSearch(event.target.value);
        this.filterChanged = true;
        //alert('@@::Leng:::'+this.searchVal);
    }
    
    onClickOfSearchRcds(){
        if(this.filterChanged){
            this.template.querySelector('c-tm-prod-data-table').searchFirstPageRecords(true);
        }else{
            this.showToast();
        }
    }
    onClickOfReset(){        
        //alert('@@:::searchVal:::'+this.searchVal);
        this.filterChanged = false;
        this.template.querySelector('c-tm-prod-data-table').resetFristPageData(true);
        this.searchVal = "";
        this.template.querySelector('[data-id="viewdataid"]').value="All";
        this.template.querySelector('[data-id="tierdataid"]').value="All";
        this.template.querySelector('[data-id="prod1dataid"]').value="All";
        this.template.querySelector('[data-id="prod2dataid"]').value="All";
        this.template.querySelector('[data-id="prod3dataid"]').value="All";
        this.template.querySelector('[data-id="prod4dataid"]').value="All"; 
        const inputFields = this.template.querySelectorAll('lightning-input-field');
        if(inputFields){
            inputFields.forEach(field=>{
                field.reset();
            });
        }
             

    }

    onChangeOfProdSearch(event){
        clearTimeout(this.timeoutId);
        this.timeoutId = setTimeout(this.doAction.bind(this, event.target), 500);
    }
    doAction(target) {
        this.searchProdVal = target.value;
        this.ProdSearch = true;
        //alert('@@@:::Length::'+this.searchProdVal.lenght);
        
        console.log('@@:::'+this.searchProdVal.length);
        if(this.searchProdVal.length == 0){
            //alert('RESET TABLE');
            this.template.querySelector('c-tm-prod-data-table').resetProdData(true);
        }

    }
    onClickOfSearchProdRcds(){
        if(this.ProdSearch){
            this.template.querySelector('c-tm-prod-data-table').searchProdsFilter(true);
        }
    }

    showToast() {
        const event = new ShowToastEvent({
            title: 'Filter selection',
            variant:'warning',
            message: 'Kindly select a value from Filter to search Products.',
        });
        this.dispatchEvent(event);
    }
    
    //from Child component
    closeHandler(event){
        if(event.detail){
        const closeQA = new CustomEvent('close');
        this.dispatchEvent(closeQA);
        }
    }
    selectedRecords(event){
        if(event.detail){
            //alert('YES::');
            this.secondPage = true;
            this.firstPage = true;
        }
    }
    


    
    

}