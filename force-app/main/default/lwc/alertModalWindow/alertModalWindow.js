import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext
} from 'lightning/messageService';
import { LightningElement, wire } from 'lwc';

import ALERTMODAL from '@salesforce/messageChannel/AlertMessageChannel__c';

export default class AlertModalWindow extends LightningElement {
    @wire(MessageContext) messageContext;

    isModalOpen = false;
    subscription = null;
    receivedMessage;

    connectedCallback(){ 
        if (!subscribe) return;  
        this.subscription = subscribe( this.messageContext, ALERTMODAL, (message) => { 
            this.onAlertMessage(message); 
        }, {scope: APPLICATION_SCOPE});
    }
    disconnectedCallback(){
        unsubscribe(this.subscription);
        this.subscription = null; 
    }

    onAlertMessage(alertInfo) {
        this.isModalOpen = alertInfo.alertVisibleInfo;
    }

    closeAlertWindow() {
        this.isModalOpen = false;
    }
}