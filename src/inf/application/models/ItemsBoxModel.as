package inf.application.models {
	
	/**
	 * ItemsBoxModel class (singleton)
	 * @author inf
	 */
	public class ItemsBoxModel extends BoxModel {
		
		private static var _instance:ItemsBoxModel;
		
		public function ItemsBoxModel(enforcer:SingletonEnforcer) {
			super();
			ItemsBoxModel._instance = this;
		}
		
		public static function getInstance():ItemsBoxModel {
			return (ItemsBoxModel._instance != null) ? ItemsBoxModel._instance : new ItemsBoxModel(new SingletonEnforcer);
		}
	}
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}