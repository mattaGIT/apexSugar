trigger AttendanceTrigger on Attendance__c (before insert,after insert,before update,after update,before delete,after delete,after undelete) {
	AttendanceHandler handler = new AttendanceHandler();
	handler.dispatch();  
}