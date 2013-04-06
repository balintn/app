package inf.application.views.components {
	import flash.display.DisplayObject;
	
	/**
	 * ImageItemComponent class
	 * @author inf
	 */
	public class ImageItemComponent extends BackgroundedSprite {
		
		private var _image:DisplayObject;
		
		public function ImageItemComponent(width, height, image:DisplayObject = null, align:String=BackgroundedSprite.LEFT_TOP, bgColor:uint=0xffffff, bgAlpha:Number=0, borderSize:Number=0, borderColor:uint=0, borderAlpha:Number=0) {
			super(width, height, align, bgColor, bgAlpha, borderSize, borderColor, borderAlpha);
			
			if (image != null) {
				this.addImage(image);
			}
		}
		
		public function addImage(image:DisplayObject):void {
			
			if (this.contains(image)) {
				return;
			}
			
			if (this._image != null && this.contains(this._image)) {
				this.removeChild(this._image);
			}
			
			this._image = image;
			this.addChild(image);
		}
		

		public override function render():void {
			this._image.visible = true;
		}
	}
}