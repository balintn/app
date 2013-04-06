package inf.application.models {
	
	/**
	 * ItemsBoxModel class (singleton)
	 * @author inf
	 */
	public class ItemsBoxModel extends BoxModel {
		
		private static var _instance:ItemsBoxModel;
		
		private var _scrollWidth:uint;
		
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
		
		public function get scrollWidth():uint {
			return this._scrollWidth;
		}
	}
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}