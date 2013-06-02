package inf.application.views.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import inf.application.ApplicationFacade;
	
	public class ResizableComponent extends BackgroundedComponent {
		
		/**
		 * @TODO no ennek nem itt a helye, kell csinalni szepen kontrollert es minden olyat atvezetni oda!!
		 */
		public static const RESIZE_FINISHED:String = "resizeFinished";
		
		public static const MIN_WIDTH:Number = 5;
		public static const MIN_HEIGHT:Number = 5;
		
		private var _thumb:BackgroundedComponent;
		
		private var _thumbOffsetX:Number = 3;
		private var _thumbOffsetY:Number = 3;
		
		public function ResizableComponent(width:Number=0, height:Number=0, align:String=BackgroundedComponent.LEFT_TOP, bgColor:uint=0xffffff, bgAlpha:Number=1, borderSize:Number=1, borderColor:uint=0, borderAlpha:Number=1) {
			super(width, height, align, bgColor, bgAlpha, borderSize, borderColor, borderAlpha);
			
			this._thumb = new BackgroundedComponent(10, 10);
			this._thumb.visible = true;
			
			this.addChild(this._thumb);
			
			this._thumb.x = this.width + this._thumbOffsetX;
			this._thumb.y = this.height + this._thumbOffsetY;
			
			this._thumb.addEventListener(MouseEvent.MOUSE_DOWN, this.onThumbMouseDown);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onComponentAddedToStage);
		}

		protected function onComponentAddedToStage(event:Event):void {
			
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onComponentAddedToStage);
			
			this._thumb.addEventListener(MouseEvent.MOUSE_OVER, this.onThumbMouseOver);
			this._thumb.addEventListener(MouseEvent.MOUSE_OUT, this.onThumbMouseOut);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, this.onThumbMouseUp);
		}
		
		protected function onThumbMouseOver(event:MouseEvent):void {
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		protected function onThumbMouseOut(event:MouseEvent):void {
			if (! this._thumb.hasEventListener(Event.ENTER_FRAME)) {
				Mouse.cursor = MouseCursor.AUTO;
				// TODO nem itt a helye, olvasd el felul
				ApplicationFacade.getInstance().sendNotification(ResizableComponent.RESIZE_FINISHED);
			}
		}
		
		protected function onThumbMouseDown(event:MouseEvent):void {
			if (! this._thumb.hasEventListener(Event.ENTER_FRAME)) {
				this._thumb.addEventListener(Event.ENTER_FRAME, this.onThumbEnterframe);
			}
		}
		
		protected function onThumbMouseUp(event:MouseEvent):void {
			this._thumb.removeEventListener(Event.ENTER_FRAME, this.onThumbEnterframe);
			Mouse.cursor = MouseCursor.AUTO;
			// TODO nem itt a helye, olvasd el felul
			ApplicationFacade.getInstance().sendNotification(ResizableComponent.RESIZE_FINISHED);
		}
		
		protected function onThumbEnterframe(event:Event):void {
			
			var newX:Number = this.mouseX - this._thumbOffsetX;
			var newY:Number = (this.mouseX - this._thumbOffsetX) * this.height / this.width;

			if (newX <= ResizableComponent.MIN_WIDTH || newY <= ResizableComponent.MIN_HEIGHT) {
				return;
			}
			
			this._thumb.x = newX;
			this._thumb.y = newY;
			
			this.width = newX;
			this.height = newY;
			
			this.render();
			
		}
		
		public override function render():void {
			super.render();
			
			if (this._thumb != null) {
				this._thumb.x = this.width + this._thumbOffsetX;
				this._thumb.y = this.height + this._thumbOffsetY;
				
				this._thumb.render();
				
				this.setChildIndex(this._thumb, this.numChildren - 1);
			}
		}
		
		public function hideThumb():void {
			this._thumb.visible = false;
		}
		
		public function showThumb():void {
			this._thumb.visible = true;
		}
		
		public function get thumb():BackgroundedComponent {
			return this._thumb;
		}
		
	}
}