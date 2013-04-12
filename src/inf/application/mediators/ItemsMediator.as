package inf.application.mediators {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import inf.application.ApplicationFacade;
	import inf.application.handlers.ImageItemHandler;
	import inf.application.models.ImageItemModel;
	import inf.application.models.ItemsBoxModel;
	import inf.application.views.ItemsView;
	import inf.application.views.components.BaseComponent;
	import inf.application.views.components.ImageItemComponent;
	import inf.application.views.components.ScrollComponent;
	import inf.utils.Hash;
	import inf.utils.Logger;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ItemsMediator
	 * @author inf
	 */
	public class ItemsMediator extends Mediator {
		
		public static const NAME:String = "itemsMediator";
		
		private var _scrollMediator:ScrollMediator;
		
		/**
		 * ImageItemComponent instance list where key is the model id value is the view component instance
		 * @var Object
		 */
		private var _itemViewsById:Object;
		
		/**
		 * ImageItemComponent instance list. Ordered by instance creation time
		 * @var Array
		 */
		private var _itemViewsOrdered:Array;
		
		private var _availableImageWidth:Number = NaN;
		
		
		public function ItemsMediator(viewComponent:ItemsView) {
			super(ItemsMediator.NAME, viewComponent);
			
			this._itemViewsById = {};
			this._itemViewsOrdered = [];
			
			// let's create the views and position them
			this.view.createItemsContainer(this.imageWidth);
			var offset:int = 0;
			
			var boxModel:ItemsBoxModel = ItemsBoxModel.getInstance();
			
			var imageWidth:int = boxModel.itemWidth;
			var itemModels:Dictionary = ImageItemHandler.getItems().getAll();
			for (var key:Object in itemModels) {
				
				var tmp:ImageItemComponent = new ImageItemComponent();
				
				this.view.itemsContainer.addChild(tmp);
				
				// cache it
				this._itemViewsById[key.id] = tmp;
				this._itemViewsOrdered.push(tmp);
			}
			
			// register scroll mediator
			var scrollCompWidth:Number = boxModel.itemWidth + boxModel.spaceBetweenScrollAndList + boxModel.scrollWidth;
			
			var scrollComp:ScrollComponent = this.view.createScrollComponent(scrollCompWidth, boxModel.height);
			scrollComp.addEventListener(Event.ADDED_TO_STAGE, this.onScrollComponenentAddedToStage);
			
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
				
				var itemComp:ImageItemComponent = this._itemViewsOrdered[i] as ImageItemComponent;
				
				offset += (itemComp.image != null) ? itemComp.image.height + this.spaceBetweenItems : 0;
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
					image.addEventListener(Event.ADDED_TO_STAGE, this.onImageAddedToStage);
					viewComp.addImage(image);
				}
			}
		}
		
		private function onScrollComponenentAddedToStage(event:Event):void {
			this._scrollMediator.getView().removeEventListener(Event.ADDED_TO_STAGE, this.onScrollComponenentAddedToStage);			
			this._scrollMediator.setScrollContent(this.view.itemsContainer);
		}
		
		private function onImageAddedToStage(event:Event):void {
			this.recalculateItemsPosition();
			(event.currentTarget as Bitmap).removeEventListener(Event.ADDED_TO_STAGE, this.onImageAddedToStage);
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