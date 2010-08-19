package org.wmfc.componentes.input.events
{
	import flash.events.Event;
	
	public class PassWordTextBoxEvent extends Event
	{
		public static const CAPS_LOCK_ON:String = "capsLockOn";
		public static const CAPS_LOCK_OFF:String = "capsLockOff";
		
		public function PassWordTextBoxEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}