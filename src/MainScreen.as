package
{
    import feathers.controls.TabNavigator;
    import feathers.controls.TabNavigatorItem;

    import starling.display.Sprite;

    public class MainScreen extends Sprite
    {
        public static const CONTACT:String = "contact";
        public static const RECORD:String = "record";
        public static const SUMMARY:String = "profile";

        private var _navigator:TabNavigator;

        private static var _instance:MainScreen;

        public static function get instance():MainScreen
        {
            return _instance;
        }

        public function MainScreen()
        {
            _instance = this;

            _navigator = new TabNavigator();
            addContactsTab();
            addRecordsTab();
            addSummaryTab();

            addChild(_navigator);
        }

        private function addContactsTab():void
        {
            var screen:ContactScreen = new ContactScreen();
            var item:TabNavigatorItem = new TabNavigatorItem(screen, "Contacts");
            _navigator.addScreen(CONTACT, item);
        }

        private function addRecordsTab():void
        {
            var screen:RecordScreen = new RecordScreen();
            var item:TabNavigatorItem = new TabNavigatorItem(screen, "Records");
            _navigator.addScreen(RECORD, item);
        }

        private function addSummaryTab():void
        {
            var screen:SummaryScreen = new SummaryScreen();
            var item:TabNavigatorItem = new TabNavigatorItem(screen, "Summary");
            _navigator.addScreen(SUMMARY, item);
        }
    }
}
