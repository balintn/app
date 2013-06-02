package inf.application.models {
	import inf.utils.Logger;
	
	/**
	 * EnvironmentModel class (singleton)
	 * Use <code>EnvironmentModel.getInstance()</code> method to get instance
	 * @author inf
	 */
	public final class EnvironmentModel extends BaseModel {
		
		
		/**
		 * App background color
		 * @var uint
		 */
		private var _appBackgroundColor:uint;
		
		/**
		 * App background alpha
		 * @var uint
		 */
		private var _appBackgroundAlpha:Number;
		
		/**
		 * Help icon url
		 * @var String
		 */
		private var _helpIcon:String;
		
		/**
		 * Singleton instance
		 * @var EnvironmentModel
		 */
		private static var _instance:EnvironmentModel;
		
		
		public function EnvironmentModel(singleton:SingletonEnforcer) {
			EnvironmentModel._instance = this;
			super();
		}
		
		public function get appBackgroundColor():uint {
			return this._appBackgroundColor;
		}
		
		public function get appBackgroundAlpha():Number {
			return this._appBackgroundAlpha;
		}

		public function get helpIcon():String {
			return this._helpIcon;
		}
		
		internal function setAppBackgroundColor(value:uint):void {
			this._appBackgroundColor = value;
		}
		
		internal function setAppBackgroundAlpha(value:Number):void {
			this._appBackgroundAlpha = value;
		}
		
		internal function setHelpIcon(value:String):void {
			this._helpIcon = value;
		}
		
		/**
		 * Returns EnvironmentModel instance
		 * @return EnvironmentModel
		 */
		public static function getInstance():EnvironmentModel {
			return (EnvironmentModel._instance != null) ? EnvironmentModel._instance : new EnvironmentModel(new SingletonEnforcer);
		}
		
		
		
	}
}

class SingletonEnforcer {
	function SingletonEnforcer():void {}
}