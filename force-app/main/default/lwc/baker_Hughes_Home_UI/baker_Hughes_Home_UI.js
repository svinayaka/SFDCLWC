import { LightningElement,api, wire, track } from 'lwc';
import getOppList from '@salesforce/apex/OpportunityCtrl.getOppList';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import Amount_FIELD from '@salesforce/schema/Opportunity.Amount';
import ID_FIELD from '@salesforce/schema/Opportunity.Id';
import getMyTeamReqularOpptyList from '@salesforce/apex/OpportunityCtrl.getMyTeamReqularOpptyList';
import getMyTeamRevenueOpptyList from '@salesforce/apex/OpportunityCtrl.getMyTeamRevenueOpptyList';
import { NavigationMixin } from 'lightning/navigation';

import { createRecord } from 'lightning/uiRecordApi';
import GetTaskRecords from '@salesforce/apex/OpportunityCtrl.GetTaskRecords';
import saveTask from '@salesforce/apex/OpportunityCtrl.saveTaskRecord';

import task_Object from '@salesforce/schema/Task';
import Task_Assigned_To from '@salesforce/schema/Task.OwnerId';
import Task_Status from '@salesforce/schema/Task.Status';
import Task_Priority from '@salesforce/schema/Task.Priority';
import Task_Due_Date from '@salesforce/schema/Task.ActivityDate';
import Task_Type from '@salesforce/schema/Task.Type';
import Task_Related_to_Account from '@salesforce/schema/Task.WhatId';
import Task_Subject from '@salesforce/schema/Task.Subject';
import Task_Comments from '@salesforce/schema/Task.Description';
import Task_RecordTypeId from '@salesforce/schema/Task.RecordTypeId';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import User_Object from '@salesforce/schema/User';
import User_Name from '@salesforce/schema/User.Name';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getUserNames from '@salesforce/apex/OpportunityCtrl.getUserNames';
import getPicklistVal from '@salesforce/apex/OpportunityCtrl.getPicklistVal';
import getTaskList from '@salesforce/apex/OpportunityCtrl.getTaskList';

export default class Baker_Hughes_Home_UI extends NavigationMixin( LightningElement ) {

    @track bShowModal = false;
    @track error;
    @track draftValues = [];
    @track value;
    @api recId;
    @track draftTaksValues = [];

    //@api Task_Status;
    
    // this object have record information
    @track taskRecord = {
            
        OwnerId : Task_Assigned_To,
        Status : Task_Status,
        Priority : Task_Priority,
        ActivityDate : Task_Due_Date,
        Type : Task_Type,
        WhatId : Task_Related_to_Account,
        Subject: Task_Subject,
        Description : Task_Comments,
        recordType : Task_RecordTypeId
    };
    
    
    @wire(getObjectInfo, { objectApiName: task_Object })
    objectInfo;

    @wire(getObjectInfo, { objectApiName: User_Object })
    objectInfoUsr;

    @wire(getOppList)
    opportunity;

    @wire(getMyTeamReqularOpptyList)
    myTeamReqularOpptyList;

    @wire(getMyTeamRevenueOpptyList)
    myTeamRevenueOpptyList

    

    data = [];
    
    actions = [
       // { label: 'View', name: 'view' },
       // { label: 'Edit', name: 'edit' },
        { label: 'Activity', name: 'activity' },
    ];
    
    @track columns = [   
        {
            type:'action',
            typeAttributes:{rowActions:this.actions},
        },
        {label: 'OPPORTUNITY NAME',fieldName: 'Name',type: 'text',sortable: true,editable: true,initialWidth: 150},
        {label: 'OPPORTUNITY NUMBER',fieldName: 'opportunity_number_ge_og__c',type: 'text',sortable: true,editable: true,initialWidth: 150},
        {label: 'PRIMARY SALES',fieldName: 'Name',OwnerId: 'text',sortable: true,editable: true,initialWidth: 130},
        {label: 'ROLES',fieldName: 'RolesField',type: 'text',sortable: true,editable: true,initialWidth: 100},
        {label: 'ACCOUNT ID',fieldName: 'AccountId',type: 'text',sortable: true,editable: true,initialWidth: 130},
        {label: 'TIER 2',fieldName: 'Ntier_2_ge_og__came',type: 'text',sortable: true,editable: true,initialWidth: 120},
        {label: 'PRIMARY TIER 3',fieldName: 'tier_3_ge_og__c',type: 'text',sortable: true,editable: true,initialWidth: 130},
        {label: 'PRIMARY TIER 4',fieldName: 'tier_4_ge_og__c',type: 'text',sortable: true,editable: true,initialWidth: 130},
        {label: 'STAGE',fieldName: 'StageName',type: 'text',sortable: true,editable: true,initialWidth: 100},
        {label: 'FORECAST',fieldName: 'ForecastCategoryName',type: 'text',sortable: true,editable: true,initialWidth: 110},
        {label: 'EOD',fieldName: 'CloseDate',type: 'text',sortable: true,editable: true,initialWidth: 100},
        {label: 'AMOUNT',fieldName: 'amount_ge_og__c',type: 'text',sortable: true,editable: true,initialWidth: 100},
        {label: 'SUB REGION',fieldName: 'sub_region_ge_og__c',type: 'text',sortable: true,editable: true,initialWidth: 130},
        {label: 'HAS MMI DEMAND',fieldName: 'Has_MMI_Demand_ge_og__c',type: 'text',sortable: true,editable: true,initialWidth: 150},
        {label: 'MUST WIN',fieldName: 'Must_Win_ge_og__c',type: 'text',sortable: true,editable: true,initialWidth: 110},
        {label: 'DEAL PATH',fieldName: 'deal_path_ge_og__c',type: 'text',sortable: true,editable: true,initialWidth: 110},
        {label: 'LAST MODIFIED DATE',fieldName: 'LastModifiedDate',type: 'text',sortable: true,editable: true,initialWidth: 150},
        
    ];

    @track taskColumns = [   
        
        {label: 'SUBJECT',fieldName: 'Subject',type: 'text',sortable: true,editable: true,initialWidth: 200},
        {label: 'Status',fieldName: 'Status',type: 'text',sortable: true,editable: true,initialWidth: 150},
        {label: 'Priority',fieldName: 'Priority',Priority: 'text',sortable: true,editable: true,initialWidth: 130},
        {label: 'Type',fieldName: 'Type',type: 'text',sortable: true,editable: true,initialWidth: 100},
        {label: 'Activity Date',fieldName: 'ActivityDate',type: 'text',sortable: true,editable: true,initialWidth: 130},
        {label: 'Assinged To',fieldName: 'OwnerId',type: 'text',sortable: true,editable: true,initialWidth: 200},
        
        
    ];

    handleRowAction( event ) {

        const actionName = event.detail.action.name;
        window.console.log('actionName ====> ' + actionName);
        const row = event.detail.row;
        window.console.log('row ====> ' + row);
        window.console.log('row Id ====> ' + row.Id);
        switch ( actionName ) {
            case 'view':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: row.Id,
                        actionName: 'view'
                    }
                });
                break;
            case 'edit':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: row.Id,
                        objectApiName: 'Opportunity',
                        actionName: 'edit'
                    }
                });
                break;
                
                case 'activity':
                    
                    window.console.log('Activity data ====> ' + row);
                    //fields[Task_Related_to_Account.fieldApiName] = row.Id;
                    window.console.log('row id ====> ' + row.Id);
                    this.recId=row.Id;
                    this.createTask(row);
                    //openModal(row);
                break;
            default:
        }
    }

    handleSave(event) {

        const fields = {};
        fields[ID_FIELD.fieldApiName] = event.detail.draftValues[0].Id;
        fields[NAME_FIELD.fieldApiName] = event.detail.draftValues[0].Name;
        fields[Amount_FIELD.fieldApiName] = event.detail.draftValues[0].Amount;

        const recordInput = {fields};

        updateRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Opportunity updated',
                    variant: 'success'
                })
            );
            // Clear all draft values
            this.draftValues = [];

            // Display fresh data in the datatable
            return refreshApex(this.opportunity);
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    } 

    createTask(currentRow) {
        
        window.console.log('currentRow ==createTask()==> ' + currentRow);
        window.console.log('currentRow Id ==createTask()==> ' + currentRow.Id);
        //fields[Task_Related_to_Account.fieldApiName] = this.currentRow.Id;
        this.handleLoad();
        this.handlePickVal();
        this.bShowModal = true;        

        //openModal(currentRow);
       
        /*const fields = {};
        fields[TASK_ID_FIELD.fieldApiName] = this.Id;
        const recordInput = { apiName: TASK_OBJECT.objectApiName, fields };
        window.console.log('recordInput ====> ' + recordInput);
        */

        /*createRecord(recordInput)
            .then(task => {
                this.taskId = task.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Task created',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });*/
    }

    /* javaScipt functions start */ 
    openModal(currentRow) {    
        // to open modal window set 'bShowModal' tarck value as true
        window.console.log('currentRow === from OpenModel===> ' + currentRow);
        this.bShowModal = true;
        this.record = currentRow;
        window.console.log('record === from OpenModel===> ' + record);
    }
 
    closeModal() {    
        // to close modal window set 'bShowModal' tarck value as false
        this.bShowModal = false;
    }
    /* javaScipt functions end */  
    
    
    handleOwnerIdChange(event) {
        this.taskRecord.OwnerId = event.target.value;
        //this.taskRecord.OwnerId = '0056s000000MKhgAAG';
        window.console.log('OwnerId ==> '+this.taskRecord.OwnerId);
    }
	
	handleStatusChange(event) {
        this.taskRecord.Status = event.target.value;
        window.console.log('Status ==> '+this.taskRecord.Status);
    }
	
	handlePriorityChange(event) {
        this.taskRecord.Priority = event.target.value;
        window.console.log('Priority ==> '+this.taskRecord.Priority);
    }
	
	handleActivityDateChange(event) {
        this.taskRecord.ActivityDate = new Date(event.target.value);
        window.console.log('ActivityDate ==> '+this.taskRecord.ActivityDate);
        //this.taskRecord.OwnerId = '0056s000000MKhgAAG';
        //window.console.log('OwnerId ==> '+this.taskRecord.OwnerId);
        this.taskRecord.WhatId = this.recId;
        window.console.log('WhatId ==> '+this.taskRecord.WhatId);
        this.taskRecord.recordType = '01212000000oGZQ';
        window.console.log('recordTypeId ==> '+this.taskRecord.recordType);
    }
	
	handleTypeChange(event) {
        this.taskRecord.Type = event.target.value;
        window.console.log('Type ==> '+this.taskRecord.Type);
    }
	
	handleWhatIdChange(event) {
       /* this.taskRecord.WhatId = event.target.value;
        window.console.log('WhatId ==> '+this.taskRecord.WhatId);
        this.recId = event.target.value;*/
        this.taskRecord.WhatId = this.recId;
        window.console.log('WhatId ==> '+this.taskRecord.WhatId);

        window.console.log('recId ==> '+this.recId);
    }
	
	handleSubjectChange(event) {
        this.taskRecord.Subject = event.target.value;
        window.console.log('Subject ==> '+this.taskRecord.Subject);
    }
	
	handleDescriptionChange(event) {
        this.taskRecord.Description = event.target.value;
        window.console.log('Description ==> '+this.taskRecord.Description);
    }
	
    handleTaskSave() {
        window.console.log('this.taskRecord ==save==> '+this.taskRecord);
        saveTask({objTask: this.taskRecord})
        .then(result => {
            // Clear the user enter values
            this.taskRecord = {};

            window.console.log('result ******===> '+result);
            // Show success messsage
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success!!',
                message: 'Task Created Successfully!!',
                variant: 'success'
            }),);
            
        })
        /*.catch(error => {
            this.error = error.message;
        });*/

        .catch(error => {
            window.console.log('error ===> '+error);
            window.console.log('error message ===> '+error.body.message);

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        });
    }


    
    @wire(getTaskList, { recdId: '$recId' })
    taskList;
//({recdId: this.recId});
   @wire(getPicklistValues, { recordTypeId: '01212000000oGZQ', fieldApiName: Task_Status})
    StatusPicklistValues;

    @wire(getPicklistValues, { recordTypeId: '01212000000oGZQ', fieldApiName: Task_Priority})
    PriorityPicklistValues;

   // @wire(getPicklistValues, { recordTypeId: '012A0000000npxtIAA', fieldApiName: Task_Subject})
   // SubjectPicklistValues;

   /// @wire(getPicklistValues, { recordTypeId: '01212000000oGZQ', fieldApiName: Task_Assigned_To})
    //AssignedToPicklistValues;

    @wire(getPicklistValues, { recordTypeId: '01212000000oGZQ', fieldApiName: Task_Type})
    TypePicklistValues;

    @wire(getPicklistValues, { recordTypeId: '01212000000oGZQ', fieldApiName: Task_Related_to_Account})
    RelatedToAcctPicklistValues;

   // @wire(getRecord, { recordId: '$uId', fields: [User_Name]})
   // UserNamePicklistValues;
       
    /*
    @api recordId;
    @track selectedOption; 
    @track options;

    @wire(getRecord, { recordId: '$recordId', fields})
    user({error, data}) {
        if (data) {
            let nameValue = getFieldValue(data, User_Name);

            if (!this.options) {
                this.options = [{label:nameValue, value:nameValue}];
            }

            let nameIsValid = options.some(function(item) {
                return item.value === nameValue;
            }, this);

            if (nameIsValid) {
                this.selectedOption = nameValue;
            }
        } else if (error) {
            console.log(error);
        }
        console.log('option===>'+options);
    } */
    

    //var statusPickVal = this.StatusPicklistValues.data.values;


   /* @wire(getPicklistValues, { recordTypeId: '$objectInfo.data', fieldApiName: Task_Status})
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: Task_Priority})
    PriorityPicklistValues;

    StatusPicklistValues;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data', fieldApiName: Task_Priority})
    PriorityPicklistValues;*/

    handleChange(event) {
        this.value = event.detail.value;
        window.console("this.value====>"+this.value);
    }

    @api options = [];
    // pick list label
    @track picklistlabel;
    @track users;
   /* @wire(getUserNames)    
    userNames({ error, data }) {
        if (data) {
            this.users = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.users = undefined;
        }
        console.log('users====>'+users)
    }*/

    
    @api subjectOptions = [];
    handlePickVal() {
        console.log('in handlePickVal');
        getPicklistVal()
            .then(data => {
                console.log('data====>'+data);
                let pickValOptions = [{ label: '--None--', value: '--None--'}];

                // Picklist values
                data.forEach(key => {
                    pickValOptions.push({
                        label: key.label,
                        value: key.value
                    })
                    //console.log('pickValOptions==***==>'+pickValOptions);
                });

                this.subjectOptions = pickValOptions;
                //console.log('this.subjectOptions====>'+this.subjectOptions);
            })
            .catch(error => {
                this.error = error;
            });
           // console.log('this.subjectOptions====>'+this.subjectOptions);
           
    }
    

    handleLoad() {
        getUserNames()
            .then(data => {
                let picklistOptions = [{ label: '--None--', value: '--None--'}];
    
                // Picklist values
                data.forEach(key => {
                    picklistOptions.push({
                        label: key.Name,
                        value: key.Id
                    })
                    //console.log('picklistOptions====>'+picklistOptions);
                });
    
                this.options = picklistOptions;
                //console.log('this.options====>'+this.options);
            })
            .catch(error => {
                this.error = error;
            });
            //console.log('this.options====>'+this.options);
    }

/*
    userNames({error, result}) {
            console.log('result====>'+result);
            if (result) {
    
                let picklistOptions = [{ label: '--None--', value: '--None--'}];
    
                // Picklist values
                data.values.forEach(key => {
                    picklistOptions.push({
                        label: key.label, 
                        value: key.value
                    })
                });
    
                this.options = picklistOptions;
                console.log('this.options====>'+this.options);
            } else if (error) {
                this.error = JSON.stringify(error);
            }
    }*/





}