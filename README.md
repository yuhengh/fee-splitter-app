# Fee splitter 
## a sample app built with Starling 2/Feathers 3/Starling Builder 2

### Background

Some people ask if it's possible to create app using [Starling Builder](http://starlingbuilder.github.io) with Feathers UI. The answer is yes. Previously the primary focus of Starling Builder is to support games, but now it's time to pay a visit to making an app.

Fee splitter is an utility app to help you split fee with your friends. It’s built with Starling, Feathers and also with some help from Starling Builder. It can run on Android, iOS and web with the Flash Player plug-in. Since the primary purpose of this app is to showcase the usage, it's trying to simplify things as much as possible.

### Running the app

If you are using IntelliJ IDEA, you can just open the folder to get everything ready to go. Otherwise you will need to setup the project manually.
If you are using other IDEs, you should set src/Main.as as main class for mobile build and src/MainWeb.as as main class for web build. You can take a look at the online demo from the link below:

http://yuhengh.github.io/fee-splitter-app/deliverable/web.html

The app is also available on iOS App Store

https://itunes.apple.com/us/app/fee-splitter/id1188854919

and Google Play

https://play.google.com/store/apps/details?id=air.johannh.FeeSplitter


### Editing layouts

Open Starling Builder, choose the workspace folder from the repo, then you can open the layout files in src/layouts folder to see them correctly.

**NOTES:** This project is using a different EmbeddedTheme.swf from the demo workspace. The reason is the app is using ScreenDensityScaleFactorManager to support multiple resolution. Starling from Feathers UI 3.x, ScreenDensityScaleFactorManager assumes that every mobile theme has a default scale factor of 2. In order to make the editor consistent with this setting, the EmbeddedTheme.swf for this project is also built with a theme with a scale factor of 2.

You may ask why the demo workspace EmbeddedTheme.swf is using a default scale factor of 1 instead of 2. It’s because the Starling Builder scale factor is default to 1 from the earliest day, which the [multiple resolution approach](http://wiki.starling-framework.org/builder/multiple_resolution) relies on. For more information about how to build EmbeddedTheme.swf, check out the [custom theme](http://wiki.starling-framework.org/builder/theme) document.


### Conclusion

* Not every Feathers UI component is designed to work with the editor.
* For UI components that require setup by code, it's still recommended to write code in the good old way to have full control of it.
* For others that are more straight forward to setup by setting properties, Starling Builder is a good way to save your time.
* You can fine tune different layouts in the editor to get the value (padding, gap, etc) right at your sight.

![](http://yuhengh.github.io/fee-splitter-app/screenshots/screenshot1.png)
![](http://yuhengh.github.io/fee-splitter-app/screenshots/screenshot2.png)
