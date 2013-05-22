package inf.application.mediators {
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import inf.application.ApplicationFacade;
	import inf.application.handlers.ImageItemHandler;
	import inf.application.models.EditorBoxModel;
	import inf.application.models.EnvironmentModel;
	import inf.application.models.HelpPopupBoxModel;
	import inf.application.models.ItemsBoxModel;
	import inf.application.proxies.HandshakeProxy;
	import inf.application.proxies.ImageLoaderProxy;
	import inf.application.views.EditorView;
	import inf.application.views.HelpPopupView;
	import inf.application.views.ItemsView;
	import inf.application.views.components.BackgroundedComponent;
	import inf.utils.Logger;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ApplicationMediator class
	 * 
	 * @author inf
	 */
	public class ApplicationMediator extends Mediator {
		
		public static const NAME:String = "applicationMediator";
		
		private var _stage:Stage;
		
		public function ApplicationMediator(viewComponent:flash_app) {
			
			this._stage = viewComponent.stage as Stage;
			
			super(ApplicationMediator.NAME, viewComponent);
		}
		
		/**
		 * Returns notification list
		 * @return Array
		 */
		public override function listNotificationInterests():Array{
			return [
				ApplicationFacade.APP_INITALIZED,
				ApplicationFacade.APP_HANDSHAKE_DATA_LOADED
			];
		}
		
		/**
		 * Notification handling
		 * @param INotification notification
		 */
		public override function handleNotification(notification:INotification):void {
			
			switch (notification.getName()) {
				
				case ApplicationFacade.APP_INITALIZED:
					
					// now start loading handshake data
					var proxy:HandshakeProxy = this.facade.retrieveProxy(HandshakeProxy.NAME) as HandshakeProxy;
					proxy.loadHandshakeData();					
					break;
				
				case ApplicationFacade.APP_HANDSHAKE_DATA_LOADED:
					
					
					// draw app background
					this.drawAppBackground();
					
					// help popup view
					var helpModel:HelpPopupBoxModel = HelpPopupBoxModel.getInstance();
					var helpView:HelpPopupView = new HelpPopupView(helpModel);
					helpView.x = helpModel.x;
					helpView.y = helpModel.y;
					helpView.addEventListener(Event.ADDED_TO_STAGE, this.helpPopupViewAddedToStage);
					
					// create editor view
					var editorModel:EditorBoxModel = EditorBoxModel.getInstance();
					var editorView:EditorView = new EditorView(editorModel);
					editorView.x = editorModel.x;
					editorView.y = editorModel.y;
					editorView.addEventListener(Event.ADDED_TO_STAGE, this.editorViewAddedToStage);
					
					// create items view
					var itemsModel:ItemsBoxModel = ItemsBoxModel.getInstance();
					var itemsView:ItemsView = new ItemsView(itemsModel);
					itemsView.x = itemsModel.x;
					itemsView.y = itemsModel.y;
					itemsView.addEventListener(Event.ADDED_TO_STAGE, this.itemsViewAddedToStage);
					
					// create mediators
					Logger.debug("Register HelpPopupMediator...");
					this.facade.registerMediator(new HelpPopupMediator(helpView));
					
					Logger.debug("Register EditorMediator...");
					this.facade.registerMediator(new EditorMediator(editorView));
					
					Logger.debug("Register ItemsMediator...");
					this.facade.registerMediator(new ItemsMediator(itemsView));
					
					this.app.addChild(helpView);
					this.app.addChild(editorView);
					this.app.addChild(itemsView);
					
					break;
				
			}
		}
		
		private function helpPopupViewAddedToStage(event:Event):void {
			
			// render
			(event.currentTarget as HelpPopupView).render();
			
			this.setViewsIndex();
		}
		
		private function itemsViewAddedToStage(event:Event):void {
			// render
			(event.currentTarget as ItemsView).render();
			
			// register image loader proxy
			Logger.debug("Register ImageLoaderProxy...");
			this.facade.registerProxy(new ImageLoaderProxy());
			
			// load images
			ImageItemHandler.loadImages();
			
			this.setViewsIndex();
		}
		
		private function editorViewAddedToStage(event:Event):void {
			// render
			(event.currentTarget as EditorView).render();
			
			this.setViewsIndex();
		}
		
		private function setViewsIndex():void {
			var ev:EditorView = (this.facade.retrieveMediator(EditorMediator.NAME) as EditorMediator).view;
			var iv:ItemsView = (this.facade.retrieveMediator(ItemsMediator.NAME) as ItemsMediator).view;
			var hv:HelpPopupView = (this.facade.retrieveMediator(HelpPopupMediator.NAME) as HelpPopupMediator).view;
			
			if (this.app.contains(ev) && this.app.contains(iv) && this.app.contains(hv)) {
				this.app.setChildIndex(iv, this.app.numChildren - 1);
				this.app.setChildIndex(hv, this.app.numChildren - 1);
			}
		}
		
		/**
		 * Draws app background		 
		 */
		private function drawAppBackground():void {
			
			var envModel:EnvironmentModel = EnvironmentModel.getInstance();
			
			var graphics:Graphics = this.app.graphics;
			
			graphics.clear();
			graphics.beginFill(envModel.appBackgroundColor, envModel.appBackgroundAlpha);
			graphics.drawRect(0, 0, this.getStageWidth(), this.getStageHeight());
			graphics.endFill();
		}
		
		/**
		 * Returns stage width
		 * @return int
		 */
		public function getStageWidth():int {
			return this._stage.stageWidth;
		}
		
		/**
		 * Returns stage height
		 * @return int
		 */
		public function getStageHeight():int {
			return this._stage.stageHeight;
		}
		
		
		public function get app():Sprite {
			return this.viewComponent as Sprite;
		}
	
	}
}