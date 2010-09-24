package org.wmfc.components.grid.columns
{
	import org.wmfc.utils.formatters.NumericFormatter;

	public class NumericDataGridColumn extends DefaultDataGridColumn
	{
		protected var formatter:NumericFormatter;
		
		protected var _decimalPlaces:int;
		public function get decimalPlaces():int
		{
			return _decimalPlaces;
		}

		public function set decimalPlaces(value:int):void
		{
			_decimalPlaces = value;
		}
		
		protected var _decimalSeparator:String = NumericFormatter.defaultDecimalSeparator;
		public function get decimalSeparator():String
		{
			return _decimalSeparator;
		}

		public function set decimalSeparator(value:String):void
		{
			_decimalSeparator = value;
		}
		
		protected var _thousandSeparator:String = NumericFormatter.defaultThousandSeparator;
		public function get thousandSeparator():String
		{
			return _thousandSeparator;
		}

		public function set thousandSeparator(value:String):void
		{
			_thousandSeparator = value;
		}
		
		[Inspectable(category="General", enumeration="none,up,down,nearest", defaultValue="nearest")]
		protected var _rounding:String = "nearest";
		public function get rounding():String
		{
			return _rounding;
		}

		public function set rounding(value:String):void
		{
			_rounding = value;
		}
		
		public function NumericDataGridColumn(columnName:String=null)
		{
			super(columnName);
			
			this.labelFunction = formatNumber;
		}
		
		protected function formatNumber(row:Object, column:NumericDataGridColumn):String {
			if(formatter == null) {
				formatter = new NumericFormatter();
				formatter.decimalPlaces = _decimalPlaces;
				formatter.decimalSeparator = _decimalSeparator;
				formatter.thousandSeparator = _thousandSeparator;
				formatter.rounding = _rounding; 
			}
			
			return row[column.dataField] == null || isNaN(Number(row[column.dataField])) ? "" 
						: formatter.format(Number(row[column.dataField]));
		}
	}
}