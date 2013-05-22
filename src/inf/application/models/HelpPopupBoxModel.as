package inf.application.models {
	
	/**
	 * HelpPopupBoxModel class
	 * @author inf
	 */
	public class HelpPopupBoxModel extends BoxModel {
		
		private static var _instance:HelpPopupBoxModel;
		
		private var _helpText:String;
		
		private var _btnCloseBackgroundColor:uint;
		
		private var _btnCloseBackgroundAlpha:Number;
		
		private var _btnCloseBorderSize:Number;
		
		private var _btnCloseBorderColor:uint;
		
		private var _btnCloseBorderAlpha:Number;
		
		private var _btnCloseText:String;
		
		private var _btnCloseX:Number;
		
		private var _btnCloseY:Number;
		
		private var _btnCloseHeight:Number;
		
		private var _btnCloseWidth:Number;
		
		private var _scrollWidth:uint;
		
		private var _scrollBackgroundColor:uint;
		
		private var _scrollBackgroundAlpha:Number;
		
		private var _scrollThumbWidth:Number;
		
		private var _scrollThumbHeight:Number;
		
		private var _scrollThumbColor:uint;
		
		private var _scrollBorderColor:uint;
		
		private var _scrollBorderAlpha:Number;
		
		private var _scrollBorderSize:uint;
		
		private var _scrollLimitTop:int;
		
		private var _scrollLimitBottom:int;
		
		private var _scrollPaneBorderColor:uint;
		
		private var _scrollPaneBorderSize:Number;
		
		private var _scrollPaneBorderAlpha:Number;
		
		private var _scrollPaneBackgroundColor:uint;
		
		private var _scrollPaneBackgroundAlpha:Number;
		
		private var _spaceBetweenScrollAndList:int;
		
		
		
		public function HelpPopupBoxModel(enforcer:SingletonEnforcer) {
			super();
			HelpPopupBoxModel._instance = this;
		}
		
		public static function getInstance():HelpPopupBoxModel {
			return (HelpPopupBoxModel._instance != null) ? HelpPopupBoxModel._instance : new HelpPopupBoxModel(new SingletonEnforcer);
		}
		
		internal function setHelpText(value:String):void {
			this._helpText = unescape(value).replace(/\+/g, " ");
		}
		
		internal function setBtnCloseBackgroundColor(value:uint):void {
			this._btnCloseBackgroundColor = value;
		}
		
		internal function setBtnCloseBackgroundAlpha(value:Number):void {
			this._btnCloseBackgroundAlpha = value;
		}
		
		internal function setBtnCloseBorderColor(value:uint):void {
			this._btnCloseBorderColor = value;
		}
		
		internal function setBtnCloseBorderAlpha(value:Number):void {
			this._btnCloseBorderAlpha = value;
		}
		
		internal function setBtnCloseBorderSize(value:Number):void {
			this._btnCloseBorderSize = value;
		}
		
		internal function setBtnCloseText(value:String):void {
			this._btnCloseText = unescape(value).replace(/\+/g, " ");
		}
		
		internal function setBtnCloseX(value:Number):void {
			this._btnCloseX = value;
		}
		
		internal function setBtnCloseY(value:Number):void {
			this._btnCloseY = value;
		}
		
		internal function setBtnCloseWidth(value:Number):void {
			this._btnCloseWidth = value;
		}
		
		internal function setBtnCloseHeight(value:Number):void {
			this._btnCloseHeight = value;
		}
		
		internal function setScrollWidth(value:uint):void {
			this._scrollWidth = value;
		}
		
		internal function setSpaceBetweenScrollAndList(value:int):void {
			this._spaceBetweenScrollAndList = value;
		}
		
		internal function setScrollBackgroundColor(value:uint):void {
			this._scrollBackgroundColor = value;
		}
		
		internal function setScrollBackgroundAlpha(value:Number):void {
			this._scrollBackgroundAlpha = value;
		}
		
		internal function setScrollThumbWidth(value:Number):void {
			this._scrollThumbWidth = value;
		}
		
		internal function setScrollThumbHeight(value:Number):void {
			this._scrollThumbHeight = value;
		}
		
		internal function setScrollThumbColor(value:uint):void {
			this._scrollThumbColor = value;
		}
		
		internal function setScrollBorderColor(value:uint):void {
			this._scrollBorderColor = value;
		}
		
		internal function setScrollBorderAlpha(value:Number):void {
			this._scrollBorderAlpha = value;
		}
		
		internal function setScrollBorderSize(value:uint):void {
			this._scrollBorderSize = value;
		}
		
		internal function setScrollLimitTop(value:int):void {
			this._scrollLimitTop = value;
		}
		
		internal function setScrollLimitBottom(value:int):void {
			this._scrollLimitBottom = value;
		}
		
		internal function setScrollPaneBorderColor(value:uint):void {
			this._scrollPaneBorderColor = value;
		}
		
		internal function setScrollPaneBorderAlpha(value:Number):void {
			this._scrollPaneBorderAlpha = value;
		}
		
		internal function setScrollPaneBorderSize(value:Number):void {
			this._scrollPaneBorderSize = value;
		}
		
		internal function setScrollPaneBackgroundAlpha(value:Number):void {
			this._scrollPaneBackgroundAlpha = value;
		}
		
		internal function setScrollPaneBackgroundColor(value:uint):void {
			this._scrollPaneBackgroundColor = value;
		}
		
		public function get helpText():String {
			return this._helpText;
		}
		
		public function get btnCloseBackgroundColor():uint {
			return this._btnCloseBackgroundColor;
		}
		
		public function get btnCloseBackgroundAlpha():Number {
			return this._btnCloseBackgroundAlpha;
		}
		
		public function get btnCloseBorderColor():uint {
			return this._btnCloseBorderColor;
		}
		
		public function get btnCloseBorderAlpha():Number {
			return this._btnCloseBorderAlpha;
		}
		
		public function get btnCloseBorderSize():Number {
			return this._btnCloseBorderSize;
		}
		
		public function get btnCloseText():String {
			return this._btnCloseText;
		}
		
		public function get btnCloseX():Number {
			return this._btnCloseX;
		}
		
		public function get btnCloseY():Number {
			return this._btnCloseY;
		}
		
		public function get btnCloseWidth():Number {
			return this._btnCloseWidth;
		}
		
		public function get btnCloseHeight():Number {
			return this._btnCloseHeight;
		}
		
		public function get scrollWidth():uint {
			return this._scrollWidth;
		}
		
		public function get spaceBetweenScrollAndList():int {
			return this._spaceBetweenScrollAndList;
		}
		
		public function get scrollBackgroundColor():uint {
			return this._scrollBackgroundColor;
		}
		
		public function get scrollBackgroundAlpha():Number {
			return this._scrollBackgroundAlpha;
		}
		
		public function get scrollThumbWidth():Number {
			return this._scrollThumbWidth;
		}
		
		public function get scrollThumbHeight():Number {
			return this._scrollThumbHeight;
		}
		
		public function get scrollThumbColor():uint {
			return this._scrollThumbColor;
		}
		
		public function get scrollBorderColor():uint {
			return this._scrollBorderColor;
		}
		
		public function get scrollBorderAlpha():Number {
			return this._scrollBorderAlpha;
		}
		
		public function get scrollBorderSize():uint {
			return this._scrollBorderSize;
		}
		
		public function get scrollLimitTop():int {
			return this._scrollLimitTop;
		}
		
		public function get scrollLimitBottom():int {
			return this._scrollLimitBottom;
		}
		
		public function get scrollPaneBorderColor():int {
			return this._scrollPaneBorderColor;
		}
		
		public function get scrollPaneBorderSize():Number {
			return this._scrollPaneBorderSize;
		}
		
		public function get scrollPaneBorderAlpha():Number {
			return this._scrollPaneBorderAlpha;
		}
		
		public function get scrollPaneBackgroundColor():int {
			return this._scrollPaneBackgroundColor;
		}
		
		public function get scrollPaneBackgroundAlpha():Number {
			return this._scrollPaneBackgroundAlpha;
		}
		
	}
	
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}