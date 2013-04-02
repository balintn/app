package inf.application.models {
	
	/**
	 * ImageItemModel class
	 * @author inf
	 */
	public class ImageItemModel extends BaseModel {
		
		
		private var _id:uint;
		
		private var _title:String;
		
		private var _filePath:String;
		
		private var _marked:Boolean; 
		
		
		public function ImageItemModel() {
			super();
		}
		
		internal function setId(value:uint):void {
			this._id = value;	
		}
		
		internal function setTitle(value:String):void {
			this._title = value;	
		}
		
		internal function setFilePath(value:String):void {
			this._filePath = value;
		}
		
		internal function setMarked(value:uint):void {
			this._marked = value as Boolean;
		}
		
		public function get id():uint {
			return this._id;
		}
		
		public function get title():String {
			return this._title;
		}
		
		public function get filePath():String {
			return this._filePath;
		}
		
		public function get marked():Boolean {
			return this._marked;
		}
		
	}
}