package inf.application.mediators {
	
	import caurina.transitions.Tweener;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import inf.application.ApplicationFacade;
	import inf.application.views.components.BackgroundedComponent;
	import inf.application.views.components.ScrollComponent;
	import inf.utils.Logger;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ScrollMediator extends Mediator {
		
		private static var numOfInstance:uint = 0;
		
		public static const NAME:String = "scrollMediator";
		
		private var _id:String;
		
		private var _animatedScroll:Boolean = false;
		private var _animationDuration:Number = .8;
		
		
		public function ScrollMediator(viewComponent:Object=null, id:String = null) {
			
			ScrollMediator.numOfInstance++;
			
			if (id != null) {
				this._id = id;
			} else {
				this._id = ScrollMediator.numOfInstance + "";
			}
			
			super(ScrollMediator.NAME + this._id, viewComponent);
		}
		
		
		public function setScrollContent(content:DisplayObject):void {
			var view:ScrollComponent = this.getView();
			view.content = content;
			
			var thumb:BackgroundedComponent = view.getScrollThumb();
			
			if (! thumb.hasEventListener(MouseEvent.MOUSE_DOWN)) {
				thumb.addEventListener(MouseEvent.MOUSE_DOWN, this.onThumbMouseDown);
			}
			if (! thumb.hasEventListener(MouseEvent.MOUSE_UP)) {
				thumb.addEventListener(MouseEvent.MOUSE_UP, this.onThumbMouseUp);
				var _stage:Stage = DisplayObject(view.stage) as Stage;
				if (_stage == null) {
					Logger.warn("Stage is null! Scroll interactions will not work well! You should add this display object to the display list before you set the scroll content!");	
				} else {
					_stage.addEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUp);
				}
			}
			view.render();
		}
		
		public function forceRender():void {
			this.getView().render();
		}
		
		public function dropContent():void {
			this.getView().dropContent();	
		}
		
		protected function onStageMouseUp(event:MouseEvent):void {
			this.onThumbMouseUp(event);
		}
		
		protected function onThumbMouseDown(event:MouseEvent):void {
			Sprite(event.target).startDrag(false, this.getView().getScrollRectangle());
			Sprite(event.target).addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		}
		
		protected function onThumbMouseUp(event:MouseEvent):void {
			var view:ScrollComponent = this.getView();
			var thumb:BackgroundedComponent = view.getScrollThumb();
			var _stage:Stage = DisplayObject(view.stage) as Stage;
			if (_stage != null) {
				_stage.removeEventListener(MouseEvent.MOUSE_UP, this.onThumbMouseUp);
			}
			
			thumb.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			thumb.stopDrag();
		}
		
		protected function onEnterFrame(event:Event):void {
			
			var view:ScrollComponent = this.getView();
			var _stage:Stage = DisplayObject(view.stage) as Stage;
			// check if mouse left the stage
			if (_stage.mouseX < 0 || _stage.mouseX > _stage.stageWidth || _stage.mouseY < 0 || _stage.mouseY > _stage.stageHeight) {
				this.onThumbMouseUp(new MouseEvent("fakeEvent"));
			}
			
			var rect:Rectangle = view.getScrollRectangle();
			var maxHeight:Number = view.getScrollRectangle().height;
			
			var thumbY:Number = Sprite(event.target).y - view.scrollBarMarginTop; 
			
			var ratio:Number = thumbY / maxHeight;
			
			var availableContentOffset:Number = (view.content.height < view.getMask().height) ? 0 : view.content.height - view.getMask().height;
			var offset:Number = availableContentOffset * ratio;
			
			if (this.isAnimatedScrool) {
				Tweener.addTween(view.content, {y: -offset, time: this._animationDuration});
			} else {
				view.content.y = -offset;
			}
		}
		
		public function get id():String {
			return this._id;
		}
		
		public function get name():String {
			return ScrollMediator.NAME + this._id;
		}
		
		public function getView():ScrollComponent {
			return this.viewComponent as ScrollComponent;
		}
		
		public function set animatedScroll(value:Boolean):void {
			this._animatedScroll = value;
		}
		
		public function get isAnimatedScrool():Boolean {
			return this._animatedScroll;
		}
		
		public function set animationDuration(value:Number):void {
			this._animationDuration = value;
		}
		
		public function get animationDuration():Number {
			return this._animationDuration;
		}
		
		public function get isEnabled():Boolean {
			return this.getView().isEnabled;
		}
		
		public function set isEnabled(value:Boolean):void {
			this.getView().isEnabled = value;
		}
	}
}