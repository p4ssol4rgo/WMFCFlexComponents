package org.wmfc.componentes.input
{
	import mx.events.FlexEvent;
	import mx.events.ValidationResultEvent;
	import mx.utils.StringUtil;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.wmfc.utils.Resource;
	import org.wmfc.utils.StringUtils;
	
	import spark.components.TextInput;
	
	public class TextBox extends TextInput implements IValidate
	{
		
		protected var validatorRequired:Validator;
		
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
		
		protected var _requiredMessage:String = Resource.getValue(Resource.INPUT_REQUIRED_FIELD);
		public function get requiredMessage():String
		{
			return _requiredMessage;
		}

		public function set requiredMessage(value:String):void
		{
			_requiredMessage = value;
		}

		
		protected var _trimText:Boolean = true;
		public function get trimText():Boolean
		{
			return _trimText;
		}

		public function set trimText(value:Boolean):void
		{
			_trimText = value;
		}
		
		public function TextBox()
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, init);
		}
		
		protected function init(event:FlexEvent):void {
			if(_required) {
				validate();
			}
		}
		
		public override function get text():String {
			if(_trimText) {
				return StringUtils.trim(super.text);
			}else{
				return super.text;
			}
		}
		
		public function validate():ValidationResultEvent {
			if(validatorRequired == null){
				validatorRequired = new Validator();
				validatorRequired.requiredFieldError = _requiredMessage;
				validatorRequired.source = this;
				validatorRequired.property = "text";
				validatorRequired.required = _required;
			}
			
			return validatorRequired.validate();
		}
	}
}