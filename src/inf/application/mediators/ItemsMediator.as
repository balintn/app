package inf.application.mediators {
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import inf.application.ApplicationFacade;
	import inf.application.handlers.ImageItemHandler;
	import inf.application.models.ImageItemModel;
	import inf.application.models.ItemsBoxModel;
	import inf.application.views.ItemsView;
	import inf.application.views.components.BaseComponent;
	import inf.application.views.components.ImageItemComponent;
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
		
		/**
		 * DisplayObject container which gives plase to ImageItemComponent instances
		 * @var BaseComponent
		 */
		private var _itemsContainer:BaseComponent;
		
		/**
		 * ImageItemComponent instance list where key is the model id value is the view component instance
		 * @var Object
		 */
		private var _itemViews:Object;
		
		private var _availableImageWidth:Number = NaN;
		
		
		public function ItemsMediator(viewComponent:ItemsView) {
			super(ItemsMediator.NAME, viewComponent);
			
			this._itemViews = {};
			
			// let's create the views and position them
			this._itemsContainer = new BaseComponent(this.imageWidth);
			var offset:int = 0;
						
			var itemModels:Dictionary = ImageItemHandler.getItems().getAll();
			for (var key:Object in itemModels) {
				
				var tmp = new ImageItemComponent(this.imageWidth, this.imageHeight);
				tmp.y = offset;
				this._itemsContainer.addChild(tmp);
				
				// cache it
				this._itemViews[key.id] = tmp;
				
				offset += this.imageHeight + this.spaceBetweenItems;
			}
			
			// TODO test.... torolni majd
			//this.view.addChild(this._itemsContainer);
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
				
				var model:ImageItemModel = ImageItemHandler.getItemById(id);
				
				if (model != null) {
					model.setImage(image);
				} else {
					Logger.error("Image item by id=" + id + " not found! Failed to store downloaded image!");
				}
				
				// attach to its viewcomponent
				var viewComp:ImageItemComponent = this._itemViews.hasOwnProperty(model.id) ? this._itemViews[model.id] : null;
				if (viewComp != null) {
					viewComp.addImage(image);
				}
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
		
		public function get imageHeight():int {
			return ItemsBoxModel.getInstance().itemHeight;
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