@istest
public class ByPassValidationProcessBuilder_Test
{
    public static Testmethod  void TestMethod1()
    {
        List<String> input = new List<String>();
        input.add('True');
        ByPassValidationProcessBuilder.bypassPB(input);
        
    }
}