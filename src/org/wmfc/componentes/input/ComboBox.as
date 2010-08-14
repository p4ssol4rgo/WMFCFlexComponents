package org.wmfc.componentes.input
{
	import mx.events.ValidationResultEvent;
	
	import spark.components.ComboBox;
	
	public class ComboBox extends spark.components.ComboBox implements IValidate
	{
		public function ComboBox()
		{
			super();
		}
		
		public function validate():ValidationResultEvent
		{
			return null;
		}
	}
}