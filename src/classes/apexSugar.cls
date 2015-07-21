global virtual class apexSugar {
	global static map<String,contextCounter> contextsByObject = new map<String,contextCounter>();
	global static contextCounter context = new contextCounter();
	global static final Boolean squelchErrors=  false;
	public void dispatch() 
	{ 
	 	try{

	 		if(trigger.isAfter && trigger.isInsert){
	 			context.afterInsertFires++;
				afterInsert();
			}
			if(trigger.isBefore && trigger.isInsert){
				context.beforeInsertFires++;
				beforeInsert();
			}
			if(trigger.isAfter && trigger.isUpdate){
				context.afterUpdateFires++;
				afterUpdate();
			}
			if(trigger.isBefore && trigger.isUpdate){
				context.beforeUpdateFires++;
				beforeUpdate();
			}
			if(trigger.isAfter && trigger.isDelete){
				context.afterDeleteFires++;
				afterDelete();
			}
			if(trigger.isBefore && trigger.isDelete){
				context.beforeDeleteFires++;
				beforeDelete();
			}
			if(trigger.isAfter && trigger.isUndelete){
				context.afterUndeleteFires++;
				afterUndelete();
			}
			system.debug(context);
	 	}
	 	catch(Exception e)
	 	{
	 		new as_except(e);
	 		if(!squelchErrors){
	 			throw e;
	 		}
	 	} 
	}
	

	public virtual void beforeInsert(){}
	public virtual void afterInsert(){}
	public virtual void afterUpdate(){}
	public virtual void beforeUpdate(){}
	public virtual void afterDelete(){}
	public virtual void beforeDelete(){}
	public virtual void afterUndelete(){}

	public class contextCounter
	{
		String objectName;
		public Integer afterInsertFires = 0;
		public Integer beforeInsertFires = 0;
		public Integer afterUpdateFires = 0;
		Integer beforeUpdateFires = 0;
		Integer afterDeleteFires = 0;
		Integer beforeDeleteFires = 0;
		Integer afterUndeleteFires = 0;
		contextCounter()
		{
			if(trigger.new != null && !trigger.new.isempty())
			{
				objectName = trigger.new[0].getSobjectType().getDescribe().getName();
			}
			else if(trigger.old!=null && !trigger.old.isempty())
			{
				objectName = trigger.old[0].getSobjectType().getDescribe().getName();
			}
		}
	}
	global class as_except
	{
		System.Exception e;

		public as_except(System.Exception e) 
		{
			this.e = e;
	        
	        if(true)
	        {
	        	mkFriendly(e);
	        }
		}
	    public void mkFriendly(System.Exception e)
	    {
	        system.debug('( '+e.getTypeName()+' at lineNumber: '+ e.getLineNumber()+')');
	        system.debug('message: ' + e.getMessage());
	        system.debug('stackTrace: ' + e.getStackTraceString());
	    }
	}
}