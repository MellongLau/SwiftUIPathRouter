# SwiftUIRouter
SwiftUIPathRouter is a navigation router solution for SwiftUI

## Usage
### 💡 Check out [Example](https://github.com/MellongLau/SwiftUIPathRouter/tree/main/SwiftUIPathRouter/App) for more.

1. Add dependency:
   
    `pod 'Sourcery'`

   Then turn off the build option `User Script Sandboxing` if you get the relate error.
   Add run script to `Build Phases`: `$PODS_ROOT/Sourcery/bin/sourcery --config .sourcery.yml`, it should be above the `Compile Sources` section.
4. Copy `Template` folder and sourcery config file `.sourcery.yml` to your project.
5. Update `.sourcery.yml` setting to match your preject structure.
6. Copy `Router` folder to your project.
7. Create some views with `// sourcery: route` comment above the view.
``` swift
// sourcery: route
struct LoginView: View {
    @ObservedObject var router: Router
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login page")
            Button {
                router.dismiss()
            } label: {
                Text("Close")
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            }
        }

    }
}
```
8. Navigate example like below:
```swift
NavigationLink(route: .login, router: router) {
    Text("Navigation link")
}
NavigationLink(urlString: "/push/about", router: router) {
    Text("Navigation link with url string")
}

Button {
    router.navigateTo(.about)
} label: {
    Text("Push with button event")
}
Button {
    router.navigateTo(.parameter(username: "Johnny"))
} label: {
    Text("Push with parameter")
}
Button {
    router.presentFullScreen(.login)
} label: {
    Text("Full screen cover")
}

Button {
    router.presentSheet(.login)
} label: {
    Text("Sheet")
}
```

## Authors
* **Mellong Lau**  [Blog](https://blog.xioayee.top/)

Check out the app which is using this router solution: [Accent Lane](https://apps.apple.com/us/app/accent-lane/id6480443984)

## Love our work?
Hit the star 🌟 button! It helps! ❤️

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/MellongLau/SwiftUIPathRouter/blob/main/LICENSE) file for details
