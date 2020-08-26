/* eslint-disable no-alert */
import { LightningElement,track,wire,api } from 'lwc';
import getAccountList from '@salesforce/apex/AccountClass.getAccountList';
import { NavigationMixin } from 'lightning/navigation';

export default class favoriteProductCmp extends NavigationMixin(LightningElement) {

    @api recordId;
    @track productDetails=[];

    connectedCallback(){
        getAccountList()
        .then(result => {
         
           let i;
                for (i = 0; i < result.length; i++) {
                   
                    this.productDetails.push(result[i]);
                    
                    
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
                objectApiName: 'Product2', 
                actionName: 'view'
            }
        });
    }
}