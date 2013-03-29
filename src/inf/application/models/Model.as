package inf.application.models {
	import inf.utils.Logger;
	
	/**
	 * Internal abstract Model class
	 * You have to extend this class (in this package) and override <code>_initializeData()</code> method
	 *  
	 * @author inf 
	 */
	internal class Model {
		
		/**
		 * Tells whether model initialized
		 * @var Boolean
		 */
		private var _initialized:Boolean = false;
		
		/**
		 * Constructor
		 * @param Object source populates data from this object 
		 */
		public function Model(source:Object = null){
			if (source != null) this._initializeData(source);
		}
		
		/**
		 * Abstract method
		 * Initializes the model properties with the values given in source
		 * @param Object source
		 * @throw Error throws error if failed to initialize model
		 */ 
		protected function _initializeData(source:Object):void {
			throw new Error("This is an abstract method, you must override and implement it!");
		}
		
		/**
		 * Populates data with the given source object		 * 
		 */
		public function populateData(source:Object):void {
			
			if (! this._initialized) {
				try {
					this._initializeData(source);
					this._initialized = true;
				} catch (e:Error) {
					Logger.error("Failed to initialize model data! Exception: " + e.message);
				}
			} else {
				Logger.warn("Model already initilazed!");
			}
		}
		
		/**
		 * Returns if model initialized
		 * @return Boolean
		 */
		public function get initialized():Boolean {
			return this._initialized;
		}
	}
}