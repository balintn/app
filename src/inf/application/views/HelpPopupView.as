package inf.application.views {
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import inf.application.models.BoxModel;
	import inf.application.views.components.BackgroundedComponent;
	import inf.application.views.components.BaseComponent;
	import inf.application.views.components.BoxComponent;
	import inf.application.views.components.ButtonComponent;
	import inf.application.views.components.ScrollComponent;
	
	/**
	 * HelpPopupView class
	 * @author inf
	 */
	public class HelpPopupView extends BoxComponent {
		
		public static const SCROLL_COMP_PADDING_LEFT:Number = 20;
		public static const SCROLL_COMP_PADDING_RIGHT:Number = 20;
		public static const SCROLL_COMP_PADDING_TOP:Number = 20;
		public static const SCROLL_COMP_PADDING_BOTTOM:Number = 20;
		
		
		/**
		 * Scroll component
		 * @var ScrollComponent
		 */
		private var _scrollComponent:ScrollComponent;
		
		private var _closeButton:ButtonComponent;
		
		private var _mask:Shape;
		
		
		public function HelpPopupView(model:BoxModel) {
			super(model);
			
			this._closeButton = new ButtonComponent();
			this.addChild(this._closeButton);
			
			this._mask = new Shape();
			this.addChild(this._mask);
		}
		
		public override function render():void {
			super.render();
			
			this.graphics.clear();
			this.graphics.beginFill(0, .2);
			this.graphics.drawRect(-this.x, -this.y, this.stage.stageWidth, this.stage.stageHeight);
			this.graphics.endFill();
			
			this._closeButton.render();
			
			this.setChildIndex(this._closeButton, this.numChildren - 1);
		}
		
		/**
		 * Creates scroll component and adds it to displaylist
		 * @param Number width
		 * @param Number height
		 * @return ScrollComponent
		 */
		public function createScrollComponent(width:Number, height:Number):ScrollComponent {
			if (this._scrollComponent == null) {
				this._scrollComponent = new ScrollComponent(width, height);
			}
			if (! this.contains(this._scrollComponent)) {
				this.addChild(this._scrollComponent);
			}
			return this._scrollComponent;
		}
		
		public function get closeButton():ButtonComponent {
			return this._closeButton;
		}
		
		public function get scrollComponent():ScrollComponent {
			return this._scrollComponent;
		}
	}
}