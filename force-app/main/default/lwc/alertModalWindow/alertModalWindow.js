import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext
} from 'lightning/messageService';
import { LightningElement, wire, track } from 'lwc';

import ALERTMODAL from '@salesforce/messageChannel/AlertMessageChannel__c';

export default class AlertModalWindow extends LightningElement {
    @wire(MessageContext) messageContext;

    isModalOpen = false;
    subscription = null;
    receivedMessage;
    @track alertHeadMessage = { title:'', titleInfo:'' };
    @track alertBodyMessageList = []
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
        this.alertBodyMessageList = alertInfo.alertBodyInfo;
        this.alertHeadMessage = alertInfo.alertHeaderInfo;
        this.receivedMessage = alertInfo;
        this.isModalOpen = alertInfo.alertVisibleInfo;
    }
    closeAlertWindow() {
        this.isModalOpen = false;
    }
}