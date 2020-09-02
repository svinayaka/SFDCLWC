public with sharing class GE_OG_MCS_WOQueueassignment{
    ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    List<Group> grp=[Select id,name from Group where Type='Queue' ];
    
    public void beforeinsertWOQueueassignment(List<SVMXC__Service_Order__c> WorkOrder){
        for(SVMXC__Service_Order__c SO:WorkOrder){
            If(SO.RecordTypeId==Rectype){
                If(SO.GE_OG_MC_Service_Region__c=='Europe'&&SO.GE_OG_MC_Business_Unit__c=='CS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_CS_Europe'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Asia'&&SO.GE_OG_MC_Business_Unit__c=='CS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_CS_Asia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='India'&&SO.GE_OG_MC_Business_Unit__c=='CS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_CS_India'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Latin America'&&SO.GE_OG_MC_Business_Unit__c=='CS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_CS_Latin America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='China'&&SO.GE_OG_MC_Business_Unit__c=='CS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_CS_China'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Middle East Africa'&&SO.GE_OG_MC_Business_Unit__c=='CS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_CS_Middle East Africa'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Australia'&&SO.GE_OG_MC_Business_Unit__c=='CS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_CS_Australia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Canada'&&SO.GE_OG_MC_Business_Unit__c=='CS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_CS_Canada'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                
                If(SO.GE_OG_MC_Service_Region__c=='North America'&&SO.GE_OG_MC_Business_Unit__c=='CS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_CS_North America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                
                
                If(SO.GE_OG_MC_Service_Region__c=='Europe'&&SO.GE_OG_MC_Business_Unit__c=='MS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_MS_Europe'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Asia'&&SO.GE_OG_MC_Business_Unit__c=='MS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_MS_Asia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='India'&&SO.GE_OG_MC_Business_Unit__c=='MS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_MS_India'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Latin America'&&SO.GE_OG_MC_Business_Unit__c=='MS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_MS_Latin America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='China'&&SO.GE_OG_MC_Business_Unit__c=='MS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_MS_China'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Middle East Africa'&&SO.GE_OG_MC_Business_Unit__c=='MS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_MS_Middle East Africa'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Australia'&&SO.GE_OG_MC_Business_Unit__c=='MS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_MS_Australia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Canada'&&SO.GE_OG_MC_Business_Unit__c=='MS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_MS_Canada'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='North America'&&SO.GE_OG_MC_Business_Unit__c=='MS'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_MS_North America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                
                If(SO.GE_OG_MC_Service_Region__c=='Europe'&&SO.GE_OG_MC_Business_Unit__c=='IT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_IT_Europe'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Asia'&&SO.GE_OG_MC_Business_Unit__c=='IT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_IT_Asia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='India'&&SO.GE_OG_MC_Business_Unit__c=='IT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_IT_India'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Latin America'&&SO.GE_OG_MC_Business_Unit__c=='IT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_IT_Latin America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='China'&&SO.GE_OG_MC_Business_Unit__c=='IT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_IT_China'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Middle East Africa'&&SO.GE_OG_MC_Business_Unit__c=='IT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_IT_Middle East Africa'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Australia'&&SO.GE_OG_MC_Business_Unit__c=='IT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_IT_Australia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Canada'&&SO.GE_OG_MC_Business_Unit__c=='IT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_IT_Canada'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='North America'&&SO.GE_OG_MC_Business_Unit__c=='IT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_IT_North America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                
                If(SO.GE_OG_MC_Service_Region__c=='Europe'&&SO.GE_OG_MC_Business_Unit__c=='BN'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_BN_Europe'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Asia'&&SO.GE_OG_MC_Business_Unit__c=='BN'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_BN_Asia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='India'&&SO.GE_OG_MC_Business_Unit__c=='BN'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_BN_India'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Latin America'&&SO.GE_OG_MC_Business_Unit__c=='BN'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_BN_Latin America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='China'&&SO.GE_OG_MC_Business_Unit__c=='BN'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_BN_China'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Middle East Africa'&&SO.GE_OG_MC_Business_Unit__c=='BN'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_BN_Middle East Africa'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Australia'&&SO.GE_OG_MC_Business_Unit__c=='BN'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_BN_Australia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Canada'&&SO.GE_OG_MC_Business_Unit__c=='BN'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_BN_Canada'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='North America'&&SO.GE_OG_MC_Business_Unit__c=='BN'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_BN_North America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                //added by laxmi
                If(SO.GE_OG_MC_Service_Region__c==Null||SO.GE_OG_MC_Business_Unit__c==Null||SO.GE_OG_MC_Service_Region__c==Null&&SO.GE_OG_MC_Business_Unit__c==Null){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MCS'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                //R-18151(Added by Laxmi)
                If(SO.GE_OG_MC_Service_Region__c=='Middle East Africa'&&SO.GE_OG_MC_Business_Unit__c=='F&PT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_FPT_Middle East Africa'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Asia'&&SO.GE_OG_MC_Business_Unit__c=='F&PT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_FPT_Asia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Australia'&&SO.GE_OG_MC_Business_Unit__c=='F&PT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_FPT_Australia'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Canada'&&SO.GE_OG_MC_Business_Unit__c=='F&PT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_FPT_Canada'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='China'&&SO.GE_OG_MC_Business_Unit__c=='F&PT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_FPT_China'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Europe'&&SO.GE_OG_MC_Business_Unit__c=='F&PT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_FPT_Europe'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='India'&&SO.GE_OG_MC_Business_Unit__c=='F&PT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_FPT_India'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='Latin America'&&SO.GE_OG_MC_Business_Unit__c=='F&PT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_FPT_Latin America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }
                If(SO.GE_OG_MC_Service_Region__c=='North America'&&SO.GE_OG_MC_Business_Unit__c=='F&PT'){
                    for(Group g:grp){
                        if(g.name=='GE_OG_MC_FPT_North America'){
                            SO.OwnerID=g.id;
                            System.debug('Owner id'+SO.OwnerID);
                            //Wrk_Order.add(SO);
                        }
                    }
                }       
                
            }
        }
    }
    public void beforeupdateWOQueueassignment(List<SVMXC__Service_Order__c> newWorkOrder,List<SVMXC__Service_Order__c> oldWorkOrder){
        for(SVMXC__Service_Order__c s:newWorkOrder){
            for(SVMXC__Service_Order__c Ser_Ordr:oldWorkOrder){
                If(s.RecordTypeId==Rectype){
                    If(s.GE_OG_MC_Service_Region__c!=Ser_Ordr.GE_OG_MC_Service_Region__c||s.GE_OG_MC_Business_Unit__c!=Ser_Ordr.GE_OG_MC_Business_Unit__c){
                        If(s.GE_OG_MC_Service_Region__c=='Europe'&&s.GE_OG_MC_Business_Unit__c=='CS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_CS_Europe'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Asia'&&s.GE_OG_MC_Business_Unit__c=='CS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_CS_Asia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='India'&&s.GE_OG_MC_Business_Unit__c=='CS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_CS_India'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Latin America'&&s.GE_OG_MC_Business_Unit__c=='CS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_CS_Latin America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='China'&&s.GE_OG_MC_Business_Unit__c=='CS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_CS_China'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Middle East Africa'&&s.GE_OG_MC_Business_Unit__c=='CS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_CS_Middle East Africa'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Australia'&&s.GE_OG_MC_Business_Unit__c=='CS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_CS_Australia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Canada'&&s.GE_OG_MC_Business_Unit__c=='CS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_CS_Canada'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='North America'&&s.GE_OG_MC_Business_Unit__c=='CS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_CS_North America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        
                        If(s.GE_OG_MC_Service_Region__c=='Europe'&&s.GE_OG_MC_Business_Unit__c=='MS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_MS_Europe'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Asia'&&s.GE_OG_MC_Business_Unit__c=='MS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_MS_Asia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='India'&&s.GE_OG_MC_Business_Unit__c=='MS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_MS_India'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Latin America'&&s.GE_OG_MC_Business_Unit__c=='MS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_MS_Latin America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='China'&&s.GE_OG_MC_Business_Unit__c=='MS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_MS_China'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Middle East Africa'&&s.GE_OG_MC_Business_Unit__c=='MS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_MS_Middle East Africa'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Australia'&&s.GE_OG_MC_Business_Unit__c=='MS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_MS_Australia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Canada'&&s.GE_OG_MC_Business_Unit__c=='MS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_MS_Canada'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='North America'&&s.GE_OG_MC_Business_Unit__c=='MS'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_MS_North America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        
                        If(s.GE_OG_MC_Service_Region__c=='Europe'&&s.GE_OG_MC_Business_Unit__c=='IT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_IT_Europe'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Asia'&&s.GE_OG_MC_Business_Unit__c=='IT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_IT_Asia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='India'&&s.GE_OG_MC_Business_Unit__c=='IT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_IT_India'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Latin America'&&s.GE_OG_MC_Business_Unit__c=='IT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_IT_Latin America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='China'&&s.GE_OG_MC_Business_Unit__c=='IT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_IT_China'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Middle East Africa'&&s.GE_OG_MC_Business_Unit__c=='IT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_IT_Middle East Africa'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Australia'&&s.GE_OG_MC_Business_Unit__c=='IT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_IT_Australia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Canada'&&s.GE_OG_MC_Business_Unit__c=='IT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_IT_Canada'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='North America'&&s.GE_OG_MC_Business_Unit__c=='IT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_IT_North America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        
                        If(s.GE_OG_MC_Service_Region__c=='Europe'&&s.GE_OG_MC_Business_Unit__c=='BN'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_BN_Europe'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Asia'&&s.GE_OG_MC_Business_Unit__c=='BN'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_BN_Asia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='India'&&s.GE_OG_MC_Business_Unit__c=='BN'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_BN_India'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Latin America'&&s.GE_OG_MC_Business_Unit__c=='BN'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_BN_Latin America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='China'&&s.GE_OG_MC_Business_Unit__c=='BN'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_BN_China'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Middle East Africa'&&s.GE_OG_MC_Business_Unit__c=='BN'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_BN_Middle East Africa'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Australia'&&s.GE_OG_MC_Business_Unit__c=='BN'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_BN_Australia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Canada'&&s.GE_OG_MC_Business_Unit__c=='BN'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_BN_Canada'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        
                        If(s.GE_OG_MC_Service_Region__c=='North America'&&s.GE_OG_MC_Business_Unit__c=='BN'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_BN_North America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        //R-18151
                        If(s.GE_OG_MC_Service_Region__c=='Middle East Africa'&&s.GE_OG_MC_Business_Unit__c=='F&PT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_FPT_Middle East Africa'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(SO);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Asia'&&s.GE_OG_MC_Business_Unit__c=='F&PT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_FPT_Asia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(SO);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Australia'&&s.GE_OG_MC_Business_Unit__c=='F&PT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_FPT_Australia'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Canada'&&s.GE_OG_MC_Business_Unit__c=='F&PT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_FPT_Canada'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='China'&&s.GE_OG_MC_Business_Unit__c=='F&PT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_FPT_China'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Europe'&&s.GE_OG_MC_Business_Unit__c=='F&PT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_FPT_Europe'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='India'&&s.GE_OG_MC_Business_Unit__c=='F&PT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_FPT_India'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='Latin America'&&s.GE_OG_MC_Business_Unit__c=='F&PT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_FPT_Latin America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                        If(s.GE_OG_MC_Service_Region__c=='North America'&&s.GE_OG_MC_Business_Unit__c=='F&PT'){
                            for(Group g:grp){
                                if(g.name=='GE_OG_MC_FPT_North America'){
                                    s.OwnerID=g.id;
                                    System.debug('Owner id'+s.OwnerID);
                                    //Wrk_Order.add(s);
                                }
                            }
                        }
                    }
                }
                
                
            }
            //added for R-14878
            if(s.RecordTypeId==Rectype && s.SVMXC__Order_Status__c=='Closed'){
                if(s.SVMXC__Closed_By__c==null)
                {
                    s.adderror('Please enter Closed By Value');
                }
                else if(s.GE_OG_SkillMismatchCheck__c==True&&s.GE_OG_MC_Justification_of_skill_MisMatch__c==Null){
                    s.adderror('Please enter Justification of skill mismatch Value');
                }
                s.OwnerID=s.SVMXC__Closed_By__c;
            }
        }
    }
    
}