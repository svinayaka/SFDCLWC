import { LightningElement, track, api } from 'lwc';

export default class App extends LightningElement {
   today = new Date();
   date = this.today.getDate();
   year = this.today.getFullYear();
   month = (this.today.getMonth())+1;
   quarter = Math.floor((this.today.getMonth() + 3) / 3);

    getdates(){
          var lastDate,firstDate;
      if (this.quarter == 1){
        lastDate = new Date("03/31/"+this.year);
        firstDate = new Date("01/01/"+this.year);
      } 
      else if (this.quarter == 2){
        lastDate = new Date("06/30/"+this.year);
        firstDate = new Date("04/01/"+this.year);
      } 
      else if (this.quarter == 3){
        lastDate = new Date("09/30/"+this.year);
        firstDate = new Date("07/01/"+this.year);
      } 
       else if (this.quarter == 4){
        lastDate = new Date("12/31/"+this.year);
        firstDate = new Date("10/01/"+this.year);
      }
      return {lastDate,firstDate};
      }
    dates= this.getdates();
    firstDate = this.dates.firstDate;
    lastDate = this.dates.lastDate;    
    thisDate = new Date(this.month+"/"+this.date+"/"+this.year);
    result = this.lastDate - this.thisDate;
    result = (this.result/ (1000*60*60*24)); 

    totalDates = this.lastDate - this.firstDate;
    totalDates = (this.totalDates/ (1000*60*60*24)); 
    percent = (this.result*100)/this.totalDates;
    width = "width:"+this.percent+"%;";
    
}