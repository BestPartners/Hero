// The MIT License (MIT)
//
// Copyright (c) 2016 Luke Zhao <me@lkzhao.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

extension HeroTransition: UINavigationControllerDelegate {
  public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    if let previousNavigationDelegate = navigationController.previousNavigationDelegate {
      previousNavigationDelegate.navigationController?(navigationController, willShow: viewController, animated: animated)
    }
  }

  public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    if let previousNavigationDelegate = navigationController.previousNavigationDelegate {
      previousNavigationDelegate.navigationController?(navigationController, didShow: viewController, animated: animated)
    }
  }

  public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard !isTransitioning else { return nil }
    self.state = .notified
    self.isPresenting = operation == .push
    self.fromViewController = fromViewController ?? fromVC
    self.toViewController = toViewController ?? toVC
    self.inNavigationController = true
    return self
  }

  public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    // BestPartners: Modify By BestPartners. IM 界面退出不能用Hero，有键盘无法消失的问题，IM那边通过基类实现HeroTransitionNavigationIgnoreable协议来控制逻辑
    guard let _fvc = fromViewController, _fvc is HeroTransitionNavigationIgnoreable else { return interactiveTransitioning }
    return nil
    }
}


// BestPartners: Modify By BestPartners，这里声明一个协议，用于标记上述方法忽略Hero部分逻辑
public protocol HeroTransitionNavigationIgnoreable {}
