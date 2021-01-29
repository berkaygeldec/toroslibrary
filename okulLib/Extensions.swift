
// Buradaki kodlar eklenti kodları . Buton ,  textfield  , label tarzı şeyler için özelliklerini değiştiriyor

import Foundation
import UIKit
@IBDesignable
class DesignableView: UIView {
}
@IBDesignable
class DesignableButton: UIButton {
}
@IBDesignable
class DesignableLabel: UILabel {
}
extension UIView {
 @IBInspectable
 var cornerRadius: CGFloat {
  get {
   return layer.cornerRadius
  }
  set {
   layer.cornerRadius = newValue
  }
 }
 @IBInspectable
 var borderWidth: CGFloat {
  get {
   return layer.borderWidth
  }
  set {
   layer.borderWidth = newValue
  }
 }
 @IBInspectable
 var borderColor: UIColor? {
  get {
   if let color = layer.borderColor {
    return UIColor(cgColor: color)
   }
   return nil
  }
  set {
   if let color = newValue {
    layer.borderColor = color.cgColor
   } else {
    layer.borderColor = nil
   }
  }
 }
  
 @IBInspectable
 var shadowRadius: CGFloat {
  get {
   return layer.shadowRadius
  }
  set {
   layer.shadowRadius = newValue
  }
 }
 @IBInspectable
 var shadowOpacity: Float {
  get {
   return layer.shadowOpacity
  }
  set {
   layer.shadowOpacity = newValue
  }
 }
 @IBInspectable
 var shadowOffset: CGSize {
  get {
   return layer.shadowOffset
  }
  set {
   layer.shadowOffset = newValue
  }
 }
 @IBInspectable
 var shadowColor: UIColor? {
  get {
   if let color = layer.shadowColor {
    return UIColor(cgColor: color)
   }
   return nil
  }
  set {
   if let color = newValue {
    layer.shadowColor = color.cgColor
   } else {
    layer.shadowColor = nil
   }
  }
 }
}
extension UIView {
  func addTapGesture(action : @escaping ()->Void ){
    let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
    tap.action = action
    tap.numberOfTapsRequired = 1
    self.addGestureRecognizer(tap)
    self.isUserInteractionEnabled = true
     
  }
  @objc func handleTap(_ sender: MyTapGestureRecognizer) {
    sender.action!()
  }
}
class MyTapGestureRecognizer: UITapGestureRecognizer {
  var action : (()->Void)? = nil
}
extension UIView{
  func setElevation(elevation:Int,shadowOpacity:Float!,color:UIColor!) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOffset = CGSize(width: 0, height: elevation)
    layer.shadowOpacity = shadowOpacity
    layer.shadowRadius = CGFloat(elevation)
  }
   
}

