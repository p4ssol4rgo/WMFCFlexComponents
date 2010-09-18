package org.wmfc.componentes.input.validators
{
	import mx.events.ValidationResultEvent;
	import mx.validators.DateValidator;
	import mx.validators.ValidationResult;
	
	import org.wmfc.utils.DateUtils;
	import org.wmfc.utils.StringUtils;
	import org.wmfc.utils.formatters.DateTimeFormatter;
	
	public class DateBoxValidator extends mx.validators.DateValidator
	{
		protected var _minDate:Date;
		public function get minDate():Date
		{
			return _minDate;
		}

		public function set minDate(value:Date):void
		{
			_minDate = value;
		}

		protected var _maxDate:Date;
		public function get maxDate():Date
		{
			return _maxDate;
		}

		public function set maxDate(value:Date):void
		{
			_maxDate = value;
		}
		
		protected var _minDateError:String;
		public function get minDateError():String
		{
			return _minDateError;
		}

		public function set minDateError(value:String):void
		{
			_minDateError = value;
		}

		protected var _maxDateError:String;
		public function get maxDateError():String
		{
			return _maxDateError;
		}

		public function set maxDateError(value:String):void
		{
			_maxDateError = value;
		}

		
		protected var _dateVal:Date;
		public function get dateVal():Date
		{
			return _dateVal;
		}
		
		public function DateBoxValidator()
		{
			super();
		}
		
		public override function validate(value:Object=null, suppressEvents:Boolean=false):ValidationResultEvent {
			
			var result:ValidationResultEvent = super.validate(value, suppressEvents);
			
			if(result.type == ValidationResultEvent.VALID && (_maxDate != null || _minDate != null)) {
				result = validateMaxMinVal(result);
			}
			
			return result;
		}
		
		protected function validateMaxMinVal(result:ValidationResultEvent):ValidationResultEvent {
			_dateVal = DateUtils.stringToDate(getValueFromSource().toString(), inputFormat);
			
			var errors:Array = new Array();
			
			if(_maxDate != null && _dateVal > _maxDate) {
				errors.push(new ValidationResult(true, "", "maxDate", StringUtils.replace(_maxDateError, "{0}", DateTimeFormatter.formatDateDefault(_maxDate))));
			}
			
			if(_minDate != null && _dateVal < _minDate) {
				errors.push(new ValidationResult(true, "", "minDate", StringUtils.replace(_minDateError, "{0}", DateTimeFormatter.formatDateDefault(_minDate))));
			}
			
			if(errors.length > 0) {
				result = new ValidationResultEvent(ValidationResultEvent.INVALID);
				result.results = errors;
			}
			
			return result
		}
	}
}