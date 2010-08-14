package org.wmfc.componentes.alert
{
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.IFlexModuleFactory;
	
	import org.wmfc.assets.defaultImages.DefaultImages;
	
	public class MessageBox extends Alert
	{
		
		public static const OK:uint = Alert.OK;
		public static const YES:uint = Alert.YES;
		public static const NO:uint = Alert.NO;
		public static const CANCEL:uint = Alert.CANCEL;
		
		private static var pVez:Boolean = true;
		
		private static function init():void {
			mx.controls.Alert.yesLabel = "Sim";
			mx.controls.Alert.noLabel = "Não";
			mx.controls.Alert.cancelLabel = "Cancelar";
			mx.controls.Alert.okLabel ="OK";
		}
		
		public static function show(text:String = "", title:String = "",
									flags:uint = 0x4 /* Alert.OK */, 
									parent:Sprite = null, 
									closeHandler:Function = null, 
									iconClass:Class = null, 
									defaultButtonFlag:uint = 0x4 /* Alert.OK */,
									moduleFactory:IFlexModuleFactory = null):MessageBox {
			
			if(!pVez) {
				init();
				pVez = false;
			}
			
			return Alert.show(text, title, flags, parent, closeHandler, iconClass, defaultButtonFlag, moduleFactory) as MessageBox;
		}
		
		public static function showAlert(message:String, title:String="Atenção", callBackFunction:Function=null):MessageBox {
			return show(message, title, MessageBox.OK, null, callBackFunction, DefaultImages.icoInformacao);
		}
		
		public static function showError(message:String, title:String="Erro", callBackFunction:Function=null):MessageBox {
			return show(message, title, MessageBox.OK, null, callBackFunction, DefaultImages.icoErro);
		}
		
		public static function showQuestion(message:String, title:String="Confirmação", callBackFunction:Function=null, defaultButton:uint=mx.controls.Alert.NO):MessageBox {
			return show(message, title, MessageBox.YES|MessageBox.NO, null, callBackFunction, DefaultImages.icoConfirmacao, defaultButton);
		}
	}
}