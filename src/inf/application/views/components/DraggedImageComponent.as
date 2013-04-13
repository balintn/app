package inf.application.views.components {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * DraggedImageComponent class
	 * @author inf
	 */
	public class DraggedImageComponent extends Sprite {
		
		private var _image:DisplayObject;
		
		public function DraggedImageComponent() {
			super();
		}
		
		public function addImage(image:DisplayObject):void {
			if (this._image != null) {
				this.removeImage();
			}
			
			this.addChild(image);
			this._image = image;
		}
		
		public function removeImage():void {
			if (this._image != null) {
				if (this.contains(this._image)) {
					this.removeChild(this._image);
				}
				this._image = null;
			}
		}
	}
}