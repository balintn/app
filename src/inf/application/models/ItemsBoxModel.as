package inf.application.models {
	
	/**
	 * ItemsBoxModel class (singleton)
	 * @author inf
	 */
	public class ItemsBoxModel extends BoxModel {
		
		private static var _instance:ItemsBoxModel;
		
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
		
		private var _itemWidth:int;
		
		private var _spaceBetweenItems:int;
		
		private var _titleColor:uint;
		
		private var _titleBackgroundColor:uint;
		
		private var _titleBackgroundAlpha:Number;
		
		
		public function ItemsBoxModel(enforcer:SingletonEnforcer) {
			super();
			ItemsBoxModel._instance = this;
		}
		
		public static function getInstance():ItemsBoxModel {
			return (ItemsBoxModel._instance != null) ? ItemsBoxModel._instance : new ItemsBoxModel(new SingletonEnforcer);
		}
		
		internal function setScrollWidth(value:uint):void {
			this._scrollWidth = value;
		}
		
		internal function setSpaceBetweenScrollAndList(value:int):void {
			this._spaceBetweenScrollAndList = value;
		}
		
		internal function setItemWidth(value:int):void {
			this._itemWidth = value;
		}
		
		internal function setSpaceBetweenItems(value:int):void {
			this._spaceBetweenItems = value;
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
		
		internal function setTitleColor(value:uint):void {
			this._titleColor = value;
		}
		
		internal function setTitleBackgroundColor(value:uint):void {
			this._titleBackgroundColor = value;
		}
		
		internal function setTitleBackgroundAlpha(value:Number):void {
			this._titleBackgroundAlpha = value;
		}

		
		
		public function get scrollWidth():uint {
			return this._scrollWidth;
		}
		
		public function get spaceBetweenScrollAndList():int {
			return this._spaceBetweenScrollAndList;
		}
		
		public function get itemWidth():int {
			return this._itemWidth;
		}
		
		public function get spaceBetweenItems():int {
			return this._spaceBetweenItems;
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
		
		public function get titleColor():uint {
			return this._titleColor;
		}
		
		public function get titleBackgroundColor():Number {
			return this._titleBackgroundColor;
		}
		
		public function get titleBackgroundAlpha():Number {
			return this._titleBackgroundAlpha;
		}
				
	}
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}