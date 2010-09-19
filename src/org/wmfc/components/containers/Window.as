package org.wmfc.components.containers
{
	import flash.display.DisplayObject;
	
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;
	
	import spark.components.Application;
	import spark.components.TitleWindow;
	
	public class Window extends TitleWindow
	{
		public function Window()
		{
			super();
			
			this.addEventListener(CloseEvent.CLOSE, on_CloseButtonClick);
		}
		
		protected function on_CloseButtonClick(event:CloseEvent):void {
			closeWindow();
		}
		
		public function show(modal:Boolean=false, center:Boolean=true, owner:DisplayObject=null):void {
			
			if(owner == null){
				owner = FlexGlobals.topLevelApplication as DisplayObject;
			}
			
			PopUpManager.addPopUp(this, owner, modal);
			
			if(center) {
				PopUpManager.centerPopUp(this);
			}
		}
		
		public function closeWindow():void {
			PopUpManager.removePopUp(this);
		}
	}
}