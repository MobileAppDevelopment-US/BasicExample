//
//  Utils.swift
//  BasicExample
//
//  Created by Serik on 28.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

class Utill: NSObject {

    // MARK: - Validation
    
    class func isValidEmail(_ emailStr: String) -> Bool {
        
        let emailRegEx1 = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred1 = NSPredicate(format:"SELF MATCHES %@", emailRegEx1)
        
        let emailRegEx2 = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+\\.[A-Za-z]{2,64}"
        let emailPred2 = NSPredicate(format:"SELF MATCHES %@", emailRegEx2)
        
        let validDomain1 = emailPred1.evaluate(with: emailStr)
        let validDomain2 = emailPred2.evaluate(with: emailStr)
        
        if validDomain1 || validDomain2 {
            return true
        } else {
            return false
        }
    }
    
    class func isValidPassword(_ passwordStr: String) -> Bool {
        
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z]).{8,64}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: passwordStr)
    }
    
    class func isValidFullName(_ fullNameStr: String) -> Bool {
        
        let fullNameRegEx = "^(?=.*[a-z]).{1,20}$"
        let fullNamePred = NSPredicate(format:"SELF MATCHES %@", fullNameRegEx)
        return fullNamePred.evaluate(with: fullNameStr)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    class func getCountString(_ count: Int) -> String {
        if  count > 1000000{
            return  "\(count / 1000)" + "M"}
        if  count > 10000{
            return "\(count / 1000)" + "k"}
        return "\(count)"
    }
    
    class func showErrorAlert(_ message: String?, vc: UIViewController) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        //DispatchQueue.main.async(execute: {
            vc.present(alert, animated: true)
       // })
    }
    
    class func showErrorAlertAndVC(_ message: String?, vc: UIViewController, success: VoidCompletion?) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default) { (_) in success?() })
        DispatchQueue.main.async(execute: {
            vc.present(alert, animated: true)
        })
    }
    
    class func showBlockUserActionSheet(vc: UIViewController, success: VoidCompletion?, reportSuccess: VoidCompletion?) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Report", style: .destructive) { action in
            reportSuccess?()
        })
        
        alert.addAction(UIAlertAction(title: "Block User", style: .destructive) { action in
            success?()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        DispatchQueue.main.async(execute: {
            vc.present(alert, animated: true)
        })
    }
            
    class func getAgeFromDateOfBirth(date: String?) -> String {
        
        guard let date = date else { return "" }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        let dateOfBirth = dateFormater.date(from: date)
        
        let calender = Calendar.current
        
        let dateComponent = calender.dateComponents([.year, .month, .day], from:
            dateOfBirth!, to: Date())
        
        return String(dateComponent.year!)
    }
    
    class func convertURL(_ textUrl: String) -> String {
        let urlAvatar = textUrl.replacingOccurrences(of: "\"",
                                                     with: "",
                                                     options: .literal,
                                                     range: nil)
        return urlAvatar
    }
    
    class func getPlaceholder() -> UIImage {
        return UIImage(named: "placeholder")!
    }
    
    
    class func printToConsole(_ printData : Any) {
        #if DEBUG
        print("\(printData)")
        #endif
    }
    
}


