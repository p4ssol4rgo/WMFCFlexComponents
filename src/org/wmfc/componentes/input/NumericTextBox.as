package org.wmfc.componentes.input
{
	import flash.events.TextEvent;
	
	import mx.events.FlexEvent;
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;
	
	import org.wmfc.utils.StringUtils;
	import org.wmfc.utils.formatters.NumericFormatter;
	
	import spark.components.TextInput;
	
	public class NumericTextBox extends TextInput implements IValidate
	{
		protected var _numericFormatter:NumericFormatter;
		
		protected var validatorRequired:Validator;
		
		private var _required:Boolean;
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
		
		private var _requiredMessage:String = "This field can´t be empty!";
		public function get requiredMessage():String
		{
			return _requiredMessage;
		}
		
		public function set requiredMessage(value:String):void
		{
			_requiredMessage = value;
		}
		
		private var _decimalPlaces:int;
		public function get decimalPlaces():int
		{
			return _decimalPlaces;
		}

		public function set decimalPlaces(value:int):void
		{
			_decimalPlaces = value;
		}
		
		private var _negativeValues:Boolean = true;
		public function get negativeValues():Boolean
		{
			return _negativeValues;
		}

		public function set negativeValues(value:Boolean):void
		{
			_negativeValues = value;
			
			configureRestrict();
		}
		
		private var _groupDigits:Boolean = true;
		public function get groupDigits():Boolean
		{
			return _groupDigits;
		}

		public function set groupDigits(value:Boolean):void
		{
			_groupDigits = value;
		}
		
		private var _decimalSeparator:String = NumericFormatter.defaultDecimalSeparator;
		public function get decimalSeparator():String
		{
			return _decimalSeparator;
		}

		public function set decimalSeparator(value:String):void
		{
			_decimalSeparator = value;
		}
		
		private var _thousandSeparator:String = NumericFormatter.defaultThousandSeparator;
		public function get thousandSeparator():String
		{
			return _thousandSeparator;
		}

		public function set thousandSeparator(value:String):void
		{
			_thousandSeparator = value;
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
			this.addEventListener(FlexEvent.CREATION_COMPLETE, init);
			
			configureRestrict();
		}
		
		protected function init(event:FlexEvent):void {
			if(_required) {
				validate();
			}
		}
		
		protected function configureRestrict():void {
			this.restrict = "0123456789.," + (value == true ? "\\-" : "");
		}
		
		public function validate():ValidationResultEvent
		{
			if(validatorRequired == null){
				validatorRequired = new Validator();
				validatorRequired.requiredFieldError = _requiredMessage;
				validatorRequired.source = this;
				validatorRequired.property = "text";
				validatorRequired.required = _required;
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
			
			if(_decimalPlaces > 0 && !hasTextSelected) {
				
				var indDecimalSep:int = this.text.indexOf(_decimalSeparator);
				
				if(indDecimalSep != -1 && beginIndex > indDecimalSep) {
					if(((this.text.length - 1) - indDecimalSep) == _decimalPlaces){
						event.preventDefault();
						return;
					}
				}
			}
			
			if(input == _decimalSeparator || input == "."){				
				
				if(_decimalPlaces == 0){
					event.preventDefault();
					return;
				}
				
				if(this.text == "" || (hasTextSelected && this.text.length == textSelected.length)){
					event.preventDefault();
					this.text = "0" + _decimalSeparator;
					this.selectRange(2, 2);
					
					return;
				}
				
				if(this.text.indexOf(_decimalSeparator) != -1){
					event.preventDefault();
					return;
				}
				
				if(input == "." && _decimalSeparator != "."){
					event.preventDefault();
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
					event.preventDefault();
					return;
				}
				if(beginIndex != 0){
					event.preventDefault();
					return;
				}
			}
		}
		
		protected function getValue():Number {
			var str:String = this.text;
			
			if(_groupDigits) {
				var patternT:RegExp = new RegExp("/\\" + _thousandSeparator + "/g");
			
				str = str.replace(patternT, ""); 
			}
			
			if(_decimalPlaces > 0 && _decimalSeparator != ".") {
				var pattern:RegExp = new RegExp("/\\" + _decimalSeparator + "/g");
				
				str = str.replace(pattern, ".");
			}
			
			return Number(str);
		}
		
		protected function formatValue(val:Number):void {
			if(_numericFormatter == null) {
				_numericFormatter = new NumericFormatter();
				_numericFormatter.decimalPlaces = _decimalPlaces;
				_numericFormatter.decimalSeparator = _decimalSeparator;
				_numericFormatter.thousandSeparator = _groupDigits ? _thousandSeparator : "";
			}
			
			this.text = _numericFormatter.format(val);
		}

	}
}