package org.wmfc.components.containers
{
	public class ValidationResult
	{
		private var _valid:Boolean = true;
		private var _message:String = "";

		public function get valid():Boolean
		{
			return _valid;
		}

		public function set valid(value:Boolean):void
		{
			_valid = value;
		}

		public function get message():String
		{
			return _message;
		}

		public function set message(value:String):void
		{
			_message = value;
		}


	}
}