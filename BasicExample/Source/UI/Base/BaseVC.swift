//
//  BaseVC.swift
//  BasicExample
//
//  Created by Serik on 28.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit
import JGProgressHUD

class BaseVC: UIViewController {
    
    //let networkClient = NetworkClient.sharedInstance
    var isActiveNextButton: Bool = false
        
    private var hud: JGProgressHUD?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackArrowButton(nameImage: "arrowBack")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Design.blue]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideSpinner()
    }
    
    // MARK: - Methods

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showSpinner() {
        hideSpinner()
        hud = JGProgressHUD(style: .dark)
        hud?.show(in: self.view)
    }
    
    func hideSpinner() {
        hud?.dismiss(afterDelay: 0.1)
        hud = nil
    }
    
}
    
// MARK: - BackArrowButton

extension BaseVC {
        
    func setBackArrowButton(nameImage: String) {
        self.navigationController?.navigationBar.barTintColor = Design.white
        self.navigationController?.navigationBar.tintColor = Design.blue

        
        let buttonItem = UIBarButtonItem(image: UIImage.init(named: nameImage),
                                         style: .plain,
                                         target: self,
                                         action: #selector(leftButtonAction(_:)))
        self.navigationItem.leftBarButtonItem = buttonItem
        
        
        self.navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    @objc func leftButtonAction(_ button: UIBarButtonItem) {
         self.navigationController?.popViewController(animated: true)
     }
    
    func setHiddenBlackArrowButton() {
        navigationController?.navigationBar.tintColor = .clear
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.hidesBackButton = true
    }
}
        
// MARK: - GradientButton

extension BaseVC {
    
    func setGradientButton(_ button: UIButton) {
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: Design.avenirBold, size: Design.standart)
        setGradientToView(button)
    }
    
    func setGradientToView(_ view: UIView) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Design.leftGradient,
                                Design.centerGradient,
                                Design.rightGradient]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func removeGradientToView(_ view: UIView) {
        view.layer.sublayers?.remove(at: 0)
    }
    
    // MARK: - Next Button
    
    func notSelectedNextButton(_ nextButton: UIButton) {
        
        isActiveNextButton = false
        nextButton.layer.cornerRadius = nextButton.frame.size.height / 2
        nextButton.layer.masksToBounds = true
        nextButton.backgroundColor = Design.gray
        nextButton.tintColor = Design.grayText
        nextButton.titleLabel?.font = UIFont(name: Design.avenirBold, size: Design.medium)
        nextButton.isEnabled = false
        nextButton.titleLabel?.adjustsFontSizeToFitWidth = true
        nextButton.titleLabel?.minimumScaleFactor = 0.5
    }
    
    func selectedNextButton(_ nextButton: UIButton) {
        
        isActiveNextButton = true
        nextButton.tintColor = Design.white
        setGradientToView(nextButton)
        nextButton.isEnabled = true
    }
    
    func setBorderButton(_ button: UIButton) {
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.borderWidth = 2
        button.layer.borderColor = Design.grayText.cgColor
        button.layer.masksToBounds = true
        button.tintColor = Design.grayText
        button.titleLabel?.font = UIFont(name: Design.avenirBold, size: Design.medium)
    }
    
    // MARK: - UITextField
    
    func setTextField(_ textField: UITextField) {
        textField.font = UIFont(name: Design.avenirBold, size: Design.standart1)
        textField.textColor = Design.black
    }
    
}

// MARK: - Transition VC
extension BaseVC {
    
    func pushViewController(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - NavigationBar

extension BaseVC {
        
    func setNavigationBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - CheckConnectedToInternet

extension BaseVC {
    
    func checkConnectedToInternet() {
        
        if NetworkClient.sharedInstance.isConnectedToInternet == false {
            showConnectedToInternetAlert()
        }
    }
    
    private func showConnectedToInternetAlert() {
        
        let controller = UIAlertController(title: "No Internet Detected",
                                           message: "This app requires an Internet connection",
                                           preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: nil)
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel,
                                   handler: nil)
        
        controller.addAction(ok)
        controller.addAction(cancel)
        
        present(controller, animated: true, completion: nil)
    }
    
}

//Вызов алерта запроса камеры или галереии ( в Info.plist дать разрешение)

// MARK: - UIImagePickerControllerDelegate

extension BaseVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @objc func showAlert() {
        
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera",
                                      style: .default,
                                      handler: {(action: UIAlertAction) in
                                        self.getImage(sourceType: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Album",
                                      style: .default,
                                      handler:
            {(action: UIAlertAction) in
                self.getImage(sourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func getImage(sourceType: UIImagePickerController.SourceType) {

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = sourceType
            self.present(myPickerController, animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let orientationFixedImage = chosenImage.fixOrientation() // fixOrientation
        let imageView = UIImageView()
        imageView.image = orientationFixedImage
        //let resizedImage = orientationFixedImage?.resized(toWidth: 300) // resizeToWidth
        //let data = resizedImage?.jpegData(compressionQuality: 1)
        dismiss(animated:true, completion: nil)
    }
    
}



// MARK: - ALERT

extension BaseVC {
    
    func showAlert(_ text: String) {
        let alert = UIAlertController(title: nil,
                                      message:text,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",//singleton.getString("OK"),
            style: .default,
            handler: {
                action in
        }))
        self.present(alert, animated: true)
    }
    
    func showAlert(_ title: String, _ text: String) {
        let alert = UIAlertController(title: title,
                                      message:text,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",//singleton.getString("OK"),
            style: .default,
            handler: {
                action in
        }))
        self.present(alert, animated: true)
    }
    
    func showAlertErrorMessage(_ text: String) {
        let alert = UIAlertController(title: nil ,
                                      message:text,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",//singleton.getString("OK"),
            style: .default,
            handler: {
                action in
        }))
        self.present(alert, animated: true)
    }
    
    
    func showError(message: String){
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }

}
