package org.wmfc.components.input
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.core.Container;
	import mx.managers.PopUpManager;
	
	import org.wmfc.assets.defaultImages.DefaultImages;
	import org.wmfc.components.Image;
	import org.wmfc.components.input.events.PassWordTextBoxEvent;
	
	import spark.components.SkinnableContainer;

	[Event(name="capsLockOn", type="org.wmfc.componentes.input.events.PassWordTextBoxEvent")]
	[Event(name="capsLockOff", type="org.wmfc.componentes.input.events.PassWordTextBoxEvent")]
	
	public class PassWordTextBox extends TextBox
	{
		private var _handleCapsLock:Boolean = true;
		
		public function get handleCapsLock():Boolean
		{
			return _handleCapsLock;
		}
		
		public function set handleCapsLock(value:Boolean):void
		{
			_handleCapsLock = value;
		}
		
		public function PassWordTextBox()
		{
			this.displayAsPassword = true;
			
			this.addEventListener(FocusEvent.FOCUS_IN, on_focusIn);
			this.addEventListener(FocusEvent.FOCUS_OUT, on_focusOut);
			this.addEventListener(KeyboardEvent.KEY_DOWN, on_keyPress);
		}
		
		private function on_focusIn(event:FocusEvent):void {
			dispatchCapsLockHandle(Keyboard.capsLock);
		}
		
		private function on_focusOut(event:FocusEvent):void {
			dispatchCapsLockHandle(false);
		}
		
		private function on_keyPress(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.CAPS_LOCK) {
				dispatchCapsLockHandle(Keyboard.capsLock);
			}else{
				dispatchCapsLockHandle(false);
			}
		}
		
		protected function dispatchCapsLockHandle(show:Boolean):void {
			if(_handleCapsLock) {
				if(show) {
					this.dispatchEvent(new PassWordTextBoxEvent(PassWordTextBoxEvent.CAPS_LOCK_ON));
				}else{
					this.dispatchEvent(new PassWordTextBoxEvent(PassWordTextBoxEvent.CAPS_LOCK_OFF));
				}
			}
		}

	}
}