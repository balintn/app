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
		 * Base url
		 * @var String
		 */
		private var _baseUrl:String;
		
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
		
		public function get baseUrl():String {
			return this._baseUrl;
		}
		
		internal function setAppBackgroundColor(value:String):void {
			this._appBackgroundColor = parseInt(value, 16);
		}
		
		internal function setAppBackgroundAlpha(value:Number):void {
			this._appBackgroundAlpha = value;
		}
		
		internal function setBaseUrl(value:String):void {
			this._baseUrl = value;
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