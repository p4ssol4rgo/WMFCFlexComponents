package org.wmfc.components.grid.columns
{
	import org.wmfc.utils.amf.types.DateTimeBase;
	import org.wmfc.utils.amf.types.IDateTime;
	import org.wmfc.utils.formatters.DateTimeFormatter;

	public class DateTimeDataGridColumn extends DefaultDataGridColumn
	{
		public function DateTimeDataGridColumn(columnName:String=null)
		{
			super(columnName);
			
			_formatString = DateTimeFormatter.defaultDateFormat;
			
			this.labelFunction = formatDateTime;
		}
		
		protected function formatDateTime(row:Object, column:DateTimeDataGridColumn):String {
			var val:Date;
			
			if(row[column.dataField] is IDateTime) {
				val = DateTimeBase.getDate(row[column.dataField] as IDateTime);
			}else{
				val = row[column.dataField] as Date; 
			}
			
			return DateTimeFormatter.format(val, _formatString);
		}
	}
}