public class GE_SS_FSProjectLines_Publish {
    public class Rental_Output_Type {
        public String LINE_ID;
        public String RECORD_STATUS;
        public String ERROR_MESSAGE;
        public String Fault_MSG;
        private transient String[] LINE_ID_type_info = new String[]{'LINE_ID','http://www.smax.org/xsd','string','0','1','true'};
        private transient String[] RECORD_STATUS_type_info = new String[]{'RECORD_STATUS','http://www.smax.org/xsd','string','0','1','true'};
        private transient String[] ERROR_MESSAGE_type_info = new String[]{'ERROR_MESSAGE','http://www.smax.org/xsd','string','0','1','true'};
        private transient String[] Fault_MSG_type_info = new String[]{'Fault_MSG','http://www.smax.org/xsd','string','1','1','false'};
        private transient String[] apex_schema_type_info = new String[]{'http://www.smax.org/xsd','true','false'};
        private transient String[] field_order_type_info = new String[]{'LINE_ID','RECORD_STATUS','ERROR_MESSAGE','Fault_MSG'};
    }
    public class RentalFeatureCollectionType {
        public GE_SS_FSProjectLines_Publish.RentalFeatures[] RentalFeatures;
        private transient String[] RentalFeatures_type_info = new String[]{'RentalFeatures','http://www.smax.org/xsd','RentalFeatures','1','-1','false'};
        private transient String[] apex_schema_type_info = new String[]{'http://www.smax.org/xsd','true','false'};
        private transient String[] field_order_type_info = new String[]{'RentalFeatures'};
    }
    public class RentalFeatureResponseCollectionType {
        public GE_SS_FSProjectLines_Publish.Rental_Output_Type[] Rental_Output_Type;
        private transient String[] Rental_Output_Type_type_info = new String[]{'Rental_Output_Type','http://www.smax.org/xsd','Rental_Output_Type','1','-1','false'};
        private transient String[] apex_schema_type_info = new String[]{'http://www.smax.org/xsd','true','false'};
        private transient String[] field_order_type_info = new String[]{'Rental_Output_Type'};
    }
    public class RentalFeatures {
        public String Tool_Condition;
        public String Line_Id;
        public DateTime Date_Tool_Sent;
        public DateTime Date_Tool_Arrives_Back;
        private transient String[] Tool_Condition_type_info = new String[]{'Tool_Condition','http://www.smax.org/xsd','string','0','1','false'};
        private transient String[] Line_Id_type_info = new String[]{'Line_Id','http://www.smax.org/xsd','string','0','1','false'};
        private transient String[] Date_Tool_Sent_type_info = new String[]{'Date_Tool_Sent','http://www.smax.org/xsd','dateTime','1','1','false'};
        private transient String[] Date_Tool_Arrives_Back_type_info = new String[]{'Date_Tool_Arrives_Back','http://www.smax.org/xsd','dateTime','1','1','false'};
        private transient String[] apex_schema_type_info = new String[]{'http://www.smax.org/xsd','true','false'};
        private transient String[] field_order_type_info = new String[]{'Tool_Condition','Line_Id','Date_Tool_Sent','Date_Tool_Arrives_Back'};
    } 
    
    public class Return_RentalLines_BPELProcess_pt {
        // public String endpoint_x = 'https://soa-ogdev.og.ge.com:443/soa-infra/services/SMAX_FS_PASCAL/Return_RentalLinesSVMXReqImpl/return_rentallines_bpelprocess_client_ep';
        public String endpoint_x ;
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private transient String[] ns_map_type_info = new String[]{'http://www.smax.org/xsd','GE_SS_FSProjectLines_Publish'};
        public GE_SS_FSProjectLines_Publish.Rental_Output_Type[] process(GE_SS_FSProjectLines_Publish.RentalFeatures[] RentalFeatures) {
            GE_SS_FSProjectLines_Publish.RentalFeatureCollectionType request_x = new GE_SS_FSProjectLines_Publish.RentalFeatureCollectionType();
            GE_SS_FSProjectLines_Publish.RentalFeatureResponseCollectionType response_x;
            request_x.RentalFeatures = RentalFeatures;
            Map<String, GE_SS_FSProjectLines_Publish.RentalFeatureResponseCollectionType> response_map_x = new Map<String, GE_SS_FSProjectLines_Publish.RentalFeatureResponseCollectionType>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
                this,
                request_x,
                response_map_x,
                new String[]{endpoint_x,
                'process',
                'http://www.smax.org/xsd',
                'RentalFeatureCollection',
                'http://www.smax.org/xsd',
                'outputData',
                'GE_SS_FSProjectLines_Publish.RentalFeatureResponseCollectionType'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.Rental_Output_Type;
        }
    }
}