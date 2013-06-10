package inf.application.views.components {
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ButtonComponent class
	 * @author inf
	 */
	public class ButtonComponent extends BackgroundedComponent {
		
		private var _text:TextField;
		
		public function ButtonComponent(text:String = "", width:Number=0, height:Number=0, align:String=BackgroundedComponent.LEFT_TOP, bgColor:uint=0xffffff, bgAlpha:Number=1, borderSize:Number=1, borderColor:uint=0, borderAlpha:Number=1) {
			super(width, height, align, bgColor, bgAlpha, borderSize, borderColor, borderAlpha);
			
			this._text = new TextField();
			this._text.htmlText = text;
			this._text.selectable = false;
			
			this.addChild(this._text);
		}
		
		
		public override function render():void {
			
			super.render();
			
			//this._text.x = (this.width - this._text.textWidth) / 2;
			this._text.width = this.width;
			
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			this._text.setTextFormat(tf);
				
			this.setChildIndex(this._text, this.numChildren - 1);
		}
		
		public function setText(value:String):void {
			this._text.htmlText = value;
		}
		
		public function get textField():TextField {
			return this._text;
		}
	}
}