package inf.application.models {
	
	/**
	 * EditorBoxModel class (singleton)
	 * @author inf
	 */
	public class EditorBoxModel extends BoxModel {
		
		private static var _instance:EditorBoxModel;
		
		public function EditorBoxModel(enforcer:SingletonEnforcer) {
			super();
			EditorBoxModel._instance = this;
		}
		
		public static function getInstance():EditorBoxModel {
			return (EditorBoxModel._instance != null) ? EditorBoxModel._instance : new EditorBoxModel(new SingletonEnforcer);
		}
	}
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}