package inf.application.mediators {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import inf.application.models.EnvironmentModel;
	import inf.application.views.EditorView;
	
	import mx.utils.*;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * EditorMediator class
	 * @author inf
	 */
	public class EditorMediator extends Mediator {
		
		public static const NAME:String = "editorMediator";
		
		private var _fileReference:FileReference;
		private var _fileFilter:FileFilter;
		
		
		public function EditorMediator(viewComponent:EditorView) {
			super(EditorMediator.NAME, viewComponent);
			
			viewComponent.uploadButton.addEventListener(MouseEvent.CLICK, this.onUploadButtonClick);
			viewComponent.clearButton.addEventListener(MouseEvent.CLICK, this.onClearButtonClick);
			viewComponent.addEventListener(Event.ADDED_TO_STAGE, this.editorViewAddedToStage);
			
			this._fileFilter = new FileFilter("Image files", "*.jpg;*.gif;*.png");
			this._fileReference = new FileReference();
			this._fileReference.addEventListener(Event.SELECT, this.onFileSelect);
			this._fileReference.addEventListener(Event.CANCEL, this.onFileCancel);
		}
		
		protected function onFileSelect(event:Event):void {
			var fileRef:Object = event.currentTarget as FileReference;
			fileRef.addEventListener(Event.COMPLETE, this.onImageLoaded);
			fileRef.load();
		}
		
		protected function onFileCancel(event:Event):void {
			// do nothing
		}
		
		protected function onImageLoaded(event:Event):void {
			
			var byteArray:ByteArray = event.currentTarget.data as ByteArray;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onImageByteArrayLoaded);
			loader.loadBytes(byteArray);
		}
		
		protected function onImageByteArrayLoaded(event:Event):void {
			
			var image:DisplayObject = (event.currentTarget as LoaderInfo).content as DisplayObject;
			this.view.addImageToContainer(image);
		
		}
		
		protected function onClearButtonClick(event:MouseEvent):void {
			this.view.clearImageFromContainer();
		}
		
		protected function onUploadButtonClick(event:MouseEvent):void {
			this._fileReference.browse([this._fileFilter]);
		}
		
		protected function editorViewAddedToStage(event:Event):void {
			this.view.render();
			this.view.clearButton.y = this.view.uploadButton.y = this.view.height - this.view.uploadButton.height;
			this.view.clearButton.x = this.view.uploadButton.x + this.view.uploadButton.width + 5;
		}
		
		
		/**
		 * Returns the view component
		 * @return Sprite
		 */
		public function get view():EditorView {
			return this.viewComponent as EditorView;
		}
	}
}