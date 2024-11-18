# ⛳️ Custom Navigation Animatior
> Custom Push and Pop animation

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

<img src="https://github.com/user-attachments/assets/d9620ce9-334b-48d0-a7be-7cbd426f57da" width="333" alt="sample">

- Support all directions :)
- left, right, up, down, snapshot 

![blogimg](https://github.com/pkh0225/PushAnimation/blob/master/Artboard.png)
![blogimg](https://github.com/pkh0225/PushAnimation/blob/master/Artboard2.png)



## 🎨 NavigationAnimationType

```
public enum NavigationAnimationType: Int {
    case none = 0
    case left
    case right
    case up
    case down
    case snapShot
}

```



## 🚦 Protocol - NavigationAnimatorAble

```
protocol NavigationAnimatorAble {
    var pushAnimation: PushAnimator? { get }
    var popAnimation: PopAnimator? { get }
}
```



## 🔍 How to use

1. Confirm to `NavigationAnimatorAble` protocol
2. Implement push & pop animator like below


```
extension RightViewController: NavigationAnimatorAble {
    var pushAnimation: PushAnimator? {
        return PushAnimator(animationType:.right)
    }
    var popAnimation: PopAnimator? {
        return self.popAnimator
    }
}
```

## 📸 Snapshot view

```
extension SnapShotViewController: NavigationAnimatorAble {
    var pushAnimation: PushAnimator? {
        return PushAnimator(animationType: .snapShot)
    }
    var popAnimation: PopAnimator? {
        return PopAnimator(animationType: .none)
    }
}
```

##### You can also create shadow below snapshow view

```
let snapShotView = SnapShotView(view: fromViewController.view, shadows: .right)
```

```
struct ShadowDirection: OptionSet {
    let rawValue: Int
    static let left = ShadowDirection(rawValue: 1 << 0)
    static let right = ShadowDirection(rawValue: 1 << 1)
    static let up = ShadowDirection(rawValue: 1 << 2)
    static let down = ShadowDirection(rawValue: 1 << 3)
    static let none = ShadowDirection(rawValue: 1 << 4)
    static let all: ShadowDirection = [.left, .right, .up, .down]
}
```
