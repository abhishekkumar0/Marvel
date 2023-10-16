//
//  AlphaView.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//
import UIKit
final class AlphaView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.alpha = 0.0
    }
    
    public func showView(alpha: CGFloat? = 0.6){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = alpha ?? 0.6
        } completion: {_ in }
    }
    
    public func hideView(success: ((_ success: Bool) -> Void)? = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = 0.0
        } completion: {_ in
            success?(true)
        }
    }
    
}
