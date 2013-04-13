package inf.application.views.components {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	
	/**
	 * ImageItemComponent class
	 * @author inf
	 */
	public class ImageItemComponent extends BackgroundedComponent {
		
		private var _image:DisplayObject;
		
		private var _id:uint;
		
		private var _mark:Shape; 
		
		private var _marked:Boolean;
		
		public function ImageItemComponent(id:uint, width:Number = 0, height:Number = 0, image:DisplayObject = null, align:String=BackgroundedComponent.LEFT_TOP, bgColor:uint=0xffffff, bgAlpha:Number=0, borderSize:Number=0, borderColor:uint=0, borderAlpha:Number=0) {
			super(width, height, align, bgColor, bgAlpha, borderSize, borderColor, borderAlpha);
			
			this._id = id;
			
			if (image != null) {
				this.addImage(image);
			}
			
			this._mark = new Shape();
			this.addChild(this._mark);
		}
		
		public function addImage(image:DisplayObject, marked:Boolean = false):void {
			
			if (this.contains(image)) {
				return;
			}
			
			if (this._image != null && this.contains(this._image)) {
				this.removeChild(this._image);
			}
			
			this._image = image;
			this._marked = marked;
			this.addChild(image);
		}
		
		public function get image():DisplayObject {
			return this._image;
		}
		
		public function get id():uint {
			return this._id;
		}

		public override function render():void {
			super.render();
			
			this._image.visible = true;
			
			this._mark.graphics.clear();
			
			if (this._marked) {
				this._mark.graphics.beginFill(0xff0000);
				this._mark.graphics.drawEllipse(0, 0, 10, 10);
				this._mark.graphics.endFill();
				this.setChildIndex(this._mark, this.numChildren - 1);
			}
			
		}
		
		public function getImageClone():DisplayObject {
			
			if (this._image != null) {
				
				var bmp:Bitmap = this._image as Bitmap;
				var retBmp:Bitmap = new Bitmap(bmp.bitmapData.clone());
				
				return retBmp as DisplayObject;
			}
			return null;
		}
		
	}
}