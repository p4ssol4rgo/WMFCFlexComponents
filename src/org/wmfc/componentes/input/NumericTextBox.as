package org.wmfc.componentes.input
{
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	
	import flashx.textLayout.operations.InsertTextOperation;
	
	import mx.events.FlexEvent;
	import mx.events.ValidationResultEvent;
	
	import org.wmfc.componentes.input.validators.NumericTextBoxValidator;
	import org.wmfc.utils.Resource;
	import org.wmfc.utils.StringUtils;
	import org.wmfc.utils.formatters.NumericFormatter;
	
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	
	public class NumericTextBox extends TextInput implements IValidate
	{
		protected var _numericFormatter:NumericFormatter;
		
		protected var validatorRequired:NumericTextBoxValidator;
		
		protected var _required:Boolean;
		public function get required():Boolean
		{
			return _required;
		}
		
		public function set required(value:Boolean):void
		{
			_required = value;
			
			if(this.initialized) {
				validate();
			}
		}
		
		protected var _decimalPlaces:int;
		public function get decimalPlaces():int
		{
			return _decimalPlaces;
		}

		public function set decimalPlaces(value:int):void
		{
			_decimalPlaces = value;
		}
		
		protected var _groupDigits:Boolean = true;
		public function get groupDigits():Boolean
		{
			return _groupDigits;
		}

		public function set groupDigits(value:Boolean):void
		{
			_groupDigits = value;
		}
		
		protected var _decimalSeparator:String = NumericFormatter.defaultDecimalSeparator;
		public function get decimalSeparator():String
		{
			return _decimalSeparator;
		}

		public function set decimalSeparator(value:String):void
		{
			_decimalSeparator = value;
			
			configureRestrict();
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
		
		protected var _allowNulls:Boolean;
		public function get allowNulls():Boolean
		{
			return _allowNulls;
		}

		public function set allowNulls(value:Boolean):void
		{
			_allowNulls = value;
		}
		
		protected var _allowNegativeValues:Boolean = true;
		public function get allowNegativeValues():Boolean
		{
			return _allowNegativeValues;
		}
		
		public function set allowNegativeValues(value:Boolean):void
		{
			_allowNegativeValues = value;
			
			configureRestrict();
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
		
		protected var _requiredFieldError:String = Resource.getValue(Resource.INPUT_REQUIRED_FIELD_ERROR);
		public function get requiredFieldError():String
		{
			return _requiredFieldError;
		}
		
		public function set requiredFieldError(value:String):void
		{
			_requiredFieldError = value;
		}
		
		protected var _allowNullsError:String = Resource.getValue(Resource.INPUT_ALLOW_NULLS_ERROR);
		public function get allowNullsError():String
		{
			return _allowNullsError;
		}
		
		public function set allowNullsError(value:String):void
		{
			_allowNullsError = value;
		}
		
		protected var _allowNegativeValuesError:String = Resource.getValue(Resource.INPUT_ALLOW_NEGATIVE_VALUES_ERROR);
		public function get allowNegativeValuesError():String
		{
			return _allowNegativeValuesError;
		}
		
		public function set allowNegativeValuesError(value:String):void
		{
			_allowNegativeValuesError = value;
		}
		
		protected var _minValueError:String = Resource.getValue(Resource.INPUT_MIN_VALUE_ERROR);
		public function get minValueError():String
		{
			return _minValueError;
		}
		
		public function set minValueError(value:String):void
		{
			_minValueError = value;
		}
		
		protected var _maxValueError:String = Resource.getValue(Resource.INPUT_MAX_VALUE_ERROR);
		public function get maxValueError():String
		{
			return _maxValueError;
		}
		
		public function get value():Number {
			return getValue();
		}
		
		public function set value(val:Number):void {
			formatValue(val);
		}
		
		public function NumericTextBox()
		{
			super();
			
			this.setStyle("textAlign", "right");
			
			this.addEventListener(TextEvent.TEXT_INPUT, interceptChar, true, 0, true);
			this.addEventListener(FocusEvent.FOCUS_IN, on_focusIN, false, 0, true);
			this.addEventListener(FocusEvent.FOCUS_OUT, on_focusOUT, false, 0, true);
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, init);
			
			configureRestrict();
		}
		
		protected function init(event:FlexEvent):void {
			
			formatValue(_allowNulls ? Number.NaN : 0);
			
			if(_required) {
				validate();
			}
		}
		
		protected function on_focusIN(event:FocusEvent):void {
			removeFormat();
			this.selectAll();
		}
		
		protected function on_focusOUT(event:FocusEvent):void {
			formatValue(getValue());
			validate();
		}
		
		protected function configureRestrict():void {
			this.restrict = "0123456789" + _decimalSeparator + (_allowNegativeValues == true ? "\\-" : "");
		}
		
		public function validate():ValidationResultEvent
		{
			if(validatorRequired == null){
				validatorRequired = new NumericTextBoxValidator();
				validatorRequired.required = _required;
				validatorRequired.allowNulls = _allowNulls;
				validatorRequired.allowNegativeValues = _allowNegativeValues;
				validatorRequired.minValue = _minValue;
				validatorRequired.maxValue = _maxValue;
				validatorRequired.requiredFieldError = _requiredFieldError;
				validatorRequired.allowNullsError = _allowNullsError;
				validatorRequired.allowNegativeValuesError = _allowNegativeValuesError;
				validatorRequired.minValueError = _minValueError;
				validatorRequired.maxValueError = _maxValueError;
				validatorRequired.source = this;
				validatorRequired.property = "value";
			}
			
			return validatorRequired.validate();
		}
		
		protected function interceptChar(event:TextEvent):void
		{
			var hasTextSelected:Boolean = this.selectionActivePosition != this.selectionAnchorPosition;
			var beginIndex:int = hasTextSelected ? this.selectionAnchorPosition : this.selectionActivePosition;
			var endIndex:int = this.selectionAnchorPosition;
			
			var textSelected:String = hasTextSelected ? this.text.substring(beginIndex, endIndex) : "";

			var input:String = event.text;
			
			if(input == _decimalSeparator && _decimalPlaces == 0) {
				event.stopImmediatePropagation();
				return;
			}
			
			if(_decimalPlaces > 0 && !hasTextSelected) {
				
				var indDecimalSep:int = this.text.indexOf(_decimalSeparator);
				
				if(indDecimalSep != -1 && beginIndex > indDecimalSep) {
					if(((this.text.length - 1) - indDecimalSep) == _decimalPlaces){
						event.stopImmediatePropagation();
						return;
					}
				}
			}
			
			if(input == _decimalSeparator || input == "."){				
				
				if(_decimalPlaces == 0){
					event.stopImmediatePropagation();
					return;
				}
				
				if(this.text == "" || (hasTextSelected && this.text.length == textSelected.length)){
					event.stopImmediatePropagation();
					this.text = "0" + _decimalSeparator;
					this.selectRange(2, 2);
					
					return;
				}
				
				if(this.text.indexOf(_decimalSeparator) != -1){
					event.stopImmediatePropagation();
					return;
				}
				
				if(input == "." && _decimalSeparator != "."){
					event.stopImmediatePropagation();
					var strP1:String = this.text.substr(0, beginIndex);
					var strP2:String = this.text.substr(beginIndex);
					
					var posTemp:int = beginIndex + 1;
					
					this.text = strP1 + _decimalSeparator + strP2;
					
					this.selectRange(posTemp, posTemp);
					
					return;
				}
			}
			
			if(input == "-") {
				if(this.text.indexOf("-") >= 0){
					event.stopImmediatePropagation();
					return;
				}
				if(beginIndex != 0){
					event.stopImmediatePropagation();
					return;
				}
			}
		}
		
		protected function getValue():Number {
			var str:String = StringUtils.trim(this.text);
			
			if(str.length == 0){
				if(_allowNulls) {
					return Number.NaN;
				}else{
					str = "0";
				}
			}
			
			if(_groupDigits) {
				str = StringUtils.replace(str, _thousandSeparator, "");
			}
			
			if(_decimalPlaces > 0 && _decimalSeparator != ".") {
				str = StringUtils.replace(str, _decimalSeparator, ".");
			}
			
			return Number(str);
		}
		
		protected function formatValue(val:Number):void {
			
			if(isNaN(val) && _allowNulls) {
				this.text = "";
				return;
			}
			
			if(_numericFormatter == null) {
				_numericFormatter = new NumericFormatter();
				_numericFormatter.decimalPlaces = _decimalPlaces;
				_numericFormatter.decimalSeparator = _decimalSeparator;
				_numericFormatter.thousandSeparator = _groupDigits ? _thousandSeparator : "";
			}
			
			this.text = _numericFormatter.format(val);
		}
		
		protected function removeFormat():void {
			
			var val:Number = getValue();
			
			if(isNaN(val)) {
				return;
			}
			
			var str:String = getValue().toString();
			
			if(_decimalPlaces > 0) {
				str = StringUtils.replace(str, ".", _decimalSeparator);
			}
			
			this.text = str;
		}

	}
}