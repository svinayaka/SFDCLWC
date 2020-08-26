import { LightningElement,api,track,wire } from 'lwc';
import getServicesList from '@salesforce/apex/TM_PriceMachine_PropList.getListOfServices';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import filterServices from '@salesforce/apex/TM_PriceMachine_PropList.filterServiceRcdsByKey';
import addServices from '@salesforce/apex/TM_PriceMachine_PropList.addServicesToProp';

const columns = [
    { label: 'SERVICE CODE', fieldName: 'Name' },
    { label: 'SERVICE NAME', fieldName: 'TM_Service_Name__c', type: 'text' }
];
const columns2 = [
    {type:'button-icon', typeAttributes:{iconName:'utility:delete',name:'delete',iconClass:'slds-icon-text-error'}, fixedWidth:50},
    { label: 'SERVICE CODE', fieldName: 'Name' },
    { label: 'SERVICE NAME', fieldName: 'TM_Service_Name__c', type: 'text' }
];



export default class TmServiceDataTable extends LightningElement {
    @track data = [];
    @track error;
    columns = columns;
    columns2 = columns2;
    @api getServiceId;
    _selectedRecords = [];
    _selectedOrgRecords = [];
    @api boolData=false;
    @api boolSelectedData = false;
    @api searchServiceKey;


    @wire(getServicesList)
    getServicesList({
        error,
        data
    }) {
        if (data) {
            this.data = data;            
        } else if (error) {
            this.error = error;
        }
    }


    onCloseHandler(event){
        const clswindow = new CustomEvent('closewindow', {detail: true});
        this.dispatchEvent(clswindow);
    }

    onCancelHandler(event){
        const clswindow = new CustomEvent('closewindow', {detail: true});
        this.dispatchEvent(clswindow);
    }

    onNextHandler(event){
        var el = this.template.querySelector('lightning-datatable');
        console.log(el);
        this._selectedRecords = el.getSelectedRows();
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

    showToast() {
        const event = new ShowToastEvent({
            title: 'Select a Record.',
            variant:'warning',
            message: 'Kindly select atleast a Service to proceed.',
        });
        this.dispatchEvent(event);
    }

    delSelectedRow(event){
        let newData = JSON.parse(JSON.stringify(this._selectedRecords));
        newData = newData.filter(row => row.Name !== event.detail.row.Name);

        newData.forEach((element,index) => element.uid = index+1);
        this._selectedRecords = newData;
        console.log('Remaning records:::'+JSON.stringify(this._selectedRecords));        
    }

    @api
    resetProdData(str){
        if(str){
            this._selectedRecords =  this._selectedOrgRecords;
        }
    }

    @api
    searchServicesFilter(str){
        alert('HERE::::');
        if(str){
            alert('@@:::str'+str);
            alert('@@key:::'+this.searchServiceKey);
            this._selectedOrgRecords = this._selectedRecords;
            filterServices({
                lstOfServiceRcds: this._selectedRecords,
                strSearchKey:this.searchServiceKey            
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
    
    onSuccessHandler(event){        
        addServices({
            lstOfServiceRcds: this._selectedRecords,
            strRecId:this.getServiceId            
            })
            .then(result => {      
                this.onCloseHandler(); 
            })
            .catch((error) => {
                this.error = error; 
                //alert('Error::'+this.error);
            });
    }

}