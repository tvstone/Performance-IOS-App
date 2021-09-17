//
//  LoginViewController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 12.06.2021.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var scrollViewFirstScreen: UIScrollView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtom: UIScrollView!
    @IBOutlet weak var viewFirstScreen: UIView!
    @IBOutlet weak var circleOne: UIImageView!
    @IBOutlet weak var circleTwo: UIImageView!
    @IBOutlet weak var circleThree: UIImageView!
    @IBOutlet weak var myButtom: UIButton!

    let fromLoginToTabBarSegueIdentificator = "fromLoginToTabBar"
    let myFriendsArray = ["Петров", "Сидоров", "Ковалев","Иванов","Понкратов","Степанов","Ларин"]
    let reuseIdentifierMyFriends = "reuseIdentifierMyFriends"
    let firstColor  = #colorLiteral(red: 0, green: 0.5515417457, blue: 1, alpha: 1).cgColor
    let finishColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
    let gradientLayer = CAGradientLayer()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circleOne.alpha = 0
        circleTwo.alpha = 0
        circleThree.alpha = 0
        loginLabel.alpha = 0
        passwordLabel.alpha = 0
        myButtom.alpha = 0
    }
    
    func animateTextField() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        loginTextField.layer.add(animation, forKey: nil)
        passwordTextField.layer.add(animation, forKey: nil)
    }

    func animateButton() {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 6
        animation.beginTime = CACurrentMediaTime() + 3
        animation.fillMode = CAMediaTimingFillMode.backwards
        myButtom.layer.add(animation, forKey: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        UIView.animateKeyframes(withDuration: 1,
                                delay: 0,
                                options: [.autoreverse],
                                animations: {
                                    self.circleOne.alpha = 1
                    
                                },
                                completion: nil)
        UIView.animateKeyframes(withDuration: 1,
                                delay:0.5,
                                options: [.autoreverse],
                                animations: {
                                    self.circleTwo.alpha = 1
                     
                                },
                                completion: nil)
        UIView.animateKeyframes(withDuration: 1,
                                delay: 1,
                                options: [.autoreverse],
                                animations: {
                                    self.circleThree.alpha = 1
               
                                },
                                completion: { [self]_ in

                                    circleOne.alpha = 0
                                    circleTwo.alpha = 0
                                    circleThree.alpha = 0
                                    loginLabel.alpha = 1
                                    passwordLabel.alpha = 1
                                    myButtom.alpha = 1
                               
                                } )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        loginTextField.layer.cornerRadius = 20
        gradientLayer.colors = [firstColor,finishColor]
        gradientLayer.locations = [0.2 , 1]
        gradientLayer.frame = viewFirstScreen.frame
        viewFirstScreen.layer.insertSublayer(gradientLayer, at: 0)
        myButtom.layer.cornerRadius = 7
        

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOnFirstScreen), name:UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideOnFirstScreen), name: UIResponder.keyboardWillHideNotification, object: nil)
      
    let gesterRecognizerFirstScreen = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHideOnTap))
    scrollViewFirstScreen.addGestureRecognizer(gesterRecognizerFirstScreen)
     
        animateTextField()
        animateButton()

    }

 
    @objc func keyboardWillShowOnFirstScreen(){
        scrollViewFirstScreen.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
    }
    
    @objc func keyboardWillHideOnFirstScreen(){
        scrollViewFirstScreen.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
 
    @objc func keyboardWillHideOnTap(){
        self.scrollViewFirstScreen.endEditing(true)
        
}
    
    func showAlertLoginAndPassword (message : String, completion : @escaping (UIAlertAction) -> Void){
        let alertShow = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
        let alertActionButtom = UIAlertAction(title: "Ok", style: .destructive, handler: completion)
        alertShow.addAction(alertActionButtom)
        present(alertShow, animated: true, completion: nil)
        
    }

    @IBAction func loginButtom(_ sender: Any) {
       
        guard let myLogin = loginTextField.text,
              let myPassword = passwordTextField.text
      //        !myLogin.isEmpty,
     //         !myPassword.isEmpty
     //         myLogin == "",
     //         myPassword == ""
       
        else {
            
            showAlertLoginAndPassword(message: "Не верный логин или пароль.") { _ in
                self.passwordTextField.text = ""
                self.loginTextField.text = ""
                      }
            return
        }
        
        performSegue(withIdentifier: fromLoginToTabBarSegueIdentificator, sender: nil)
                    
    }
    
}

extension LoginViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myFriendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierMyFriends, for: indexPath)
   
        cell.textLabel?.text = myFriendsArray[indexPath.row]
     
        return cell
    
    }
    
    
}
