package inf.application.models {
	import inf.utils.Logger;
	
	/**
	 * EnvironmentModel class (singleton)
	 * Use <code>EnvironmentModel.getInstance()</code> method to get instance
	 * @author inf
	 */
	public final class EnvironmentModel extends Model {
		
		/**
		 * Editor align left
		 * @var String
		 */
		public static const EDITOR_ALIGN_LEFT:String = "left";
		
		/**
		 * Editor align right
		 * @var String
		 */
		public static const EDITOR_ALIGN_RIGHT:String = "right";
		

		/**
		 * App border color
		 * @var uint
		 */
		private var _mainBorderColor:uint;
		
		/**
		 * Editor align
		 * @var String
		 */
		private var _editorColumnAlign:String;
		
		/**
		 * Editor column width
		 * @var uint
		 */
		private var _editorColumnWidth:uint;
		
		/**
		 * Editor background color
		 * @var uint
		 */
		private var _editorColumnBackgroundColor:uint;
		
		/**
		 * Thumbnail list column widht
		 * @var uint
		 */
		private var _thumbColumnWidth:uint;
		
		/**
		 * Thumbnail list background color
		 * @var uint
		 */ 
		private var _thumbColumnBackgroundColor:uint;
		
		/**
		 * Inner border color
		 * @var uint
		 */
		private var _innerBorderColor:uint;
		
		/**
		 * Base url
		 * @var String
		 */
		private var _baseUrl:String;
		
		private static var _instance:EnvironmentModel;
		
		
		public function EnvironmentModel(singleton:SingletonEnforcer) {
			EnvironmentModel._instance = this;
			super();
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
		
		
		public function get mainBorderColor():uint {
			return this._mainBorderColor;
		}
		
		public function get editorColumnAlign():String {
			return this._editorColumnAlign;
		}
		
		public function get editorColumnWidth():uint {
			return this._editorColumnWidth;
		}
		
		public function get editorColumnBackgroundColor():uint {
			return this._editorColumnBackgroundColor;
		}
		
		public function get thumbColumnWidth():uint {
			return this._thumbColumnWidth;
		}
		
		public function get thumbColumnBackgroundColor():uint {
			return this._thumbColumnBackgroundColor;
		}
		
		public function get innerBorderColor():uint {
			return this._innerBorderColor;
		}
		
		public function get baseUrl():String {
			return this._baseUrl;
		}
		
		
		private function setMainBorderColor(value:String):void {
			this._mainBorderColor = value as uint;
		}
		
		public function setEditorColumnAlign(value:String):void {
			
			switch (value) {
				case EnvironmentModel.EDITOR_ALIGN_LEFT:
				case EnvironmentModel.EDITOR_ALIGN_RIGHT:
					this._editorColumnAlign = value;		
					break;
				
				default:
					Logger.warn("Unknown editor align value! Using default value (EnvironmentModel.EDITOR_ALIGN_LEFT)");
					this._editorColumnAlign = EnvironmentModel.EDITOR_ALIGN_LEFT;
			}
			
		}
		
		public function setEditorColumnWidth(value:String):void {
			this._editorColumnWidth = parseInt(value);
		}
		
		public function setEditorColumnBackgroundColor(value:String):void {
			this._editorColumnBackgroundColor = parseInt(value, 16);
		}
		
		public function setThumbColumnWidth(value:String):void {
			this._thumbColumnWidth = parseInt(value);
		}
		
		public function setThumbColumnBackgroundColor(value:String):void {
			this._thumbColumnBackgroundColor = parseInt(value, 16);
		}
		
		public function setInnerBorderColor(value:String):void {
			this._innerBorderColor = parseInt(value, 16);
		}
		
		protected function setBaseUrl(value:String):void {
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