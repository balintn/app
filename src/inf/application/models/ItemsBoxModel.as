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
		
		private var _spaceBetweenScrollAndList:int;
		
		private var _itemWidth:int;
		
		private var _spaceBetweenItems:int;
		
		
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
		
		internal function setScrollThumbColor(value:Number):void {
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
	}
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}