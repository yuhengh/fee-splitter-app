package
{
    import feathers.controls.LayoutGroup;
    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.controls.StackScreenNavigator;
    import feathers.controls.StackScreenNavigatorItem;
    import feathers.motion.Cover;
    import feathers.motion.Reveal;

    import starling.display.DisplayObject;

    public class RecordScreen extends LayoutGroup
    {
        public static const RECORD_LIST:String = "recordList";
        public static const RECORD_ADD:String = "recordAdd";

        public static const RECORD_START:String = "recordStart";
        public static const RECORD_END:String = "recordEnd";

        private var _navigator:StackScreenNavigator;

        public function RecordScreen()
        {
            _navigator = new StackScreenNavigator();
            addRecordListScreen();
            addRecordAddScreen();
            addChild(_navigator);

            _navigator.pushScreen(RECORD_LIST);
        }

        private function addRecordListScreen():void
        {
            var screen:DisplayObject = new RecordListScreen();
            var item:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen);
            item.setScreenIDForPushEvent(RECORD_START, RECORD_ADD);
            _navigator.addScreen(RECORD_LIST, item);
        }

        private function addRecordAddScreen():void
        {
            var screen:DisplayObject = new RecordAddScreen();
            var item:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen);
            item.addPopEvent(RECORD_END);
            item.pushTransition = Cover.createCoverUpTransition();
            item.popTransition = Reveal.createRevealDownTransition();
            _navigator.addScreen(RECORD_ADD, item);
        }
    }
}
