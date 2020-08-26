/* eslint-disable no-alert */
import { LightningElement,track } from 'lwc';
import getAccountList from '@salesforce/apex/AccountClass.getAccountList';

export default class Searchcmpdata extends LightningElement {
    @track Name=[];
    connectedCallback(){
        getAccountList()
        .then(result => {
         
           let i;
                for (i = 0; i < result.length; i++) {
                   
                    this.Name.push(result[i].Name);
                   
                }
           
        }).
        catch(error => {
            this.error=error;
        })
    }
}