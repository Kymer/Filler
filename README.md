# Filler
Filler is a macOS [JXA](https://developer.apple.com/library/content/releasenotes/InterapplicationCommunication/RN-JavaScriptForAutomation/Articles/Introduction.html) script which automates insertion of a ticket name in commit messages in GUI-based git applications such as Tower or SourceTree.

![tower-demo](readme-assets/demo-tower.gif)

# How it works
The script uses macOS GUI scripting to 'extract' UI elements from Cocoa-based applications. This can be done with Apple Script or JavaScript (JXA). The UI elements can be manipulated as needed. This is obviously not a robust solution, as any update to the application (and thus UI hierarchy) may break the script. A better way to interact with applications is by means of [Apple Events](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ScriptableCocoaApplications/SApps_handle_AEs/SAppsHandleAEs.html), but not all apps expose or support those. For applications which don't expose Apple Events, UI automation is a valid, yet slightly cumbersome, alternative.

To explore the UI hierarchy of any Cocoa application you can use tools such as:

- Apple's [Accessibility Inspector](https://developer.apple.com/library/content/documentation/Accessibility/Conceptual/AccessibilityMacOSX/OSXAXTestingApps.html) (included with Xcode)
- PFiddlesoft's excellent [UI Browser](http://pfiddlesoft.com/uibrowser/) (which can output usable AppleScript snippets)

The relevant UI elements, such as the commit field, can be referenced with JXA like so:

```
Application('System Events').processes['Tower'].windows[0].splitterGroups[0].splitterGroups[0].textFields[1].value()
```
# Download

Below can download an exported version of the script as stabdalone "stay-open" app:

- [Tower](https://github.com/Kymer/Filler/raw/master/builds/Tower%20Helper.app.zip)
- [SourceTree](https://github.com/Kymer/Filler/raw/master/builds/SourceTree%20Helper.app.zip)


# TODO
- [ ] Readme: Add 'installation' instructions
- [ ] Script: Make ticket name reg ex more flexible

# Useful links
- [How Cocoa Applications Handle Apple Events](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ScriptableCocoaApplications/SApps_handle_AEs/SAppsHandleAEs.html) - official documentation by Apple
- [Getting Started with JavaScript for Automation on Yosemite](https://www.macstories.net/tutorials/getting-started-with-javascript-for-automation-on-yosemite/) - by Alex Guyot on MacStories
- [JXA Cookbook](https://github.com/dtinth/JXA-Cookbook/wiki) - by Thai Pangsakulyanont on GitHub
- [List of JXA resources](https://gist.github.com/JMichaelTX/d29adaa18088572ce6d4) - by JMichaelTX on GitHub

## License

MIT © Kymer Gryson
