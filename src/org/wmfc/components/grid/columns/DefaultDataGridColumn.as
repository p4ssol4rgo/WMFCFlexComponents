package org.wmfc.components.grid.columns
{
	import mx.controls.dataGridClasses.DataGridColumn;
	
	public class DefaultDataGridColumn extends DataGridColumn
	{
		protected var _useToFilter:Boolean; 
		public function get useToFilter():Boolean
		{
			return _useToFilter;
		}

		public function set useToFilter(value:Boolean):void
		{
			_useToFilter = value;
		}

		
		protected var _formatString:String;
		public function get formatString():String
		{
			return _formatString;
		}

		public function set formatString(value:String):void
		{
			_formatString = value;
		}
		
		public function DefaultDataGridColumn(columnName:String=null)
		{
			super(columnName);
		}
	}
}