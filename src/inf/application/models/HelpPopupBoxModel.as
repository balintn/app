package inf.application.models {
	
	/**
	 * HelpPopupBoxModel class
	 * @author inf
	 */
	public class HelpPopupBoxModel extends BoxModel {
		
		private static var _instance:HelpPopupBoxModel;
		
		public function HelpPopupBoxModel() {
			super();
		}
		
		public function EditorBoxModel(enforcer:SingletonEnforcer) {
			super();
			HelpPopupBoxModel._instance = this;
		}
		
		public static function getInstance():EditorBoxModel {
			return (HelpPopupBoxModel._instance != null) ? HelpPopupBoxModel._instance : new EditorBoxModel(new SingletonEnforcer);
		}
	}
	
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}