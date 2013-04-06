package inf.application.mediators {
	import flash.display.DisplayObject;
	
	import inf.application.ApplicationFacade;
	import inf.application.handlers.ImageItemHandler;
	import inf.application.models.ImageItemModel;
	import inf.application.views.ItemsView;
	import inf.utils.Logger;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ItemsMediator
	 * @author inf
	 */
	public class ItemsMediator extends Mediator {
		
		public static const NAME:String = "itemsMediator";
		
		public function ItemsMediator(viewComponent:ItemsView) {
			super(ItemsMediator.NAME, viewComponent);
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
			}
		}
		
		public function get view():ItemsView {
			return this.viewComponent as ItemsView;
		}
	}
}