/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package {
    import feathers.utils.ScreenDensityScaleFactorManager;

    import flash.text.TextField;

    import flash.display.Sprite;
    import flash.events.Event;

    import starling.core.Starling;

    [SWF(frameRate=60, width=640, height=960)]
    public class Main extends Sprite
    {
        protected var _starling : Starling;

        public function Main()
        {
            //workaround for flash TextField initial delay bug
            var tf:TextField = new TextField();
            tf.text = "tf";

            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        protected function _start(e:Event):void
        {
            _starling.stage3D.removeEventListener(Event.CONTEXT3D_CREATE, _start);

            _starling.start();
        }

        private function onEnterFrame(event:Event):void
        {
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            init();
        }

        protected function init():void
        {
            _starling = new Starling(App, stage);
            new ScreenDensityScaleFactorManager(_starling);
            _starling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, _start);
        }
    }
}

