public class AttendanceHandler extends apexSugar{
     
    public override void beforeInsert(){
        Attendance__c newOne = (Attendance__c) trigger.new[0];
        Date theDay = newOne.On2__c;  
        //Double error = 1/0;
        list<Attendance__c> formerOnes= [SELECT Id, First_One__c FROM Attendance__c WHERE On2__c = :theDay ORDER BY In_Office_At__c DESC LIMIT 1];
        if(formerOnes.isEmpty())
        {
            newOne.First_One__c=true;
        }
        else
        {
            newOne.First_One__c=false;
        }
    }
    public override void afterInsert()
    {
        if(apexSugar.context.afterInsertFires>1)
        Double error = 1/0;
    }
    //public override void beforeUpdate(){
    //    Attendance__c newOne = (Attendance__c) trigger.new[0];
    //    Date theDay = newOne.On2__c;
    //    list<Attendance__c> formerOnes= [SELECT Id, First_One__c FROM Attendance__c WHERE On2__c = :theDay ORDER BY In_Office_At__c DESC LIMIT 1];
    //    if(formerOnes.isEmpty())
    //    {
    //        newOne.First_One__c=true;
    //    }
    //    else
    //    {
    //        newOne.First_One__c=false;
    //    }
    //}
}