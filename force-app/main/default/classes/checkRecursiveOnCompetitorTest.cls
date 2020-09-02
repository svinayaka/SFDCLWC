@isTest 
private class checkRecursiveOnCompetitorTest{
    static testMethod void TastStartTest() {
    checkRecursiveOnCompetitor.run = false; 
     checkRecursiveOnCompetitor.runOnce();
    }
    static testMethod void TastStartTest1() {
     checkRecursiveOnCompetitor.run = true; 
     checkRecursiveOnCompetitor.runOnce();
    }
     
}