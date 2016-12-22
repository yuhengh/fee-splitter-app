/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package
{
    import feathers.themes.MetalWorksMobileTheme;

    import starling.display.Sprite;
    import starling.utils.AssetManager;

    import starlingbuilder.engine.DefaultAssetMediator;
    import starlingbuilder.engine.IAssetMediator;
    import starlingbuilder.engine.IUIBuilder;
    import starlingbuilder.engine.UIBuilder;

    public class App extends Sprite
    {
        private var _assetManager:AssetManager;
        private var _assetMediator:IAssetMediator;

        public static var uiBuilder:IUIBuilder;

        public function App()
        {
            _assetManager = new AssetManager();
            _assetMediator = new DefaultAssetMediator(_assetManager);
            uiBuilder = new UIBuilder(_assetMediator);

            //_assetManager.enqueue(EmbeddedAssets);
            //_assetManager.enqueue(File.applicationDirectory.resolvePath("textures"));
            _assetManager.loadQueue(function(ratio:Number):void{
                if (ratio == 1)
                {
                    init();
                }
            });
        }

        private function init():void
        {
            new MetalWorksMobileTheme();
            addChild(new MainScreen());
        }
    }
}
