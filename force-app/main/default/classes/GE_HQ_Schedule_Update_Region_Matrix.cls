Global Class GE_HQ_Schedule_Update_Region_Matrix  implements Schedulable {

    // Execute method containing all logic
    Global void execute(SchedulableContext SC) {

        // Creating variable of 'GE_HQ_Update_Region_Matrix' class
        GE_HQ_Update_Region_Matrix UpdateAllRM = new GE_HQ_Update_Region_Matrix ();

        // Passing the newly created variable to 'executebatch' method to call its start method and do the calculations
        Database.executebatch(UpdateAllRM);
    }
}