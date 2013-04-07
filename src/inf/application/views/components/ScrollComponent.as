package inf.application.views.components {
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import inf.utils.Logger;
	
	public class ScrollComponent extends BackgroundedComponent {
		
		
		protected var _scrollBarWidth:Number = 8;
		protected var _scrollThumbWidth:Number = 8;
		protected var _scrollThumbHeight:Number = 20;
		
		protected var _scrollBarMarginTop:Number = 0;
		protected var _scrollBarMarginBottom:Number = 0;
		
		protected var _scrollBarBackgroundColor:uint = 0;
		protected var _scrollBarBackgroundAlpha:Number = 1;
		protected var _scrollBarBorderColor:uint = 0;
		protected var _scrollBarBorderAlpha:Number = 1;
		protected var _scrollBarBorderSize:uint = 1;
		
		protected var _scrollThumbColor:uint = 0xff0000;
		
		protected var _content:DisplayObject;
		protected var _mask:Shape;
		
		protected var _scrollThumb:BackgroundedComponent;
		protected var _scrollBar:BackgroundedComponent;
		
		protected var _scrollAreaBackgroundColor:uint = 0xffffff;
		protected var _scrollAreaBackgroundAlpha:Number = 0;
		
		protected var _isEnabled:Boolean;
		
		protected var _lastContentHeight:Number = 0;
		
		public function ScrollComponent(width:Number, height:Number) {
			super(width, height);
			this._isEnabled = true;
			
			this.addEventListener(Event.ENTER_FRAME, function(event:Event):void {
				var elem:ScrollComponent = event.target as ScrollComponent;
				if (elem.content != null && elem.content.height != elem.lastContentHeight) {
					elem.lastContentHeight = elem.content.height;
					//elem.render();
					// TODO render?
				}
			});
			
			this._mask = new Shape();
			this._scrollThumb = new BackgroundedComponent();
			this._scrollThumb.borderSize = 0;
			this._scrollBar = new BackgroundedComponent();
			
			this.addChild(this._mask);
			this.addChild(this._scrollThumb);
			this.addChild(this._scrollBar);
		}
		
		
		public override function render():void {
			
			this._mask.graphics.clear();
			
			if (this._content != null && this._isEnabled) {
				
				if (this.contains(this._mask)) {
					
					var maskWidth:Number;
					var maskHeight:Number;
					
					if (this._content.height > this.height) {
						Logger.debug("Content is higher than scroll content area. Showing scrollbar.");
						
						// content is bigger than scroll area so we need to show scrollbar
						this._scrollBar.visible = true;
						this._scrollThumb.visible = true;
						
						this._scrollBar.align = BackgroundedComponent.CENTER_TOP;
						this._scrollBar.x = this.width - this._scrollBarWidth / 2;
						this._scrollBar.y = 0;
						this._scrollBar.width = this._scrollBarWidth;
						this._scrollBar.height = this.height;
						this._scrollBar.backgroundColor = this._scrollBarBackgroundColor;
						this._scrollBar.backgroundAlpha = this._scrollBarBackgroundAlpha;
						this._scrollBar.borderColor = this._scrollBarBorderColor;
						this._scrollBar.borderAlpha = this._scrollBarBorderAlpha;
						this._scrollBar.borderSize = this._scrollBarBorderSize;
						
						this._scrollThumb.align = BackgroundedComponent.CENTER_TOP;
						this._scrollThumb.x = this._scrollBar.x;
						this._scrollThumb.y = this.calculateScrollThumbPosition();
						this._scrollThumb.width = this._scrollThumbWidth;
						this._scrollThumb.height = this._scrollThumbHeight;
						this._scrollThumb.backgroundColor = this._scrollThumbColor;
						
						maskWidth = this.width - this._scrollBarWidth;
						maskHeight = this.height;
					} else {
						Logger.debug("Content is smaller (" + this._content.height + " px) than scroll content area (" + this.height + " px). Hiding scrollbar.");
						
						// content is smaller than scroll area so we can hide scrollbar
						this._scrollBar.visible = false;
						this._scrollThumb.visible = false;
						
						maskWidth = this.width;
						maskHeight = this.height;
						
						this._content.y = 0;
					}
					
					this._mask.graphics.beginFill(0x0000ff, 1);
					this._mask.graphics.drawRect(
						0, 
						0, 
						this.width - (this._scrollBarMarginTop + this._scrollBarMarginBottom),
						this.height
					);
					this._mask.graphics.endFill();
					
					this._content.mask = this._mask;
				}
				
			} else {
				
				if (this._content != null) {
					this._content.y = 0;
				}
				
				this._scrollBar.visible = false;
				this._scrollThumb.visible = false;
			}
			
			this.graphics.clear();
			this.graphics.beginFill(this._scrollAreaBackgroundColor, this._scrollAreaBackgroundAlpha);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.endFill();
			
			this.setChildIndex(this._scrollBar, this.numChildren - 1);
			this.setChildIndex(this._scrollThumb, this.numChildren - 1);
			
			this._scrollBar.render();
			this._scrollThumb.render();
		}
		
		protected function calculateScrollThumbPosition():Number {
			
			if (this._content != null) {
				var maxOffset:Number = this._content.height - this.getMask().height;
				if (maxOffset > 0) {
					
					var contentOffset:Number = Math.abs(this._content.y);
					
					var ratio:Number = contentOffset / maxOffset;
					
					var scrollThumbMaxY:Number = this.getScrollRectangle().height;
					
					return scrollThumbMaxY * ratio + this._scrollBarMarginTop;
				} else {
					return this._scrollBarMarginTop;
				}
			}
			return this._scrollBarMarginTop;
		}
		
		protected function setScrollDefaultPosition():void {
			this._scrollThumb.y = this._scrollBar.y + this._scrollBarMarginTop;
		}
		
		public function set content(value:DisplayObject):void {
			
			this._content = value;
			if (! this.contains(this._content)) {
				this.addChild(this._content);
			}
			this._lastContentHeight = this._content.height;
		}
		
		public function get content():DisplayObject {
			return _content;
		}
		
		public function dropContent():void {
			if (this._content != null) {
				this._content.mask = null
				if (this.contains(this._content)) {
					this.removeChild(this._content);
				}
			}
			this._lastContentHeight = 0;
		}
		
		public function get scrollBarWidth():Number {
			return this._scrollBarWidth;
		}
		
		public function set scrollBarWidth(value:Number):void {
			this._scrollBarWidth = value;
			this.render();
		}
		
		public function get scrollThumbHeight():Number {
			return this.scrollThumbHeight;	
		}
		
		public function set scrollThumbHeight(value:Number):void {
			this._scrollThumbHeight = value;
			this.render();
		}
		
		public function get scrollBarMarginTop():Number {
			return this._scrollBarMarginTop;
		}
		
		public function set scrollBarMarginTop(value:Number):void {
			this._scrollBarMarginTop = value;
			this.render();
		}
		
		public function get scrollBarMarginBottom():Number {
			return this._scrollBarMarginBottom;
		}
		
		public function set scrollBarMarginBottom(value:Number):void {
			this._scrollBarMarginBottom = value;
			this.render();
		}
		
		public function get scrollBarBackgroundColor():uint {
			return this._scrollBarBackgroundColor;
		}
		
		public function set scrollBarBackgroundColor(value:uint):void {
			this._scrollBarBackgroundColor = value;
			this.render();
		}
		
		public function get scrollBarBackgroundAlpha():Number {
			return this._scrollBarBackgroundAlpha;
		}
		
		public function set scrollBarBackgroundAlpha(value:Number):void {
			this._scrollBarBackgroundAlpha = value;
			this.render();
		}
		
		public function get scrollThumbColor():uint {
			return this._scrollThumbColor;
		}
		
		public function set scrollThumbColor(value:uint):void {
			this._scrollThumbColor = value;
			this.render();
		}
		
		public function get scrollThumbWidth():Number {
			return this._scrollThumbWidth;
		}
		
		public function set scrollThumbWidth(value:Number):void {
			this._scrollThumbWidth = value;
			this.render();
		}
		
		public function get scrollAreaBackgroundColor():uint {
			return this._scrollAreaBackgroundColor;
		}
		
		public function set scrollAreaBackgroundColor(value:uint):void {
			this._scrollAreaBackgroundColor = value;
			this.render();
		}
		
		public function get scrollAreaBackgroundAlpha():Number {
			return this._scrollAreaBackgroundAlpha;
		}
		
		public function set scrollAreaBackgroundAlpha(value:Number):void {
			this._scrollAreaBackgroundAlpha = value;
			this.render();
		}
		
		public function get scrollBarBorderColor():uint {
			return this._scrollAreaBackgroundColor;
		}
		
		public function set scrollBarBorderColor(value:uint):void {
			this._scrollBarBorderColor = value;
			this.render();
		}
		
		public function get scrollBarBorderAlpha():Number {
			return this._scrollBarBorderAlpha;
		}
		
		public function set scrollBarBorderAlpha(value:Number):void {
			this._scrollBarBorderAlpha = value;
			this.render();
		}
		
		public function get scrollBarBorderSize():uint {
			return this._scrollBarBorderSize;
		}
		
		public function set scrollBarBorderSize(value:uint):void {
			this._scrollBarBorderSize = value;
			this.render();
		}
		
		public function getScrollThumb():BackgroundedComponent {
			return this._scrollThumb;
		}
		
		public function getScrollBar():BackgroundedComponent {
			return this._scrollBar;
		}
		
		public function get canScroll():Boolean {
			return (this._content != null && this._content.height > this._mask.height);
		}
		
		public function getMask():Shape {
			return this._mask;
		}
		
		public function getScrollRectangle():Rectangle {
			return new Rectangle(
				this._scrollBar.x,
				this._scrollBar.y + this._scrollBarMarginTop,
				0,
				this._scrollBar.height - (this._scrollBarMarginTop + this._scrollBarMarginBottom + this._scrollThumb.height)
			);	
		}
		
		public function get isEnabled():Boolean {
			return this._isEnabled;
		}
		
		public function set isEnabled(value:Boolean):void {
			this._isEnabled = value;
			this.render();
		}
		
		public function get lastContentHeight():Number {
			return this._lastContentHeight;
		}
		
		public function set lastContentHeight(value:Number):void {
			this._lastContentHeight = value;
		}
	}
}