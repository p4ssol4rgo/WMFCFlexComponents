package org.wmfc.componentes.containers
{
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.events.ValidationResultEvent;
	
	import org.wmfc.componentes.input.IValidate;
	
	import spark.components.Group;
	import spark.events.ElementExistenceEvent;
	
	public class ContainerValidator extends Group
	{
		
		protected var ivalidateComponents:ArrayCollection;
		
		public function ContainerValidator()
		{
			super();
			this.addEventListener(ElementExistenceEvent.ELEMENT_ADD, handleChildAdded);
		}
		
		protected function handleChildAdded(event:ElementExistenceEvent):void {
			if(event.element is IValidate)
			{
				if(ivalidateComponents == null)
				{
					ivalidateComponents = new ArrayCollection();
				}
				
				ivalidateComponents.addItem(event.element);
			}
		}
		
/*		public override function addChild(child:DisplayObject):DisplayObject
		{
			
			if(child is IValidate)
			{
				if(ivalidateComponents == null)
				{
					ivalidateComponents = new ArrayCollection();
				}
				
				ivalidateComponents.addItem(child);
			}
			
			return super.addChild(child);
		}*/
		
		public function executeValidation():ValidationResult
		{
			if(ivalidateComponents == null || ivalidateComponents.length == 0) 
			{
				return null;
			}
			
			var result:ValidationResult = new ValidationResult();
			
			for each(var item:IValidate in ivalidateComponents) 
			{
				var itemResult:ValidationResultEvent = item.validate();
				
				if(itemResult == null || itemResult.results == null || 
											itemResult.results.length == 0){
					continue;
				}
				
				var msg:String = itemResult.message;
				
				if(msg != "")
				{
					result.valid = false;
					result.message += (result.message == "" ? "" : "\n") + msg;
				}
			}
			
			return result;
		}
		
	}
}