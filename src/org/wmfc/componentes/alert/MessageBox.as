package org.wmfc.componentes.alert
{
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.IFlexModuleFactory;
	
	import org.wmfc.assets.defaultImages.DefaultImages;
	import org.wmfc.utils.Resource;
	
	public class MessageBox extends Alert
	{
		
		public static const OK:uint = Alert.OK;
		public static const YES:uint = Alert.YES;
		public static const NO:uint = Alert.NO;
		public static const CANCEL:uint = Alert.CANCEL;
		
		private static var _defaultAlertTitle:String;
		private static var _defaultErrorTitle:String;
		private static var _defaultQuestionTitle:String;
		
		private static var pVez:Boolean = true;
		
		private static function init():void {
			mx.controls.Alert.yesLabel = Resource.getValue(Resource.MESSAGEBOX_YES_LABEL);
			mx.controls.Alert.noLabel = Resource.getValue(Resource.MESSAGEBOX_NO_LABEL);
			mx.controls.Alert.cancelLabel = Resource.getValue(Resource.MESSAGEBOX_CANCEL_LABEL);
			mx.controls.Alert.okLabel = Resource.getValue(Resource.MESSAGEBOX_OK_LABEL);
			
			_defaultAlertTitle = Resource.getValue(Resource.MESSAGEBOX_ALERT_TITLE);
			_defaultErrorTitle = Resource.getValue(Resource.MESSAGEBOX_ERROR_TITLE);
			_defaultQuestionTitle = Resource.getValue(Resource.MESSAGEBOX_QUESTION_TITLE);
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
		
		public static function showAlert(message:String, title:String="", callBackFunction:Function=null):MessageBox {
			if(title == "") {
				title = _defaultAlertTitle;
			}
			return show(message, title, MessageBox.OK, null, callBackFunction, DefaultImages.icoInformation);
		}
		
		public static function showError(message:String, title:String="", callBackFunction:Function=null):MessageBox {
			if(title == "") {
				title = _defaultErrorTitle;
			}
			
			return show(message, title, MessageBox.OK, null, callBackFunction, DefaultImages.icoError);
		}
		
		public static function showQuestion(message:String, title:String="", callBackFunction:Function=null, defaultButton:uint=mx.controls.Alert.NO):MessageBox {
			if(title == "") {
				title = _defaultQuestionTitle;
			}
			
			return show(message, title, MessageBox.YES|MessageBox.NO, null, callBackFunction, DefaultImages.icoConfirmation, defaultButton);
		}
	}
}