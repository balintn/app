package inf.application.views.widgets {
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * BackgroundedSprite class
	 * @author inf
	 */
	public class BackgroundedSprite extends BaseComponent {
		
		public static const LEFT_TOP:String = "top-left";
		public static const LEFT_MIDDLE:String = "middle-left";
		public static const LEFT_BOTTOM:String = "bottom-left";
		
		public static const CENTER_TOP:String = "top-center";
		public static const CENTER_MIDDLE:String = "middle-center";
		public static const CENTER_BOTTOM:String = "bottom-center";
		
		public static const RIGHT_TOP:String = "top-right";
		public static const RIGHT_MIDDLE:String = "middle-right";
		public static const RIGHT_BOTTOM:String = "middle-bottom";
		
		private var _align:String;
		private var _backgroundColor:uint;
		private var _backgroundAlpha:Number;
		
		private var _borderSize:Number;
		private var _borderColor:uint;
		private var _borderAlpha:Number;
		
		private var _background:Shape;
		
		
		public function BackgroundedSprite(width:Number = 0, height:Number = 0, align:String = BackgroundedSprite.LEFT_TOP, bgColor:uint = 0xffffff, bgAlpha:Number = 1, borderSize:Number = 1, borderColor:uint = 0, borderAlpha:Number = 1) {
			super(width, height);
			
			this._backgroundColor = bgColor;
			this._backgroundAlpha = bgAlpha;
			this._align = align;
			
			this._borderSize = borderSize;
			this._borderColor = borderColor;
			this._borderAlpha = borderAlpha;
			
			this._background = new Shape();
			this.addChild(this._background);
		}
		
		public override function render():void {
			
			this._background.graphics.clear();
			
			this._background.graphics.beginFill(this._backgroundColor, this._backgroundAlpha);
			this._background.graphics.lineStyle(this._borderSize, this._borderColor, this._borderAlpha);
			
			switch (this._align) {
				
				case BackgroundedSprite.LEFT_TOP:
					this._background.graphics.drawRect(0, 0, this.width, this.height);
					break;
				
				case BackgroundedSprite.LEFT_MIDDLE:
					this._background.graphics.drawRect(0, -this.height / 2, this.width, this.height);
					break;
				
				case BackgroundedSprite.LEFT_BOTTOM:
					this._background.graphics.drawRect(0, -this.height, this.width, this.height);
					break;
				
				case BackgroundedSprite.CENTER_TOP:
					this._background.graphics.drawRect(-this.width / 2, 0, this.width, this.height);
					break;
				
				case BackgroundedSprite.CENTER_MIDDLE:
					this._background.graphics.drawRect(-this.width / 2, -this.height / 2, this.width, this.height);
					break;
				
				case BackgroundedSprite.CENTER_BOTTOM:
					this._background.graphics.drawRect(-this.width / 2, -this.height, this.width, this.height);
					break;
				
				case BackgroundedSprite.RIGHT_TOP:
					this._background.graphics.drawRect(-this.width, 0, this.width, this.height);
					break;
				
				case BackgroundedSprite.RIGHT_MIDDLE:
					this._background.graphics.drawRect(-this.width, -this.height / 2, this.width, this.height);	
					break;
				
				case BackgroundedSprite.RIGHT_BOTTOM:
					this._background.graphics.drawRect(-this.width, -this.height, this.width, this.height);
					break;					
			}
			
			this._background.graphics.endFill();
		}
		
		public function set backgroundAlpha(value:Number):void {
			this._backgroundAlpha = value;
		}
		
		public function set backgroundColor(value:uint):void {
			this._backgroundColor = value;
		}
		
		public function set align(v:String):void {
			
			switch (v) {
				case BackgroundedSprite.LEFT_TOP:
				case BackgroundedSprite.LEFT_MIDDLE:
				case BackgroundedSprite.LEFT_BOTTOM:
				case BackgroundedSprite.CENTER_TOP:
				case BackgroundedSprite.CENTER_MIDDLE:
				case BackgroundedSprite.CENTER_BOTTOM:
				case BackgroundedSprite.RIGHT_TOP:
				case BackgroundedSprite.RIGHT_MIDDLE:
				case BackgroundedSprite.RIGHT_BOTTOM:
					this._align = v;
					break;
				
				default:
					this._align = BackgroundedSprite.LEFT_TOP;
					break;
			}
		}
		
		public function set borderSize(value:Number):void {
			this._borderSize = value;
		}
		
		public function set borderColor(value:uint):void {
			this._borderColor = value;
		}
		
		public function set borderAlpha(value:Number):void {
			this._borderAlpha = value;
		}
		
		public function get backgroundAlpha():Number {
			return this._backgroundAlpha;
		}
		
		public function get backgroundColor():uint {
			return this._backgroundColor;
		}
		
		public function get align():String {
			return this._align;
		}
		
		public function get borderSize():Number {
			return this._borderSize;
		}
		
		public function get borderColor():uint {
			return this._borderColor;
		}
		
		public function get borderAlpha():Number {
			return this._borderAlpha;
		}
		
	}
}