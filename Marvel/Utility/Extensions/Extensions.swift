//
//  Extensions.swift
//  Marvel
//
//  Created by Abhishek on 10/10/23.
//

import UIKit
extension UIViewController{

    func showAutoToast(message : String) {
        let toastView = UIView()
        toastView.alpha = 1.0
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds  =  true
        view.addSubview(toastView)
        toastView.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 120, left: view.leftAnchor, paddingLeft: 30, right: view.rightAnchor, paddingRight: 30, width: 0, height: 0)
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.fontWith(name: .Poppins, fontFace: .Regular, size: 15)
        toastView.addSubview(label)
        label.anchor(top: label.superview?.topAnchor, paddingTop: 8, bottom: label.superview?.bottomAnchor, paddingBottom: 8, left: label.superview?.leftAnchor, paddingLeft: 8, right: label.superview?.rightAnchor, paddingRight: 8, width: 0, height: 0)
        label.text = message
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                 toastView.alpha = 0.0
            }, completion: {(isCompleted) in
                toastView.removeFromSuperview()
            })
        }
    }
    
}


extension UICollectionViewCell {
    private static var _indexPath = [String:IndexPath]()
    var indexPath: IndexPath {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UICollectionViewCell._indexPath[tmpAddress] ?? IndexPath(row: 0, section: 0)
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UICollectionViewCell._indexPath[tmpAddress] = newValue
        }
    }
}



extension UIViewController{
    
    internal func safeAreaHeightBottomAndTop() -> (topSafeArea: CGFloat, bottomSafeArea: CGFloat){
        var topSafeAreaHeight: CGFloat = 0
        var bottomSafeAreaHeight: CGFloat = 0

          if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            topSafeAreaHeight = safeFrame.minY
            bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
              return (topSafeAreaHeight, bottomSafeAreaHeight)
          }
        return (0,0)
    }
    
}

extension UIImageView {
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = tintedImage
        self.tintColor = color
    }
}

extension UITextField{
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
