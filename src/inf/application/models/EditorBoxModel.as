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
		
		private var _btnUploadX:Number;
		
		private var _btnUploadY:Number;
		
		private var _btnUploadHeight:Number;
		
		private var _btnUploadWidth:Number;
		
		private var _btnEraseBackgroundColor:uint;
		
		private var _btnEraseBackgroundAlpha:Number;
		
		private var _btnEraseBorderSize:Number;
		
		private var _btnEraseBorderColor:uint;
		
		private var _btnEraseBorderAlpha:Number;
		
		private var _btnEraseText:String;
		
		private var _btnEraseX:Number;
		
		private var _btnEraseY:Number;
		
		private var _btnEraseHeight:Number;
		
		private var _btnEraseWidth:Number;
		
		
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
			this._btnUploadText = unescape(value).replace(/\+/g, " ");
		}
		
		internal function setBtnUploadX(value:Number):void {
			this._btnUploadX = value;
		}
		
		internal function setBtnUploadY(value:Number):void {
			this._btnUploadY = value;
		}
		
		internal function setBtnUploadWidth(value:Number):void {
			this._btnUploadWidth = value;
		}
		
		internal function setBtnUploadHeight(value:Number):void {
			this._btnUploadHeight = value;
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
			this._btnEraseText = unescape(value).replace(/\+/g, " ");
		}
		
		internal function setBtnEraseX(value:Number):void {
			this._btnEraseX = value;
		}
		
		internal function setBtnEraseY(value:Number):void {
			this._btnEraseY = value;
		}
		
		internal function setBtnEraseWidth(value:Number):void {
			this._btnEraseWidth = value;
		}
		
		internal function setBtnEraseHeight(value:Number):void {
			this._btnEraseHeight = value;
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
		
		public function get btnUploadX():Number {
			return this._btnUploadX;
		}
		
		public function get btnUploadY():Number {
			return this._btnUploadY;
		}
		
		public function get btnUploadWidth():Number {
			return this._btnUploadWidth;
		}
		
		public function get btnUploadHeight():Number {
			return this._btnUploadHeight;
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
		
		public function get btnEraseX():Number {
			return this._btnEraseX;
		}
		
		public function get btnEraseY():Number {
			return this._btnEraseY;
		}
		
		public function get btnEraseWidth():Number {
			return this._btnEraseWidth;
		}
		
		public function get btnEraseHeight():Number {
			return this._btnEraseHeight;
		}
	}
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}