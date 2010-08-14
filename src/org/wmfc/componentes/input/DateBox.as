package org.wmfc.componentes.input
{
	import mx.controls.DateField;
	import mx.events.ValidationResultEvent;
	
	public class DateBox extends DateField implements IValidate
	{
		public function DateBox()
		{
			super();
		}
		
		public function validate():ValidationResultEvent {
			//TODO
			throw new Error("Não implementado!");
			/*if(validatorRequired == null){
				validatorRequired = new Validator();
				validatorRequired.source = this;
				validatorRequired.property = "text";
			}
			
			if(_required != validatorRequired.required) {
				validatorRequired.required = _required;
				return validatorRequired.validate();
			}*/
			
			return null;
		}
	}
}