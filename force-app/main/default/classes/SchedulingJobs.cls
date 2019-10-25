public with sharing class SchedulingJobs {
    public SchedulingJobs() {
        DateTime currentDateTime=System.now().addseconds(5);             
        String nextScheduleTime=String.valueof(currentDateTime.second()) +' '+String.valueof(currentDateTime.minute())+' '
        +String.valueof(currentDateTime.hour())+' '+String.valueof(currentDateTime.day())+' '
        +String.valueof(currentDateTime.month())+' ? '+String.valueof(currentDateTime.Year());
       system.schedule('Scheduled at '+System.now().format(), nextScheduleTime, new SendPaymentsFromBillsPayablesJob() );
    }
}
