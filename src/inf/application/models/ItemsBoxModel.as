package inf.application.models {
	
	/**
	 * ItemsBoxModel class (singleton)
	 * @author inf
	 */
	public class ItemsBoxModel extends BoxModel {
		
		private static var _instance:ItemsBoxModel;
		
		private var _scrollWidth:uint;
		
		private var _spaceBetweenScrollAndList:int;
		
		private var _itemWidth:int;
		
		private var _itemHeight:int;
		
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
		
		internal function setItemHeight(value:int):void {
			this._itemHeight = value;
		}
		
		internal function setSpaceBetweenItems(value:int):void {
			this._spaceBetweenItems = value;
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
		
		public function get itemHeight():int {
			return this._itemHeight;
		}
		
		public function get spaceBetweenItems():int {
			return this._spaceBetweenItems;
		}
	}
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}