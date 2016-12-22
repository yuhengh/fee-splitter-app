package
{
    import feathers.system.DeviceCapabilities;
    import flash.text.TextField;

    import starling.core.Starling;
    import starling.events.Event;

    [SWF(frameRate=60, width=640, height=960)]
    public class MainWeb extends Main
    {
        public function MainWeb()
        {
            super();
        }

        override protected function init():void
        {
            //simulating iPhone Retina
            DeviceCapabilities.dpi = 326;

            _starling = new Starling(App, stage);
            _starling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, _start);

            super.init();
        }
    }
}
