/**
 * ...
 * @author Lounek
 */

class SpellIcon 
{
    static var _mcRoot:MovieClip;
    static var _this:SpellIcon;
    
    var _mcBack:MovieClip;
    var _mcUp:MovieClip;
    
    var _backUrl:String;
    var _upUrl:String;
    var _backgroundColor:Number;
    var _frameColor:Number;
    var _printColor:Number;
    
    public function SpellIcon(backUrl:String, upUrl:String, backgroundColor:Number, frameColor:Number, printColor:Number)
    {
        this._backUrl = backUrl;
        this._upUrl = upUrl;
        this._backgroundColor = backgroundColor;
        this._frameColor = frameColor;
        this._printColor = printColor;
        
        this.showIcon();
    }
    
    public static function main(swfRoot:MovieClip):Void 
    {
        SpellIcon._mcRoot = swfRoot;
        SpellIcon._this = new SpellIcon(swfRoot.b, swfRoot.up, swfRoot.bc, swfRoot.fc, swfRoot.pc);
    }
    
    private function showIcon():Void
    {
        this._mcBack = SpellIcon._mcRoot.createEmptyMovieClip("back", SpellIcon._mcRoot.getNextHighestDepth());
        this._mcUp = SpellIcon._mcRoot.createEmptyMovieClip("up",SpellIcon._mcRoot.getNextHighestDepth());
        
        var mcLoader:MovieClipLoader = new MovieClipLoader();
        mcLoader.addListener(this);
        mcLoader.loadClip(this._backUrl, this._mcBack);
        mcLoader.loadClip(this._upUrl, this._mcUp);
    }
    
    private function applyBackColors(backgroundColor:Number, frameColor:Number):Void
    {
        var spellBackground:MovieClip = getSWFChildByName(this._mcBack, "_spellBackground");
        if(spellBackground != null)
        {
            var color:Color = new Color(spellBackground);
            color.setRGB(backgroundColor);
        }
        
        var spellFrame:MovieClip = getSWFChildByName(this._mcBack, "_spellFrame");
        if(spellFrame != null)
        {
            var color:Color = new Color(spellFrame);
            color.setRGB(frameColor);
        }
    }
    
    private function applyUpColors(printColor):Void
    {
        var spellPrint:MovieClip = getSWFChildByName(this._mcUp, "_spellPrint");
        if(spellPrint != null)
        {
            var color:Color = new Color(spellPrint);
            color.setRGB(printColor);
        }
    }
    
    private function getSWFChildByName(container:MovieClip, childName:String):MovieClip 
    {
        for (var n:String in container) 
        {
            var child:MovieClip = container[n];
            
            if (child._name == childName)
            {
                return child;
            }
            
            if (child instanceof MovieClip)
            {
                var foundChild:MovieClip = getSWFChildByName(child, childName);
                if (foundChild != null) 
                {
                    return foundChild;
                }
            }
        }
        
        return null;
    }
    
    private function onLoadInit(mc:MovieClip):Void
    {
        if (mc === this._mcBack)
        {
            this.applyBackColors(this._backgroundColor, this._frameColor);
        }
        else if (mc === this._mcUp)
        {
            this.applyUpColors(this._printColor);
        }
    }
}