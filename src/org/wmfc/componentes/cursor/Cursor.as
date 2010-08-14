package org.wmfc.componentes.cursor
{
	import flash.display.DisplayObject;
	
	import mx.managers.CursorManager;

	public class Cursor
	{
		public static function setBusyCursor(message:String="", tipo:int=0, owner:DisplayObject=null):void {
			CursorManager.setBusyCursor();
		}
		
		public static function removeBusyCursor():void {
			CursorManager.removeBusyCursor();
		}
		
		public static function removeAllCursors():void {
			CursorManager.removeAllCursors();
		}
	}
}