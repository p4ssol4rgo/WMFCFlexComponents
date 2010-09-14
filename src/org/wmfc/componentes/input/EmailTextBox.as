package org.wmfc.componentes.input
{
	import mx.events.ValidationResultEvent;
	import mx.validators.EmailValidator;
	
	import org.wmfc.utils.Resource;

	public class EmailTextBox extends TextBox
	{
		protected var emailValidator:EmailValidator;
		
		private var _invalidEmailFormatMessage:String = Resource.getValue(Resource.INPUT_INVALID_EMAIL_FORMAT);
		public function get invalidEmailFormatMessage():String
		{
			return _invalidEmailFormatMessage;
		}
		
		public function set invalidEmailFormatMessage(value:String):void
		{
			_invalidEmailFormatMessage = value;
		}
		
		public override function validate():ValidationResultEvent {
			if(emailValidator == null){
				emailValidator = new EmailValidator();
				emailValidator.requiredFieldError = _requiredFieldError;
				emailValidator.source = this;
				emailValidator.property = "text";
				emailValidator.required = _required;
				emailValidator.invalidCharError = 
					emailValidator.invalidDomainError =
					emailValidator.invalidIPDomainError = 
					emailValidator.invalidPeriodsInDomainError = 
					emailValidator.missingAtSignError = 
					emailValidator.missingPeriodInDomainError = 
					emailValidator.missingUsernameError = 
					emailValidator.tooManyAtSignsError = _invalidEmailFormatMessage;
			}
			
			return validatorRequired.validate();
		}
	}
}