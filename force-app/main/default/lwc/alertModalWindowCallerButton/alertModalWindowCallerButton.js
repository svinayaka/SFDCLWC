import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import ALERTMODAL from '@salesforce/messageChannel/AlertMessageChannel__c';

export default class AlertModalWindowCallerButton extends LightningElement {
    @wire(MessageContext) messageContext;

    alertInformation = [
        { normalTxt: 'This is normal text', boldTxt: 'This is bold text', boldLeftTxt: 'Left Bold', normalRightTxt: 'Right Normal',  }
    ]
    handleClick() {
        console.clear();
        console.log(this.messageContext);
        publish(this.messageContext, ALERTMODAL, { alertHeaderInfo: 'This is header', alertBodyInfo: 'This is body', alertVisibleInfo: true });
    }
}