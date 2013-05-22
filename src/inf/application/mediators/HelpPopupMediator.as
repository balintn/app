package inf.application.mediators {
	
	import flash.events.Event;
	
	import inf.application.models.HelpPopupBoxModel;
	import inf.application.views.HelpPopupView;
	import inf.application.views.components.ScrollComponent;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * HelpPopupMediator class
	 * @author inf
	 */
	public class HelpPopupMediator extends Mediator {
		
		public static const NAME:String = "helpPopupMediator";
		public static const SCROLL_MEDIATOR_NAME:String = "helpScrollMediator";
		
		private var _scrollMediator:ScrollMediator;
		
		
		public function HelpPopupMediator(viewComponent:HelpPopupView) {
			super(HelpPopupMediator.NAME, viewComponent);
			
			var hvModel:HelpPopupBoxModel = HelpPopupBoxModel.getInstance();
			
			var scrollCompWidth:Number = hvModel.width - (hvModel.spaceBetweenScrollAndList + hvModel.scrollWidth);
			
			var scrollComp:ScrollComponent = this.view.createScrollComponent(scrollCompWidth, hvModel.height);
			scrollComp.addEventListener(Event.ADDED_TO_STAGE, this.onScrollComponentAddedToStage);
			
			scrollComp.scrollPaneBorderAlpha = hvModel.scrollPaneBorderAlpha;
			scrollComp.scrollPaneBorderSize = hvModel.scrollPaneBorderSize;
			scrollComp.scrollPaneBorderColor = hvModel.scrollPaneBorderColor;
			scrollComp.scrollPaneBackgroundColor = hvModel.scrollPaneBackgroundColor;
			scrollComp.scrollPaneBackgroundAlpha = hvModel.scrollPaneBackgroundAlpha;
			
			scrollComp.scrollBarWidth = hvModel.scrollWidth;
			scrollComp.scrollBarBackgroundAlpha = hvModel.scrollBackgroundAlpha;
			scrollComp.scrollBarBackgroundColor = hvModel.scrollBackgroundColor;
			scrollComp.scrollBarBorderAlpha = hvModel.scrollBorderAlpha;
			scrollComp.scrollBarBorderColor = hvModel.scrollBorderColor;
			scrollComp.scrollBarBorderSize = hvModel.scrollBorderSize;
			
			scrollComp.scrollBarMarginTop = hvModel.scrollLimitTop;
			scrollComp.scrollBarMarginBottom = hvModel.scrollLimitBottom;
			
			scrollComp.scrollThumbWidth = hvModel.scrollThumbWidth;
			scrollComp.scrollThumbHeight = hvModel.scrollThumbHeight;
			scrollComp.scrollThumbColor = hvModel.scrollThumbColor;
			
			scrollComp.x = this.view.width - scrollComp.width / 2 - this.view.width / 2;
			scrollComp.y = this.view.height - scrollComp.height / 2 - this.view.height / 2;
			
			this._scrollMediator = new ScrollMediator(scrollComp, HelpPopupMediator.SCROLL_MEDIATOR_NAME);
			this._scrollMediator.animatedScroll = true;
			this.facade.registerMediator(this._scrollMediator);
			this.view.addChild(scrollComp);			
		}
		
		protected function onScrollComponentAddedToStage(event:Event):void {
			trace("scrollcomp added to stage");
			this._scrollMediator.getView().removeEventListener(Event.ADDED_TO_STAGE, this.onScrollComponentAddedToStage);		
		}
		
		public function get view():HelpPopupView {
			return this.viewComponent as HelpPopupView;
		}
	}
}