package inf.application.models {
	
	/**
	 * EditorBoxModel class (singleton)
	 * @author inf
	 */
	public class EditorBoxModel extends BoxModel {
		
		private static var _instance:EditorBoxModel;
		
		private var _btnUploadBackgroundColor:uint;
		
		private var _btnUploadBackgroundAlpha:Number;
		
		private var _btnUploadBorderSize:Number;
		
		private var _btnUploadBorderColor:uint;
		
		private var _btnUploadBorderAlpha:Number;
		
		private var _btnUploadText:String;
		
		private var _btnEraseBackgroundColor:uint;
		
		private var _btnEraseBackgroundAlpha:Number;
		
		private var _btnEraseBorderSize:Number;
		
		private var _btnEraseBorderColor:uint;
		
		private var _btnEraseBorderAlpha:Number;
		
		private var _btnEraseText:String;
		
		
		
		public function EditorBoxModel(enforcer:SingletonEnforcer) {
			super();
			EditorBoxModel._instance = this;
		}
		
		public static function getInstance():EditorBoxModel {
			return (EditorBoxModel._instance != null) ? EditorBoxModel._instance : new EditorBoxModel(new SingletonEnforcer);
		}
		
		internal function setBtnUploadBackgroundColor(value:uint):void {
			this._btnUploadBackgroundColor = value;
		}
		
		internal function setBtnUploadBackgroundAlpha(value:Number):void {
			this._btnUploadBackgroundAlpha = value;
		}
		
		internal function setBtnUploadBorderColor(value:uint):void {
			this._btnUploadBorderColor = value;
		}
		
		internal function setBtnUploadBorderAlpha(value:Number):void {
			this._btnUploadBorderAlpha = value;
		}
		
		internal function setBtnUploadBorderSize(value:Number):void {
			this._btnUploadBorderSize = value;
		}
		
		internal function setBtnUploadText(value:String):void {
			this._btnUploadText = value;
		}
		
		internal function setBtnEraseBackgroundColor(value:uint):void {
			this._btnEraseBackgroundColor = value;
		}
		
		internal function setBtnEraseBackgroundAlpha(value:Number):void {
			this._btnEraseBackgroundAlpha = value;
		}
		
		internal function setBtnEraseBorderColor(value:uint):void {
			this._btnEraseBorderColor = value;
		}
		
		internal function setBtnEraseBorderAlpha(value:Number):void {
			this._btnEraseBorderAlpha = value;
		}
		
		internal function setBtnEraseBorderSize(value:Number):void {
			this._btnEraseBorderSize = value;
		}
		
		internal function setBtnEraseText(value:String):void {
			this._btnEraseText = value;
		}
		
		
		public function get btnUploadBackgroundColor():uint {
			return this._btnUploadBackgroundColor;
		}
		
		public function get btnUploadBackgroundAlpha():Number {
			return this._btnUploadBackgroundAlpha;
		}
		
		public function get btnUploadBorderColor():uint {
			return this._btnUploadBorderColor;
		}
		
		public function get btnUploadBorderAlpha():Number {
			return this._btnUploadBorderAlpha;
		}
		
		public function get btnUploadBorderSize():Number {
			return this._btnUploadBorderSize;
		}
		
		public function get btnUploadText():String {
			return this._btnUploadText;
		}
		
		public function get btnEraseBackgroundColor():uint {
			return this._btnEraseBackgroundColor;
		}
		
		public function get btnEraseBackgroundAlpha():Number {
			return this._btnEraseBackgroundAlpha;
		}
		
		public function get btnEraseBorderColor():uint {
			return this._btnEraseBorderColor;
		}
		
		public function get btnEraseBorderAlpha():Number {
			return this._btnEraseBorderAlpha;
		}
		
		public function get btnEraseBorderSize():Number {
			return this._btnEraseBorderSize;
		}
		
		public function get btnEraseText():String {
			return this._btnEraseText;
		}
	}
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}