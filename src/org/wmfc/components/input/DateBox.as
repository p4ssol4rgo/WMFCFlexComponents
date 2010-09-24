package org.wmfc.components.input
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.DateField;
	import mx.events.ValidationResultEvent;
	
	import org.wmfc.components.input.validators.DateBoxValidator;
	import org.wmfc.utils.NumberUtils;
	import org.wmfc.utils.Resource;
	import org.wmfc.utils.StringUtils;
	import org.wmfc.utils.formatters.DateTimeFormatter;
	
	public class DateBox extends DateField implements IValidate
	{
		
		public static const FORMAT_BAR_MM_DD_YYYY:String = "MM/DD/YYYY";
		public static const FORMAT_BAR_DD_MM_YYYY:String = "DD/MM/YYYY";
		public static const FORMAT_BAR_YYYY_MM_DD:String = "YYYY/MM/DD";
		public static const FORMAT_TR_MM_DD_YYYY:String = "MM-DD-YYYY";
		public static const FORMAT_TR_DD_MM_YYYY:String = "DD-MM-YYYY";
		public static const FORMAT_TR_YYYY_MM_DD:String = "YYYY-MM-DD";
		
		public static var defaultBlankChar:String = "_";
		public static var defaultInputFormat:String = FORMAT_BAR_MM_DD_YYYY;
		
		protected var inputMask:String;
		protected var separator:String;
		
		protected var haveToUpdate:Boolean;
		protected var textToUpdate:String;
		protected var positionToUpdate:int;
		protected var positionUpdateVal:int;
		protected var selectionSize:int;
		
		protected var validator:DateBoxValidator;
		
		protected var _maxDate:Date;
		public function get maxDate():Date
		{
			return _maxDate;
		}

		public function set maxDate(value:Date):void
		{
			_maxDate = value;
		}

		protected var _minDate:Date;
		public function get minDate():Date
		{
			return _minDate;
		}

		public function set minDate(value:Date):void
		{
			_minDate = value;
		}

		
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
		
		protected var _requiredFieldError:String = Resource.getValue(Resource.INPUT_REQUIRED_FIELD_ERROR);
		public function get requiredFieldError():String
		{
			return _requiredFieldError;
		}
		
		public function set requiredFieldError(value:String):void
		{
			_requiredFieldError = value;
		}
		
		protected var _maxDateError:String = Resource.getValue(Resource.INPUT_MAX_DATE_ERROR);
		public function get maxDateError():String
		{
			return _maxDateError;
		}

		public function set maxDateError(value:String):void
		{
			_maxDateError = value;
		}

		protected var _minDateError:String = Resource.getValue(Resource.INPUT_MIN_DATE_ERROR);
		public function get minDateError():String
		{
			return _minDateError;
		}

		public function set minDateError(value:String):void
		{
			_minDateError = value;
		}

		
		protected var _wrongDayError:String = Resource.getValue(Resource.INPUT_WRONG_DAY_ERROR);
		public function get wrongDayError():String
		{
			return _wrongDayError;
		}

		public function set wrongDayError(value:String):void
		{
			_wrongDayError = value;
		}

		protected var _wrongMonthError:String = Resource.getValue(Resource.INPUT_WRONG_MONTH_ERROR);
		public function get wrongMonthError():String
		{
			return _wrongMonthError;
		}

		public function set wrongMonthError(value:String):void
		{
			_wrongMonthError = value;
		}

		protected var _wrongYearError:String = Resource.getValue(Resource.INPUT_WRONG_YEAR_ERROR);
		public function get wrongYearError():String
		{
			return _wrongYearError;
		}

		public function set wrongYearError(value:String):void
		{
			_wrongYearError = value;
		}

		protected var _wrongLengthError:String = Resource.getValue(Resource.INPUT_WRONG_DATE_LENGTH_ERROR);
		public function get wrongLengthError():String
		{
			return _wrongLengthError;
		}

		public function set wrongLengthError(value:String):void
		{
			_wrongLengthError = value;
		}
		
		
		protected var _blankChar:String = defaultBlankChar;
		public function get blankChar():String
		{
			return _blankChar;
		}

		public function set blankChar(value:String):void
		{
			if(_blankChar == "") {
				_blankChar = " ";
			}
			
			_blankChar = value;
		}
		
		protected var _defaultDate:Date = null;
		public function get defaultDate():Date
		{
			return _defaultDate;
		}

		public function set defaultDate(value:Date):void
		{
			_defaultDate = value;
		}
		
		public override function get formatString():String {
			return super.formatString;
		}
		
		[Inspectable(category="General", enumeration="MM/DD/YYYY,DD/MM/YYYY,YYYY/MM/DD,MM-DD-YYYY,DD-MM-YYYY,YYYY-MM-DD", defaultValue="MM/DD/YYYY")]
		public override function set formatString(value:String):void {
			
			if(value == null) {
				super.formatString = value;
				return;
			}
			
			switch(value) {
				case FORMAT_BAR_MM_DD_YYYY:
				case FORMAT_BAR_DD_MM_YYYY:
				case FORMAT_BAR_YYYY_MM_DD:
				case FORMAT_TR_MM_DD_YYYY:
				case FORMAT_TR_DD_MM_YYYY:
				case FORMAT_TR_YYYY_MM_DD:
					super.formatString = value;
					configureInputMask();
					break;
				default:
					throw new Error("Invalid input date format!");
			}
		}
		
		public override function get selectedDate():Date {
			return super.selectedDate;
		}
		
		public override function set selectedDate(value:Date):void {
			super.selectedDate = value;
		}
		
		public function get validText():String {
			if(this.text == inputMask) {
				return "";
			}
			
			return StringUtils.replace(this.text, _blankChar, "");
		}
		
		public function DateBox()
		{
			super();
			super.formatString = defaultInputFormat;
			this.yearNavigationEnabled = true;
			this.editable = true;
		}
		
		protected override function childrenCreated():void {
			super.childrenCreated();
			
			this.textInput.addEventListener(KeyboardEvent.KEY_DOWN, interceptKey, true, 0, true);
			this.textInput.addEventListener(TextEvent.TEXT_INPUT, interceptChar, true, 0, true);
			
			selectedDate = _defaultDate;
			
			if(formatString == defaultInputFormat) {
				configureInputMask();
			}
			
			formatValue();
			validate();
		}
		
		protected override function focusOutHandler(event:FocusEvent):void {
			super.focusOutHandler(event);
			validate();
		}
		
		protected function configureInputMask():void {
			switch(formatString) {
				case FORMAT_BAR_MM_DD_YYYY:
				case FORMAT_BAR_DD_MM_YYYY:
				case FORMAT_BAR_YYYY_MM_DD:
					separator = "/";
					break;
				case FORMAT_TR_MM_DD_YYYY:
				case FORMAT_TR_DD_MM_YYYY:
				case FORMAT_TR_YYYY_MM_DD:
					separator = "-";
					break;
			}
			
			var pattern:RegExp = /Y|M|D/g;
			inputMask = formatString.replace(pattern, _blankChar);
		}
		
		protected function formatValue():void {
			if(selectedDate == null) {
				this.text = inputMask;
			}else{
				this.text = DateTimeFormatter.format(selectedDate, formatString);
			}
		}
		
		public function validate():ValidationResultEvent {
			if(validator == null) {
				validator = new DateBoxValidator();
				
				validator.required = _required
				validator.inputFormat = formatString;
				
				validator.maxDate = _maxDate;
				validator.minDate = _minDate;
				
				validator.requiredFieldError = _requiredFieldError;
				validator.maxDateError = _maxDateError;
				validator.minDateError = _minDateError;
				validator.wrongDayError = _wrongDayError;
				validator.wrongMonthError = _wrongMonthError;
				validator.wrongYearError = _wrongYearError;
				validator.wrongLengthError = _wrongLengthError;
				
				validator.source = this;
				validator.property = "validText";
			}

			return validator.validate();
		}
		
		protected function interceptKey(event:KeyboardEvent):void {			
			if(event.keyCode == Keyboard.DELETE || 
				event.keyCode == Keyboard.BACKSPACE)
			{
				if(event.keyCode == Keyboard.BACKSPACE && 
					this.textInput.selectionActivePosition == 0) {
					return;
				}
				
				textToUpdate = this.text;
				
				selectionSize = this.textInput.selectionActivePosition - 
									this.textInput.selectionAnchorPosition;
				
				positionToUpdate = event.keyCode == Keyboard.BACKSPACE || selectionSize > 0 ? 
										this.textInput.selectionActivePosition - 1 :
										this.textInput.selectionActivePosition;
				
				positionUpdateVal = event.keyCode == Keyboard.BACKSPACE || selectionSize > 0 ? -1 : 1;
				
				invalidateDisplayList();
				
				haveToUpdate = true;
			}else{
				haveToUpdate = false;
			}
		}
		
		protected function interceptChar(event:TextEvent):void {
			event.preventDefault();
			
			handleInput(event.text, this.text, 
						this.textInput.selectionAnchorPosition,
						this.textInput.selectionActivePosition,
						1);
		}
		
		protected function handleInput(input:String, actualText:String, 
									   anchorPos:int, activePos:int, 
									   newPosition:int):void {
			
			if(input != _blankChar && !NumberUtils.isDigit(input)) {
				return;
			}
			
			var posIni:int = anchorPos;
			var posFin:int = activePos;
			
			var inputText:String = actualText;
			var inputTextLen:int = inputText.length;
			
			if(inputText != inputMask && inputText.substring(posIni, posFin).length == inputText.length){
				inputText = inputMask;
			}
			
			if(posIni == inputTextLen) {
				return;
			}
			
			var strP1:String = posIni == 0 ? "" : inputText.substring(0, posIni);
			
			var nextPos:int = posIni + newPosition;
			
			if(posIni > 0 && inputText.substr(strP1.length, 1) == separator) {
				if(newPosition == -1) {
					strP1 = StringUtils.left(strP1, strP1.length - 1) + input + separator;
					newPosition--;
				}else{
					strP1 = strP1 + separator + input;
				}
				nextPos += newPosition;
			}else if(inputText.substr((strP1 + input).length, 1) == separator) {
				if(newPosition == -1) {
					strP1 = strP1 + input + (newPosition == -1 ? "" : separator);
				}else{
					strP1 = strP1 + input + separator;
				}
				nextPos += newPosition;
			}else{
				strP1 = strP1 + input;
			}
			
			if(newPosition < 0) {
				posIni++;
			}
			
			var strP2:String = nextPos == inputTextLen ? "" : inputText.substr(newPosition < 0 ? posIni : nextPos);
			
			this.text = strP1 + strP2;
			
			if(newPosition < 0) {
				posIni = posIni + newPosition;
				this.textInput.selectRange(posIni, posIni);
			}else{
				this.textInput.selectRange(nextPos, nextPos);
			}
		}
		
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			if(haveToUpdate == true) {
				if(this.text == "" || textToUpdate == inputMask) {
					this.text = inputMask;
				}else{
					if(selectionSize == 0) {
						handleInput(_blankChar, textToUpdate, 
									positionToUpdate, positionToUpdate, 
									positionUpdateVal);
					}else{
						for(var i:int = 0; i < selectionSize; i++) {
							handleInput(_blankChar, textToUpdate, 
								positionToUpdate, positionToUpdate, 
								positionUpdateVal);
							
							textToUpdate = this.text;
							positionToUpdate--;
						}
					}
				}
			}
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
	}
}