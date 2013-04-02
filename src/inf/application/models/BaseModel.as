package inf.application.models {
	import inf.utils.Logger;
	
	/**
	 * BaseModel class
	 * @author inf
	 */
	public class BaseModel extends Model {
		
		public function BaseModel(source:Object=null) {
			super(source);
		}
		
		/**
		 * Initializes the model properties with the values given in source
		 * @param Object source
		 * @throw Error throws error if failed to initialize model
		 */ 
		protected override function _initializeData(source:Object):void {
			
			for (var key:String in source) {
				var funcName:String = "set" + key.charAt(0).toUpperCase() + key.substr(1);
				try {
					this[funcName](source[key]);
				} catch(e:Error) {
					Logger.error("Failed to initialize EnvironmentModel! Exeception: " + e.message);
				}
			}
		}
	}
}