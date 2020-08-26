import { LightningElement, api } from 'lwc';

export default class CustomLookup extends LightningElement {
    @api childObjectApiName = 'Contact'; 
    @api targetFieldApiName = 'AccountId';
    @api fieldLabel = '  ';
    @api disabled = false;
    @api value;
    @api required = false;
    @api placeHolder = 'Search Customer Account';

    handleChange(event) {
        
        const acctRcdselected = new CustomEvent('valueselected', {
            detail: event.detail.value
        });
        this.dispatchEvent(acctRcdselected);
    }

    @api isValid() {
        if (this.required) {
            this.template.querySelector('lightning-input-field').reportValidity();
        }
    }
}