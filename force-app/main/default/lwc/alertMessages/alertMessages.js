import { LightningElement, api, wire } from 'lwc';
import getopp from '@salesforce/apex/OpportunityData.getOpportunities';

export default class AlertMessages extends LightningElement {
    @api warningMsg = 'This is alternate text';
    @api oppId = '';
    @wire(getopp, { oppId: '$oppId' })
    opportunityInfo({ err, data }) {
        debugger;
    };
}