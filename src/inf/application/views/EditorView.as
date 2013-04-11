package inf.application.views {
	import flash.display.DisplayObject;
	
	import inf.application.models.EditorBoxModel;
	import inf.application.views.components.BackgroundedComponent;
	import inf.application.views.components.BoxComponent;
	
	/**
	 * EditorView class
	 * @author inf
	 */
	public class EditorView extends BoxComponent {
		
		public static var PADDING:int = 20;
		
		private var _uploadButton:BackgroundedComponent;
		private var _imageContainer:BackgroundedComponent;
		private var _loadedImage:DisplayObject;
		
		public function EditorView(model:EditorBoxModel) {
			super(model);
			
			this._uploadButton = new BackgroundedComponent();
			this._uploadButton.backgroundColor = 0xff00ff;
			this._uploadButton.width = 40;
			this._uploadButton.height = 16;
			this.addChild(this._uploadButton);
			
			this._imageContainer = new BackgroundedComponent();
			this._imageContainer.backgroundAlpha = 0;
			this._imageContainer.borderColor = 0xc3c3c3;
			this._imageContainer.borderSize = 1;
			this.addChild(this._imageContainer);
			
		}
		
		public override function render():void {
			super.render();
			
			// TODO ezt es az ilyeneket majd irtani, csinalni szepen paddinget a modellnek
			this._imageContainer.x = EditorView.PADDING;
			this._imageContainer.y = EditorView.PADDING;
			this._imageContainer.width = this.width - 2 * EditorView.PADDING;
			this._imageContainer.height = this.height - 2 * EditorView.PADDING;
			
			
			this._imageContainer.render();
			this._uploadButton.render();
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
		
		public function get uploadButton():BackgroundedComponent {
			return this._uploadButton;
		}
	}
}