# WebViewer

**Usage**
To push your web view you need to do the following steps:

1. import WebViewer

2. Just do it in your controller

let content = LinkContent(url: URL(string: "https://www.google.com")!, title: "Google")
let coordinator = LinkViewerCoordinator(content: content, controller: self, delegate: self)
coordinator.start()

3. Implement *LinkViewerCoordinatorDelegate* in your controller

That's it.

**Installation**
1) cd /Project.xcodeproj

2) git submodule add https://github.com/tarasChernysh/WebViewer.git 

3) drag to root directory file WebViewer.xcodeproj(uncheck Copy if needed)

4) add WebViewer like framework to your project (Target -> General -> Frameworks)

That's it.

