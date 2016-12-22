package
{
    import feathers.controls.LayoutGroup;
    import feathers.controls.StackScreenNavigator;
    import feathers.controls.StackScreenNavigatorItem;
    import feathers.motion.Cover;
    import feathers.motion.Reveal;

    import starling.display.DisplayObject;

    public class ContactScreen extends LayoutGroup
    {
        public static const CONTACT_LIST:String = "contactList";
        public static const CONTACT_REGISTER:String = "contactRegister";

        public static const REGISTER_START:String = "registerStart";
        public static const REGISTER_END:String = "registerEnd";

        private var _navigator:StackScreenNavigator;

        public function ContactScreen()
        {
            _navigator = new StackScreenNavigator();
            addContactListScreen();
            addContactRegisterScreen();
            addChild(_navigator);
            _navigator.pushScreen(CONTACT_LIST);
        }

        private function addContactListScreen():void
        {
            var screen:DisplayObject = new ContactListScreen();
            var item:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen);
            item.setScreenIDForPushEvent(REGISTER_START, CONTACT_REGISTER);
            _navigator.addScreen(CONTACT_LIST, item);
        }

        private function addContactRegisterScreen():void
        {
            var screen:DisplayObject = new ContactRegisterScreen();
            var item:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen);
            item.addPopEvent(REGISTER_END);
            item.pushTransition = Cover.createCoverUpTransition();
            item.popTransition = Reveal.createRevealDownTransition();
            _navigator.addScreen(CONTACT_REGISTER, item);
        }
    }
}
