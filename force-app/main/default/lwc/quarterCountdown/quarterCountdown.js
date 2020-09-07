import { LightningElement, track, api } from 'lwc';

export default class App extends LightningElement {
   today = new Date();
   date = this.today.getDate();
   year = this.today.getFullYear();
   month = (this.today.getMonth())+1;
   quarter = Math.floor((this.today.getMonth() + 3) / 3);

    getLastdate(){
          var date2
      if (this.quarter == 1){
        date2 = new Date("03/31/"+this.year);
      } 
      else if (this.quarter == 2){
        date2 = new Date("06/30/"+this.year);
      } 
      else if (this.quarter == 3){
        date2 = new Date("09/30/"+this.year);
      } 
       else if (this.quarter == 4){
        date2 = new Date("12/31/"+this.year);
      }
      return date2;
      }
    date2= this.getLastdate();
    //date2 = new Date("09/30/"+this.year);
    date1 = new Date(this.month+"/"+this.date+"/"+this.year);
    
    result = this.date2 - this.date1;
    result = (this.result/ (1000*60*60*24)); 
       
}