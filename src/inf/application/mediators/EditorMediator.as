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
	import flash.ui.Mouse;
	import flash.utils.ByteArray;
	
	import inf.application.ApplicationFacade;
	import inf.application.models.EditorBoxModel;
	import inf.application.models.EnvironmentModel;
	import inf.application.proxies.ImageLoaderProxy;
	import inf.application.views.EditorView;
	
	import mx.utils.*;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * EditorMediator class
	 * @author inf
	 */
	public class EditorMediator extends Mediator {
		
		public static const NAME:String = "editorMediator";
		
		public static const HELP_ICON_KEY:String = "helpIcon";
		
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
			
			var helpIconUrl:String = EnvironmentModel.getInstance().helpIcon;
			if (helpIconUrl != "") {
				var proxy:ImageLoaderProxy = this.facade.retrieveProxy(ImageLoaderProxy.NAME) as ImageLoaderProxy;
				proxy.loadImage(helpIconUrl, EditorMediator.HELP_ICON_KEY);
			}
		}
		
		/**
		 * Returns notification list
		 * @return Array
		 */
		public override function listNotificationInterests():Array{
			return [
				ApplicationFacade.IMAGE_ITEM_BITMAP_LOADED
			];
		}
		
		/**
		 * Notification handling
		 * @param INotification notification
		 */
		public override function handleNotification(notification:INotification):void {
			
			if (notification.getName() == ApplicationFacade.IMAGE_ITEM_BITMAP_LOADED) {
				var body:Object = notification.getBody();
				
				if (body['additionalInfo'] != null && body['additionalInfo'] == EditorMediator.HELP_ICON_KEY ) {
					this.view.helpIcon.addChild(body['displayObject'] as DisplayObject);
					this.view.helpIcon.addEventListener(MouseEvent.CLICK, this.onHelpIconClick);
					this.view.helpIcon.buttonMode = this.view.helpIcon.useHandCursor = true;
				}
			}
		}
		
		protected function onHelpIconClick(event:MouseEvent):void {
			var mediator:HelpPopupMediator = this.facade.retrieveMediator(HelpPopupMediator.NAME) as HelpPopupMediator;
			if (! mediator.view.visible) {
				mediator.view.visible = true;
			}
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
			
			var editorModel:EditorBoxModel = EditorBoxModel.getInstance();
			
			this.view.uploadButton.backgroundColor = editorModel.btnUploadBackgroundColor;
			this.view.uploadButton.backgroundAlpha = editorModel.btnUploadBackgroundAlpha;
			this.view.uploadButton.borderColor = editorModel.btnUploadBorderColor;
			this.view.uploadButton.borderAlpha = editorModel.btnUploadBorderAlpha;
			this.view.uploadButton.borderSize = editorModel.btnUploadBorderSize;
			this.view.uploadButton.setText(editorModel.btnUploadText);
			this.view.uploadButton.width = editorModel.btnUploadWidth;
			this.view.uploadButton.height = editorModel.btnUploadHeight;
			this.view.uploadButton.x = editorModel.btnUploadX;
			this.view.uploadButton.y = editorModel.btnUploadY;
			//this.view.uploadButton.buttonMode = this.view.uploadButton.useHandCursor = true;
			
			this.view.clearButton.backgroundColor = editorModel.btnEraseBackgroundColor;
			this.view.clearButton.backgroundAlpha = editorModel.btnEraseBackgroundAlpha;
			this.view.clearButton.borderColor = editorModel.btnEraseBorderColor;
			this.view.clearButton.borderAlpha = editorModel.btnEraseBorderAlpha;
			this.view.clearButton.borderSize = editorModel.btnEraseBorderSize;
			this.view.clearButton.setText(editorModel.btnEraseText);
			this.view.clearButton.width = editorModel.btnEraseWidth;
			this.view.clearButton.height = editorModel.btnEraseHeight;
			this.view.clearButton.x = editorModel.btnEraseX;
			this.view.clearButton.y = editorModel.btnEraseY;
			//this.view.clearButton.buttonMode = this.view.clearButton.useHandCursor = true;
			
			this.view.render();
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