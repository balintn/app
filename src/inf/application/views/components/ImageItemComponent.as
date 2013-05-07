package inf.application.views.components {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ImageItemComponent class
	 * @author inf
	 */
	public class ImageItemComponent extends BackgroundedComponent {
		
		private var _image:DisplayObject;
		
		private var _id:uint;
		
		private var _mark:Shape; 
		
		private var _marked:Boolean;
		
		private var _titleTextField:TextField;
		
		private var _titleBackground:BackgroundedComponent;
		
		
		public function ImageItemComponent(id:uint, width:Number = 0, height:Number = 0, image:DisplayObject = null, align:String=BackgroundedComponent.LEFT_TOP, bgColor:uint=0xffffff, bgAlpha:Number=0, borderSize:Number=0, borderColor:uint=0, borderAlpha:Number=0) {
			super(width, height, align, bgColor, bgAlpha, borderSize, borderColor, borderAlpha);
			
			this._id = id;
			
			if (image != null) {
				this.addImage(image);
			}
			
			this._mark = new Shape();
			this.addChild(this._mark);
		}
		
		public function addTitleText(label:String):void {
			
			if (this._titleBackground == null) {
				this._titleBackground = new BackgroundedComponent();
			}
			
			if (! this.contains(this._titleBackground)) {
				this.addChild(this._titleBackground);
			}
			
			if (this._titleTextField == null) {
				this._titleTextField = new TextField();
				this._titleTextField.multiline = true;
				this._titleTextField.autoSize = TextFieldAutoSize.LEFT;
				this._titleTextField.wordWrap = true;
			}
			
			if (! this._titleBackground.contains(this._titleTextField)) {
				this._titleBackground.addChild(this._titleTextField);
			}
			
			this._titleTextField.htmlText = label;
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
		
		public function get titleBackground():BackgroundedComponent {
			return this._titleBackground;
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
			
			if (this._titleBackground == null) {
				this.addTitleText("");
			}
			this._titleBackground.width = this._image.width;
			this._titleBackground.y = this._image.height;
			// todo ez miezitt?? ejnye no...
			this._titleTextField.width = this._image.width;
			this._titleBackground.height = this._titleTextField.height;
			
			this.height = this._image.height + this._titleBackground.height;
			
			this._titleBackground.render();
			
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