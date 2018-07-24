import 'dart:chrome';

void main() {
  chrome.app.runtime.onLaunched.addListener((AppRuntimeLaunchData launchData) {
    chrome.app.window.create('chromeapp1.html',
        new AppWindowCreateWindowOptions(width: 800, height: 600));
  });
}
