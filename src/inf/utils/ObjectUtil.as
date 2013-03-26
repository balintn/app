package inf.utils {
	
	
	/**
	 * Static methods to help us handling objects
	 * 
	 * @author inf
	 */
	public final class ObjectUtil {
		
		/**
		 * Returns how many key exits in an object
		 * @param Object
		 * @return uint
		 */
		public static function numberOfObjectProperty(obj:Object):uint {
			
			var length:uint = 0;
			
			for (var key:String in obj) {
				length++;
			}
			return length;
		}
		
		
		/**
		 * Checks recursively if object key exists
		 * @param Object
		 * @param Array
		 * @return Boolean
		 */ 
		public static function deepObjectKeyExists(target:*, keys:Array):Boolean {
			
			if (target == null || keys == null || keys.length <= 0) {
				return false;
			}
			
			var key:* = keys.shift();
			
			if (typeof(target) == "object") {
				if (target.hasOwnProperty(key)) {
					if (keys.length > 0) {
						return ObjectUtil.deepObjectKeyExists(target[key], keys);
					} else {
						return true;
					}
				} else {
					return false;
				}
			}
			return false;
		}
	}
}