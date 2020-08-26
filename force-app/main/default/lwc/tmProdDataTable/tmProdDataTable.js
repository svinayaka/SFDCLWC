import { LightningElement,api,track,wire } from 'lwc';
import getProdsList from '@salesforce/apex/TM_PriceMachine_PropList.getListOfProducts';
import fetchProducts from '@salesforce/apex/TM_PriceMachine_PropList.fetchProductsData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import addProducts from '@salesforce/apex/TM_PriceMachine_PropList.addProdsToProp';
import filterProducts from '@salesforce/apex/TM_PriceMachine_PropList.filterProdRcdsByKey';


const columns = [
    { label: 'PRODUCT CODE', fieldName: 'ProductCode' },
    { label: 'PRODUCT NAME', fieldName: 'Name', type: 'text' },
    { label: 'TIER 4', fieldName: 'GE_Tier4_PnL__c', type: 'text' },
    { label: 'PRODUCT L1', fieldName: 'TM_PRODUCT_L1__c', type: 'text' },
    { label: 'PRODUCT L2', fieldName: 'TM_PRODUCT_L2__c', type: 'text' },
    { label: 'PRODUCT L3', fieldName: 'TM_PRODUCT_L3__c', type: 'text' },
    { label: 'PRODUCT L4', fieldName: 'TM_PRODUCT_L4__c', type: 'text' }

];

const columns2 = [
    {type:'button-icon', typeAttributes:{iconName:'utility:delete',name:'delete',iconClass:'slds-icon-text-error'}, fixedWidth:50},
    { label: 'PRODUCT CODE', fieldName: 'ProductCode' },
    { label: 'PRODUCT NAME', fieldName: 'Name', type: 'text' }
    
];

export default class TmProdDataTable extends LightningElement {
    @api getProdId;
    @track data = [];
    @track CompleteOrgData = [];
    //@track CompleteProdsData = [];
    selectedData = [];
    columns = columns;
    columns2 = columns2;
    @track error;
    @api boolData=false;
    @api boolSelectedData = false
    _selectedRecords = [];
    _selectedOrgRecords = [];
    searchKey = '';

    @api searchProdKey;

    //Filter Values
    @api strQuickViewVal;
    @api strTierVal;
    @api strprodL1;
    @api strprodL2;
    @api strprodL3;
    @api strprodL4;
    @api strSearch;
    

    

    @wire(getProdsList)
    wiredProducts({
        error,
        data
    }) {
        //alert('@@@@:::firstpage'+this.firstPage);
        if (data) {
            this.data = data;
            this.CompleteOrgData = data;
            //alert('@@@:::Data::'+JSON.stringify(this.data));
        } else if (error) {
            this.error = error;
        }
    }

    

    


    delSelectedRow(event){
        let newData = JSON.parse(JSON.stringify(this._selectedRecords));
        newData = newData.filter(row => row.ProductCode !== event.detail.row.ProductCode);

        newData.forEach((element,index) => element.uid = index+1);
        this._selectedRecords = newData;

        //CompleteProdsData
        /*
        let newDataWithIds = JSON.parse(JSON.stringify(this.CompleteProdsData));
        newDataWithIds = newDataWithIds.filter(row => row.ProductCode !== event.detail.row.ProductCode);

        newDataWithIds.forEach((element,index) => element.uid = index+1);
        this.CompleteProdsData = newDataWithIds;

        console.log('Remaning records:::'+JSON.stringify(this._selectedRecords));
        console.log('Remaing records with IDs:::::'+JSON.stringify(this.CompleteProdsData));
        */

    }

    findRowIndexById(id) {
        let ret = -1;
        this._selectedRecords.some((row, index) => {
            if (row.id === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }

    

    

    selectedRowHandler(event){ 
        
    }


    onCancelHandler(event){
        const clswindow = new CustomEvent('closewindow', {detail: true});
        this.dispatchEvent(clswindow);
    }
    onNextHandler(event){
        /*const selectedRows  = event.detail.selectedRows;
        
        for ( let i = 0; i < selectedRows.length; i++ ){ 
            if ( !this._selectedRecords.includes(selectedRows[i].Id) ) 
                //this._selectedRecords =[...this._selectedRecords, selectedRows[i]]; 
                this._selectedRecords.push(selectedRows[i]);
                
            }
        console.log('Total Selected Records: '+JSON.stringify(this._selectedRecords));*/
        var el = this.template.querySelector('lightning-datatable');
        console.log(el);
        this._selectedRecords = el.getSelectedRows();
        this.CompleteProdsData = el.getSelectedRows();
        console.log(this._selectedRecords);
        if(this._selectedRecords.length>0){
            this.boolData = true;
            this.boolSelectedData = true;
            const secwindow = new CustomEvent('secondwindow', {detail: true});
            this.dispatchEvent(secwindow);
        }else{
            this.showToast();
        }
        
    }
    onCloseHandler(event){
        const clswindow = new CustomEvent('closewindow', {detail: true});
        this.dispatchEvent(clswindow);
    }
    onSuccessHandler(event){
        //Add products to Price Proposal Rcds lstOfProdRcds
        //alert('Add PRODUCTS:::'); 
        addProducts({
            lstOfProdRcds: this._selectedRecords,
            strRecId:this.getProdId            
            })
            .then(result => {      
                //alert('Success::'+result);     
                this.onCloseHandler(); 
            })
            .catch((error) => {
                this.error = error; 
                //alert('Error::'+this.error);
            });
    }

    showToast() {
        const event = new ShowToastEvent({
            title: 'Select a Record.',
            variant:'warning',
            message: 'Kindly select atleast a Product to proceed.',
        });
        this.dispatchEvent(event);
    }

    @api
    changeQucikView(strStringQuciView){
        this.strQuickViewVal = strStringQuciView;
        //alert('### value passed:::'+this.strQuickViewVal);
    }
    @api
    changestrTier(strTier){
        this.strTierVal = strTier;
        //alert('### value passed::tier::'+this.strTierVal);
    }
    @api
    changeProdL1(strStringProd1){
        this.strprodL1 = strStringProd1;
        //alert('### value passed::QV::'+this.strprodL1);
    }
    @api
    changeProdL2(strStringProd2){
        this.strprodL2 = strStringProd2;
        //alert('### value passed::P1::'+this.strprodL2);
    }
    @api
    changeProdL3(strStringProd3){
        this.strprodL3 = strStringProd3;
        //alert('### value passed::P3::'+this.strprodL3);
    }
    @api
    changeProdL4(strStringProd4){
        this.strprodL4 = strStringProd4;
        //alert('### value passed::P4::'+this.strprodL4);
    }
    @api
    changeSearch(strSearch){
        this.strSearch = strSearch;
        //alert('### str Search::'+this.strSearch);
    }
    @api
    searchFirstPageRecords(strCheck){
            if ( strCheck ) {  
                fetchProducts({
                    searchKey: this.strSearch,
                    strProd1:this.strprodL1,
                    strProd2:this.strprodL2,
                    strProd3:this.strprodL3,
                    strProd4:this.strprodL4,
                    strTier: this.strTierVal,
                    strQuickview:this.strQuickViewVal
                    })
                    .then(result => {      
                        this.data = result;      
                    })
                    .catch((error) => {
                        this.error = error; 
                    });
            } 
    }

    @api
    resetFristPageData(str){
        if(str === true){
            this.data = this.CompleteOrgData;
            this.strSearch = "All";
            this.strprodL1 = "All";
            this.strprodL2 = "All";
            this.strprodL3 = "All";
            this.strprodL4 = "All";
            this.strQuickViewVal = "All";
            this.strTierVal = "All";

        }
    }

    @api
    searchProdsFilter(str){
        if(str){
            //alert('@@ prod Search:::'+this.searchProdKey);
            //lstOfProdRcds, strSearchKey,_selectedRecords,searchProdKey
            this._selectedOrgRecords = this._selectedRecords;
            filterProducts({
                lstOfProdRcds: this._selectedRecords,
                strSearchKey:this.searchProdKey            
                })
                .then(result => {      
                    //alert('Success::'+result);     
                    this._selectedRecords = result; 
                })
                .catch((error) => {
                    this.error = error; 
                    //alert('Error::'+this.error);
                });
        }
    }

    @api
    resetProdData(str){
        if(str){
            this._selectedRecords =  this._selectedOrgRecords;
        }
    }


        
}