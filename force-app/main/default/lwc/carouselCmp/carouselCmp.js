import { LightningElement } from 'lwc';
import PC_Image from '@salesforce/resourceUrl/PriceMachine_poc2020';
export default class CarouselLWcCmp extends LightningElement {
    training =  PC_Image + '/training.jpg';
    analyzing = PC_Image + '/analyzing.jpg';
    calculate = PC_Image + '/calculate.jpg';
    launchBox = PC_Image + '/launchBox.jpg';
    
    handleClick(){
        window.open(' https://www.salesforce.com');
    }
}