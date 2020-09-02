public class UtilityListSplit{
    public static List<List<SObject>> spliceListBySize(List<SObject> objs, Integer size){
        List<List<SObject>> resultList = new List<List<SObject>>();
        /*Decimal tempSize = size;
        Decimal listSize = objs.size();*/
        //Integer numberOfChunks = ((listSize / tempSize).round(System.RoundingMode.UP)).intValue();
        Integer numberOfChunks = objs.size() / size;

        for(Integer j = 0; j < numberOfChunks; j++ ){

             List<SObject> someList = new List<SObject>();

            for(Integer i = j * size; i < (j+1) * size; i++){
                someList.add(objs[i]);
            }
            system.debug('some list is '+someList.size());
            resultList.add(someList);
        }

        if(numberOfChunks * size < objs.size()){
            List<SObject> aList = new List<SObject>();

            for(Integer k = numberOfChunks * size ; k < objs.size(); k++){
                aList.add(objs[k]);
            }

            resultList.add(aList);
        }


        return resultList;
    }
}