package inf.application.models {
	
	/**
	 * VO class
	 * @inf 
	 */
	internal class Model {
		
		/**
		 * Constructor
		 * @param Object source populates data from this object 
		 */
		internal function Model(source:Object = null){
			if (source != null) this._initializeData(source);
		}
		
		/**
		 * Initializes the model properties with the values given in source
		 * @param Object source 
		 */ 
		private function _initializeData(source:Object):void{
			for (var key:String in source){
				if (this.hasOwnProperty(key)) this["_" + key] = source[key];
			}
		}
	}
}