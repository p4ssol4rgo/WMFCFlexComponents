package org.wmfc.componentes.input.validators
{
	import mx.events.ValidationResultEvent;
	import mx.validators.NumberValidator;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.wmfc.utils.StringUtils;
	import org.wmfc.utils.formatters.NumericFormatter;
	
	public class NumericTextBoxValidator extends Validator
	{
		protected var _value:Number;
		
		protected var _allowNulls:Boolean;
		public function get allowNulls():Boolean
		{
			return _allowNulls;
		}

		public function set allowNulls(value:Boolean):void
		{
			_allowNulls = value;
		}
		
		protected var _allowNegativeValues:Boolean;
		public function get allowNegativeValues():Boolean
		{
			return _allowNegativeValues;
		}

		public function set allowNegativeValues(value:Boolean):void
		{
			_allowNegativeValues = value;
		}

		protected var _minValue:Number;
		public function get minValue():Number
		{
			return _minValue;
		}

		public function set minValue(value:Number):void
		{
			_minValue = value;
		}

		protected var _maxValue:Number;
		public function get maxValue():Number
		{
			return _maxValue;
		}

		public function set maxValue(value:Number):void
		{
			_maxValue = value;
		}
		
		protected var _allowNullsError:String;
		public function get allowNullsError():String
		{
			return _allowNullsError;
		}

		public function set allowNullsError(value:String):void
		{
			_allowNullsError = value;
		}

		protected var _allowNegativeValuesError:String;
		public function get allowNegativeValuesError():String
		{
			return _allowNegativeValuesError;
		}

		public function set allowNegativeValuesError(value:String):void
		{
			_allowNegativeValuesError = value;
		}

		protected var _minValueError:String;
		public function get minValueError():String
		{
			return _minValueError;
		}

		public function set minValueError(value:String):void
		{
			_minValueError = value;
		}

		protected var _maxValueError:String;
		public function get maxValueError():String
		{
			return _maxValueError;
		}

		public function set maxValueError(value:String):void
		{
			_maxValueError = value;
		}
		
		public override function validate(value:Object=null,
										  suppressEvents:Boolean=false):ValidationResultEvent {
			
			if (value == null) {
				value = getValueFromSource();
			}
			
			var numberValue:Number = value == null ? Number.NaN : Number(value);
			
			var errors:Array = new Array();
			
			if(isNaN(numberValue) && _allowNulls){
				return getValidationResult(errors, suppressEvents);
			}
			
			if(required && (isNaN(numberValue) || value == 0))
			{
				errors.push(new ValidationResult(true, "", "requiredField", requiredFieldError)); 
			}
			
			if(!_allowNulls && isNaN(numberValue)) {
				errors.push(new ValidationResult(true, "", "allowNulls", _allowNullsError));
			}
			
			if(!_allowNegativeValues && numberValue < 0) {
				errors.push(new ValidationResult(true, "", "allowNegativeValues", _allowNegativeValuesError));
			}
			
			if(!isNaN(_minValue) && numberValue < _minValue) {
				errors.push(new ValidationResult(true, "", "minValue", StringUtils.replace(_minValueError, "{0}", NumericFormatter.formatDefault(_minValue))));
			}
			
			if(!isNaN(_maxValue) && numberValue > _maxValue) {
				errors.push(new ValidationResult(true, "", "maxValue", StringUtils.replace(_maxValueError, "{0}", NumericFormatter.formatDefault(_maxValue))));
			}
			
			return getValidationResult(errors, suppressEvents)
		}
		
		protected function getValidationResult(errors:Array, suppressEvents:Boolean=false):ValidationResultEvent {
			var resultEvent:ValidationResultEvent;
			
			if(errors.length > 0) {
				resultEvent = new ValidationResultEvent(ValidationResultEvent.INVALID);
				resultEvent.results = errors;
			}else{
				resultEvent = new ValidationResultEvent(ValidationResultEvent.VALID);
			}
			
			if (!suppressEvents && enabled)
			{
				dispatchEvent(resultEvent);
			}
			
			return resultEvent; 
		}
		
	}
}