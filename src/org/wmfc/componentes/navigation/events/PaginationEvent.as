package org.wmfc.componentes.navigation.events
{
	import flash.events.Event;
	
	public class PaginationEvent extends Event
	{
		public static const GO_TO_PAGE:String = "goToPage";
		
		private var _action:int;

		public function get action():int
		{
			return _action;
		}
		
		public function PaginationEvent(action:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(GO_TO_PAGE, bubbles, cancelable);
			
			_action = action;
		}
	}
}