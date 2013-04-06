package inf.utils {
	import flash.utils.Dictionary;
	
	/**
	 * Hash class
	 * @author inf
	 */
	public class Hash {
		
		/**
		 * @var Object elements
		 */
		private var _elements:Dictionary;
		
		
		/**
		 * Constructor
		 */
		public function Hash() {
			this._elements = new Dictionary();
		}
		
		
		/**
		 * Gets an element from hash by key or returns defValue parameter if not found
		 * @param Object key
		 * @param Object default value
		 * @return Object
		 */
		public function get(key:Object, defValue:Object = null):Object {
			for (var listItemKey:Object in this._elements) {
				if (listItemKey === key) {
					return this._elements[key];
				}
			}
			return null;
		}
		
		
		/**
		 * Returns elements object
		 * @return Dictionary
		 */
		public function getAll():Dictionary {
			return this._elements;
		}
		
		
		/**
		 * Returns all hash elements in an array
		 * @return Array
		 */
		public function getAllInArray():Array {
			var ret:Array = [];
			for each (var item:Object in this._elements) {
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
		 * Removes element from hash by key
		 */
		public function remove(key:Object):void {
			if (this._elements.hasOwnProperty(key)) {
				delete this._elements[key];
			}
		}
		
		/**
		 * Resets hash
		 */
		public function reset():void {
			this._elements = new Dictionary();
		}
		
	}
}