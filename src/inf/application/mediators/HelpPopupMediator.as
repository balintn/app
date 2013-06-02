package inf.application.mediators {
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import inf.application.models.HelpPopupBoxModel;
	import inf.application.views.HelpPopupView;
	import inf.application.views.components.BaseComponent;
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
			
			this.view.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseButtonClick);
			
			var hvModel:HelpPopupBoxModel = HelpPopupBoxModel.getInstance();
			var scrollCompWidth:Number = hvModel.width - (HelpPopupView.SCROLL_COMP_PADDING_LEFT + HelpPopupView.SCROLL_COMP_PADDING_RIGHT + hvModel.spaceBetweenScrollAndList + hvModel.scrollWidth);
			
			var scrollComp:ScrollComponent = this.view.createScrollComponent(scrollCompWidth, hvModel.height - (HelpPopupView.SCROLL_COMP_PADDING_TOP + HelpPopupView.SCROLL_COMP_PADDING_BOTTOM));
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

			this._scrollMediator.getView().removeEventListener(Event.ADDED_TO_STAGE, this.onScrollComponentAddedToStage);
			
			var model:HelpPopupBoxModel = HelpPopupBoxModel.getInstance();
			
			this.view.closeButton.backgroundColor = model.btnCloseBackgroundColor;
			this.view.closeButton.backgroundAlpha = model.btnCloseBackgroundAlpha;
			this.view.closeButton.borderColor = model.btnCloseBorderColor;
			this.view.closeButton.borderAlpha = model.btnCloseBorderAlpha;
			this.view.closeButton.borderSize = model.btnCloseBorderSize;
			this.view.closeButton.width = model.btnCloseWidth;
			this.view.closeButton.height = model.btnCloseHeight;
			this.view.closeButton.setText(model.btnCloseText);
			this.view.closeButton.x = model.btnCloseX;
			this.view.closeButton.y = model.btnCloseY;
			this.view.closeButton.textField.width = model.btnCloseWidth;
			//this.view.closeButton.buttonMode = this.view.closeButton.useHandCursor = true;

			var container:BaseComponent = new BaseComponent(this.view.scrollComponent.width);
			
			var helpTextField:TextField = new TextField();
			helpTextField.multiline = true;
			helpTextField.autoSize = TextFieldAutoSize.LEFT;
			helpTextField.wordWrap = true;
			
			helpTextField.width = container.width - (model.spaceBetweenScrollAndList);
			helpTextField.htmlText = model.helpText;
			
			container.height = helpTextField.textHeight;
			container.addChild(helpTextField);
			
			this._scrollMediator.setScrollContent(container);
			
			this.view.render();
		}
		
		protected function onCloseButtonClick(event:MouseEvent):void {
			this.view.visible = false;
		}
		
		public function get view():HelpPopupView {
			return this.viewComponent as HelpPopupView;
		}
	}
}