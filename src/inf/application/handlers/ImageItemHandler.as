package inf.application.handlers {
	
	import inf.application.ApplicationFacade;
	import inf.application.models.ImageItemModel;
	import inf.application.proxies.ImageLoaderProxy;
	import inf.utils.Hash;
	import inf.utils.Logger;
	
	/**
	 * ImageItemHandler class
	 * Contains static methods. It is a helper class to handle the items.
	 * @author inf
	 */
	public class ImageItemHandler {
		
		/**
		 * Stored items in key. If value is false then images did not download yet else true
		 * @var Hash
		 */ 
		private static var _items:Hash;
		
		/**
		 * Tells whether handler is initialized or not
		 * @var Boolean
		 */ 
		private static var _initialized:Boolean = false;
		

		/**
		 * Initialise handler
		 */
		private static function _init():void {
			
			if (ImageItemHandler._initialized) {
				return;
			}
			
			ImageItemHandler._items = new Hash();
			
			ImageItemHandler._initialized = true;
			
		}
		
		
		/**
		 * Creates models and stores them. It will overwrite the old items
		 * @param items Array
		 */
		public static function createModelsFromArray(items:Array):void {
			
			ImageItemHandler._init();
			
			Logger.debug("Creating models...");
			
			ImageItemHandler._items = new Hash();
			var i:uint;
			for (i = 1; i <= items.length; i++) {
				ImageItemHandler.addModelFromObject(items[i - 1]);
			}
			Logger.debug("Created " + i + " models...");
		}
		
		
		/**
		 * Creates a model from the source object and store in a list
		 * @param source Object
		 */
		public static function addModelFromObject(source:Object):void {
			ImageItemHandler._init();
			var tmp:ImageItemModel = new ImageItemModel();
			tmp.populateData(source);
			ImageItemHandler._items.set(tmp, false);
		}
		
		/**
		 * Returns item list
		 * @return Hash
		 */
		public static function getItems():Hash {
			ImageItemHandler._init();
			return ImageItemHandler._items;
		}
		
		/**
		 * Returns ImageItemModel instance by id. Returns null if item not found
		 * @return ImageItemModel or null if model not found
		 */
		public static function getItemById(id:uint):ImageItemModel {
			ImageItemHandler._init();
			for (var key:Object in ImageItemHandler._items) {
				if (key.id == id) {
					return key as ImageItemModel;
				}
			}
			return null;
		}
		
		/**
		 * Removes item by model class instance
		 */
		public static function removeItem(item:ImageItemModel):void {
			ImageItemHandler._init();
			ImageItemHandler._items.remove(item);
		}
		
		/**
		 * Removes image items
		 */
		public static function removeItems():void {
			ImageItemHandler._init();
			ImageItemHandler._items.reset();
		}
		
		/**
		 * Loads images
		 */
		public static function loadImages():void {
			ImageItemHandler._init();
			
			var proxy:ImageLoaderProxy = ApplicationFacade.getInstance().retrieveProxy(ImageLoaderProxy.NAME) as ImageLoaderProxy;
			
			for (var key:Object in ImageItemHandler._items.getAll()) {
				var value:Boolean = ImageItemHandler._items.get(key);
				if (value === false) {
					proxy.loadImage(key.filePath, key.id);
				}
			}
			
		}
	}
}