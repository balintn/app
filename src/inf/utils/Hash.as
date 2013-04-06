package inf.utils {
	
	/**
	 * Hash class
	 * @author inf
	 */
	public class Hash {
		
		/**
		 * @var Object elements
		 */
		private var _elements:Object;
		
		
		/**
		 * Constructor
		 */
		public function Hash() {
			this._elements = {};
		}
		
		
		/**
		 * Gets an element from hash by key or returns defValue parameter if not found
		 * @param Object key
		 * @param Object default value
		 * @return Object
		 */
		public function get(key:Object, defValue:Object = null):Object {
			return this._elements.hasOwnProperty(key) ? this._elements[key] : defValue;
		}
		
		
		/**
		 * Returns elements object
		 * @return Object
		 */
		public function getAll():Object {
			return this._elements;
		}
		
		
		/**
		 * Returns all hash elements in an array
		 * @return Array
		 */
		public function getAllInArray():Array {
			var ret:Array = [];
			for (var item:Object in this._elements) {
				ret.push(item);
			}
			return ret;
		}
		
		
		/**
		 * Sets element
		 * @param Object key
		 * @param Object value
		 * @return Object value
		 */
		public function set(key:Object, value:Object = null):Object {
			this._elements[key] = value;
			return value;
		}
		
		/**
		 * Resets hash
		 */
		public function reset():void {
			this._elements = {};
		}
		
	}
}