package inf.application.views.components {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * DraggedImageComponent class
	 * @author inf
	 */
	public class DraggedImageComponent extends ResizableComponent {
		
		private var _image:DisplayObject;
		
		private var _fakeBackground:BackgroundedComponent;
		
		public function DraggedImageComponent() {
			
			this._fakeBackground = new BackgroundedComponent();
			this.addChild(this._fakeBackground);
			
			super();
			
			this.backgroundAlpha = 0;
			this.borderAlpha = 0;
		}
		
		public function addImage(image:DisplayObject):void {
			if (this._image != null) {
				this.removeImage();
			}
			
			this.addChild(image);
			this._image = image;
			
			this.width = image.width;
			this.height = image.height;
		}
		
		public function removeImage():void {
			if (this._image != null) {
				if (this.contains(this._image)) {
					this.removeChild(this._image);
				}
				this._image = null;
			}
		}
		
		public override function render():void {
			super.render();
			
			this._fakeBackground.backgroundAlpha = 0;
			this._fakeBackground.borderAlpha = 0;
			this._fakeBackground.width = (this._image != null) ? this._image.width : 0;
			this._fakeBackground.height = (this._image != null) ? this._image.height : 0;
			
			this._fakeBackground.render();
		}
		
		protected override function onThumbEnterframe(event:Event):void {
			super.onThumbEnterframe(event);
			
			if (this._image != null) {
				this._image.width = this.width;
				this._image.height = this.height;
			}
		}
		
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			this._fakeBackground.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			this._fakeBackground.removeEventListener(type, listener, useCapture);
		}
		
		public override function hasEventListener(type:String):Boolean {
			return this._fakeBackground.hasEventListener(type);
		}
	}
}