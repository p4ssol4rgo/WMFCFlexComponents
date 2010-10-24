package org.wmfc.components.input
{
	import mx.events.FlexEvent;
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;
	
	import org.wmfc.utils.Resource;
	
	import spark.components.ComboBox;
	
	public class ComboBox extends spark.components.ComboBox implements IValidate
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

		
		public function ComboBox()
		{
			super();
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, init, false, 0, true);
		}
		
		protected function init(event:FlexEvent):void {
			if(_required) {
				validate();
			}
		}
		
		public function selectItemByAttribute(attribute:String, value:Object):void {
			
			if(dataProvider == null) {
				return;
			}
			
			for each(var item:Object in dataProvider){
				if(item == null || !item.hasOwnProperty(attribute)) {
					continue;
				}
				
				if(item[attribute] == value){
					selectedItem = item;
				}
			}
		}
		
		public function validate():ValidationResultEvent
		{
			if(validatorRequired == null){
				validatorRequired = new Validator();
				validatorRequired.requiredFieldError = _requiredFieldError;
				validatorRequired.source = this;
				validatorRequired.property = "selectedItem";
				validatorRequired.required = _required;
			}
			
			return validatorRequired.validate();
		}
	}
}