package inf.application.models {
	
	/**
	 * HelpPopupBoxModel class
	 * @author inf
	 */
	public class HelpPopupBoxModel extends BoxModel {
		
		private static var _instance:HelpPopupBoxModel;
		
		private var _helpText:String;
		
		public function HelpPopupBoxModel() {
			super();
			HelpPopupBoxModel._instance = this;
		}
		
		public function EditorBoxModel(enforcer:SingletonEnforcer) {
			super();
			HelpPopupBoxModel._instance = this;
		}
		
		public static function getInstance():EditorBoxModel {
			return (HelpPopupBoxModel._instance != null) ? HelpPopupBoxModel._instance : new EditorBoxModel(new SingletonEnforcer);
		}
		
		internal function setHelpText(value:String):void {
			this._helpText = unescape(value).replace(/\+/g, " ");
		}
		
		public function get helpText():String {
			return this._helpText;
		}
		
	}
	
}
class SingletonEnforcer {
	function SingletonEnforcer():void {}
}