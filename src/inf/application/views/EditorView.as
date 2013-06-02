package inf.application.views {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import inf.application.models.EditorBoxModel;
	import inf.application.views.components.BackgroundedComponent;
	import inf.application.views.components.BoxComponent;
	import inf.application.views.components.ButtonComponent;
	
	/**
	 * EditorView class
	 * @author inf
	 */
	public class EditorView extends BoxComponent {
		
		public static var PADDING:int = 20;
		
		private var _uploadButton:ButtonComponent;
		private var _clearButton:ButtonComponent;
		private var _imageContainer:BackgroundedComponent;
		private var _imageContainerMask:Shape;
		private var _loadedImage:DisplayObject;
		private var _helpIcon:Sprite;
		
		public function EditorView(model:EditorBoxModel) {
			super(model);
			
			this._clearButton = new ButtonComponent();
			this.addChild(this._clearButton);
			
			this._uploadButton = new ButtonComponent();
			this.addChild(this._uploadButton);
			
			this._imageContainer = new BackgroundedComponent();
			this._imageContainer.backgroundAlpha = 0;
			this._imageContainer.borderColor = 0xc3c3c3;
			this._imageContainer.borderSize = 0;
			this.addChild(this._imageContainer);
			
			this._helpIcon = new Sprite();
			this.addChild(this._helpIcon);
			
			this._imageContainerMask = new Shape();
			this.addChild(this._imageContainerMask);
			
		}
		
		public override function render():void {
			super.render();
			
			// TODO ezt es az ilyeneket majd irtani, csinalni szepen paddinget a modellnek
			this._imageContainer.x = EditorView.PADDING;
			this._imageContainer.y = EditorView.PADDING;
			this._imageContainer.width = this.width - 2 * EditorView.PADDING;
			this._imageContainer.height = this.height - 2 * EditorView.PADDING;
			
			// create mask
			this._imageContainer.mask = this.createContainerMask();
			
			this._imageContainer.render();
			this._uploadButton.render();
			this._clearButton.render();
			
			this.setChildIndex(this._uploadButton, this.numChildren - 1);
			this.setChildIndex(this._clearButton, this.numChildren - 1);
			
		}
		
		private function createContainerMask():Shape {
			
			var mg:Graphics = this._imageContainerMask.graphics;
			
			mg.clear();
			mg.beginFill(0xff0000,1);
			mg.drawRect(
				this._imageContainer.x - this._imageContainer.borderSize,
				this._imageContainer.y - this._imageContainer.borderSize,
				this._imageContainer.width + 2 * this._imageContainer.borderSize,
				this._imageContainer.height + 2 * this._imageContainer.borderSize
			);
			mg.endFill();
			
			return this._imageContainerMask;
		}
		
		public function addImageToContainer(image:DisplayObject):void {
			if (this._loadedImage == null) {
				this._loadedImage = image;
				this._imageContainer.addChild(this._loadedImage);
			} else {
				this._imageContainer.removeChild(this._loadedImage);
				this._loadedImage = image;
				this._imageContainer.addChild(this._loadedImage);
			}
			this._loadedImage.x = this._imageContainer.width / 2 - this._loadedImage.width / 2;
			this._loadedImage.y = this._imageContainer.height / 2 - this._loadedImage.height / 2;
		}
		
		public function clearImageFromContainer():void {
			if (this._loadedImage != null) {
				if (this._imageContainer.contains(this._loadedImage)) {
					this._imageContainer.removeChild(this._loadedImage);
				}
				this._loadedImage = null;
			}
		}
		
		public function get uploadButton():ButtonComponent {
			return this._uploadButton;
		}
		
		public function get clearButton():ButtonComponent {
			return this._clearButton;
		}
		
		public function get helpIcon():Sprite {
			return this._helpIcon;
		}
	}
}