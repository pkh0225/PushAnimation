# ⛳️ Custom Navigation Animatior
> Custom Push and Pop animation

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



## 🚦 Protocol - NavigationAnimatorAble

```
protocol NavigationAnimatorAble {
    var pushAnimation: PushAnimator? { get }
    var popAnimation: PopAnimator? { get }
}
```


