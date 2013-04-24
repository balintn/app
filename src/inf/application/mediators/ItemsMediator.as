package inf.application.mediators {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import inf.application.ApplicationFacade;
	import inf.application.handlers.ImageItemHandler;
	import inf.application.models.ImageItemModel;
	import inf.application.models.ItemsBoxModel;
	import inf.application.views.EditorView;
	import inf.application.views.ItemsView;
	import inf.application.views.components.BaseComponent;
	import inf.application.views.components.DraggedImageComponent;
	import inf.application.views.components.ImageItemComponent;
	import inf.application.views.components.ScrollComponent;
	import inf.utils.Hash;
	import inf.utils.Logger;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ItemsMediator
	 * @author inf
	 * 
	 * @TODO tarolni kell az onImageAddedToStage fv-k referenciajat, hogy lehessen removeEventListenert mondani a komponensnek (ImageItemComponent)
	 */
	public class ItemsMediator extends Mediator {
		
		private var _scrollPaddingTop:Number = 20;
		private var _scrollPaddingBottom:Number = 20;
		
		public static const NAME:String = "itemsMediator";
		
		private var _scrollMediator:ScrollMediator;
		
		/**
		 * ImageItemComponent instance list where key is the model id value is the view component instance
		 * @var Object
		 */
		private var _itemViewsById:Object;
		
		/**
		 * Contains a Point instance whith the original x and y coordinates (in the container)
		 * @var Object
		 */
		private var _itemViewOriginalPositionsById:Object;
		
		/**
		 * ImageItemComponent instance list. Ordered by instance creation time
		 * @var Array
		 */
		private var _itemViewsOrdered:Array;
		
		/**
		 * This variable references to the image which we drag
		 * @var DraggedImageComponent
		 */
		private var _draggedImage:DraggedImageComponent;
		
		private var _availableImageWidth:Number = NaN;
		
		
		
		public function ItemsMediator(viewComponent:ItemsView) {
			super(ItemsMediator.NAME, viewComponent);
			
			this._itemViewsById = {};
			this._itemViewOriginalPositionsById = {};
			this._itemViewsOrdered = [];
			
			// let's create the views and position them
			this.view.createItemsContainer(this.imageWidth);
			var offset:int = 0;
			
			var boxModel:ItemsBoxModel = ItemsBoxModel.getInstance();
			
			var imageWidth:int = boxModel.itemWidth;
			var itemModels:Dictionary = ImageItemHandler.getItems().getAll();
			for (var key:Object in itemModels) {
				var itemModel:ImageItemModel = key as ImageItemModel;
				var tmp:ImageItemComponent = new ImageItemComponent(itemModel.id);
				
				tmp.addTitleText(itemModel.title);
				
				tmp.titleBackground.backgroundColor = boxModel.titleBackgroundColor;
				tmp.titleBackground.backgroundAlpha = boxModel.titleBackgroundAlpha;
				tmp.titleBackground.borderAlpha = 0;
				
				this.view.itemsContainer.addChild(tmp);
				
				// cache it
				this._itemViewsById[key.id] = tmp;
				this._itemViewOriginalPositionsById[key.id] = {};
				this._itemViewsOrdered.push(tmp);
			}
			
			// register scroll mediator
			var scrollCompWidth:Number = boxModel.itemWidth + boxModel.spaceBetweenScrollAndList + boxModel.scrollWidth;
			
			var scrollComp:ScrollComponent = this.view.createScrollComponent(scrollCompWidth, boxModel.height - this._scrollPaddingTop - this._scrollPaddingBottom);
			scrollComp.addEventListener(Event.ADDED_TO_STAGE, this.onScrollComponenentAddedToStage);

			scrollComp.scrollPaneBorderAlpha = boxModel.scrollPaneBorderAlpha;
			scrollComp.scrollPaneBorderSize = boxModel.scrollPaneBorderSize;
			scrollComp.scrollPaneBorderColor = boxModel.scrollPaneBorderColor;
			scrollComp.scrollPaneBackgroundColor = boxModel.scrollPaneBackgroundColor;
			scrollComp.scrollPaneBackgroundAlpha = boxModel.scrollPaneBackgroundAlpha;
			
			scrollComp.scrollBarWidth = boxModel.scrollWidth;
			scrollComp.scrollBarBackgroundAlpha = boxModel.scrollBackgroundAlpha;
			scrollComp.scrollBarBackgroundColor = boxModel.scrollBackgroundColor;
			scrollComp.scrollBarBorderAlpha = boxModel.scrollBorderAlpha;
			scrollComp.scrollBarBorderColor = boxModel.scrollBorderColor;
			scrollComp.scrollBarBorderSize = boxModel.scrollBorderSize;
			
			scrollComp.scrollBarMarginTop = boxModel.scrollLimitTop;
			scrollComp.scrollBarMarginBottom = boxModel.scrollLimitBottom;
			
			scrollComp.scrollThumbWidth = boxModel.scrollThumbWidth;
			scrollComp.scrollThumbHeight = boxModel.scrollThumbHeight;
			scrollComp.scrollThumbColor = boxModel.scrollThumbColor;
			
			scrollComp.x = this.view.width - scrollComp.width / 2 - this.view.width / 2;
			scrollComp.y = this.view.height - scrollComp.height / 2 - this.view.height / 2;
			
			this._scrollMediator = new ScrollMediator(scrollComp, ItemsMediator.NAME);
			this._scrollMediator.animatedScroll = true;
			this.facade.registerMediator(this._scrollMediator);
			this.view.addChild(scrollComp);			
			
		}
		
		/**
		 * Recalculates the list elements y coords
		 */
		private function recalculateItemsPosition():void {
			var offset:Number = 0;
			for (var i:uint = 0; i < this._itemViewsOrdered.length; i++) {
				
				this._itemViewsOrdered[i].y = offset;
				
				// cache original coordinates
				this._itemViewOriginalPositionsById[this._itemViewsOrdered[i].id] = new Point(this._itemViewsOrdered[i].x, this._itemViewsOrdered[i].y);
				
				var itemComp:ImageItemComponent = this._itemViewsOrdered[i] as ImageItemComponent;
				
				offset += (itemComp.image != null) ? itemComp.height + this.spaceBetweenItems : 0;
			}
			this.view.itemsContainer.height = offset - this.spaceBetweenItems;
			this._scrollMediator.forceRender();
		}
		
		
		public override function listNotificationInterests():Array {
			return [ApplicationFacade.IMAGE_ITEM_BITMAP_LOADED];
		}
		
		
		public override function handleNotification(notification:INotification):void {
			
			if (notification.getName() == ApplicationFacade.IMAGE_ITEM_BITMAP_LOADED) {
				
				// image downloaded, store it in the model
				var body:Object = notification.getBody();
				
				var id:uint = body['additionalInfo'];
				var image:DisplayObject = body['displayObject'] as DisplayObject;
				image.cacheAsBitmap = true;
				
				var model:ImageItemModel = ImageItemHandler.getItemById(id);
				
				if (model != null) {
					model.setImage(image);
				} else {
					Logger.error("Image item by id=" + id + " not found! Failed to store downloaded image!");
				}
				
				// attach to its viewcomponent
				var viewComp:ImageItemComponent = this._itemViewsById.hasOwnProperty(model.id) ? this._itemViewsById[model.id] : null;
				if (viewComp != null) {
					
					var targetWidth:Number = ItemsBoxModel.getInstance().itemWidth;
										
					// set image dimensions
					var multiplier:Number = (image.width < targetWidth) ? image.width / targetWidth : targetWidth / image.width;
					image.width *= multiplier;
					image.height *= multiplier;
					image.addEventListener(Event.ADDED_TO_STAGE, this.onImageAddedToStage(viewComp));
					viewComp.addEventListener(MouseEvent.MOUSE_DOWN, this.onImageMouseDown);
					viewComp.addImage(image, model.marked);
					viewComp.render();
				}
			}
		}
		
		private function onScrollComponenentAddedToStage(event:Event):void {
			this._scrollMediator.getView().removeEventListener(Event.ADDED_TO_STAGE, this.onScrollComponenentAddedToStage);			
			this._scrollMediator.setScrollContent(this.view.itemsContainer);
		}
		
		private function onImageMouseDown(event:MouseEvent):void {
			
			if (event.currentTarget is ImageItemComponent) {
				var comp:ImageItemComponent = event.currentTarget as ImageItemComponent;
				var clonedImage:DisplayObject = comp.getImageClone();
				
				this.addDraggableImageToStage(clonedImage);
				
				this._draggedImage.render();
			}
			this._draggedImage.visible = true;
			
			this._draggedImage.startDrag();
			if (! this._draggedImage.hasEventListener(Event.ENTER_FRAME)) {
				this._draggedImage.addEventListener(Event.ENTER_FRAME, this.onDraggedImageEnterframe);
			}
		}
		
		private function onImageMouseUp(event:MouseEvent):void {
			var comp:ImageItemComponent = event.currentTarget as ImageItemComponent;
			this._draggedImage.stopDrag();
			
			if (this._draggedImage.hasEventListener(Event.ENTER_FRAME)) {
				this._draggedImage.removeEventListener(Event.ENTER_FRAME, this.onDraggedImageEnterframe);
			}
			
			var ev:EditorView = (this.facade.retrieveMediator(EditorMediator.NAME) as EditorMediator).view;
			var evRect:Rectangle = ev.getRect(ev.stage);
			var diRect:Rectangle = this._draggedImage.getRect(ev.stage);
			
			// drops image if it is not placed on editor area
			if (! evRect.containsRect(diRect)) {
				this.removeDraggableImageFromStage();	
				this._draggedImage.visible = false;
			}
			
		}
		
		private function onDraggedImageEnterframe(event:Event):void {
			
			var stage:Stage = (this.facade.retrieveMediator(EditorMediator.NAME) as EditorMediator).view.stage as Stage;
			if (stage.mouseX <= 0 || stage.mouseX >= stage.stageWidth || stage.mouseY <= 0 || stage.mouseY >= stage.stageHeight) {
				this.onImageMouseUp(new MouseEvent("fakeEvent"));
			}
			
		}
		
		private function onImageAddedToStage(comp:ImageItemComponent):Function {
			
			var recalculateItemsPosition:Function = this.recalculateItemsPosition;
			
			return function(event:Event):void {
				comp.render();
				recalculateItemsPosition();
				//(event.currentTarget as Bitmap).removeEventListener(Event.ADDED_TO_STAGE, this.onImageAddedToStage);	
			}
		}
		
		private function addDraggableImageToStage(image:DisplayObject):void {
			
			if (this._draggedImage == null) {
				this._draggedImage = new DraggedImageComponent();
				this.view.stage.addChild(this._draggedImage);
				
				this._draggedImage.addEventListener(MouseEvent.MOUSE_UP, this.onImageMouseUp);
				this._draggedImage.addEventListener(MouseEvent.MOUSE_DOWN, this.onImageMouseDown);
			}
			this._draggedImage.addImage(image);
			this._draggedImage.x = this.view.stage.mouseX - this._draggedImage.width / 2;
			this._draggedImage.y = this.view.stage.mouseY - this._draggedImage.height / 2;
			
		}
		
		private function removeDraggableImageFromStage():void {
			if (this._draggedImage != null) {
				this._draggedImage.removeImage();
			}
		}
		
		private function getAvailableImageWidth():Number {
			
			if (isNaN(this._availableImageWidth)) {
				var model:ItemsBoxModel = ItemsBoxModel.getInstance();
				this._availableImageWidth = model.width - model.scrollWidth - model.spaceBetweenScrollAndList;
			}
			return this._availableImageWidth;
		}
		
		public function get imageWidth():int {
			return ItemsBoxModel.getInstance().itemWidth;
		}
		
		public function get spaceBetweenItems():int {
			return ItemsBoxModel.getInstance().spaceBetweenItems;
		}
		
		public function get spaceBetweenScrollAndList():int {
			return ItemsBoxModel.getInstance().spaceBetweenScrollAndList;
		}
		
		public function get view():ItemsView {
			return this.viewComponent as ItemsView;
		}
	}
}