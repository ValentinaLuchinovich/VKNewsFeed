//
//  AuthViewController.swift
//  VK News
//
//  Created by Валентина Лучинович on 22.03.2022.
//

import UIKit

class AuthViewController: UIViewController {

    private var authServise: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//      authServise = AuthService()
        authServise = SceneDelegate.shared().authService
    }
    
    @IBAction func signInTouch() {
        authServise.wakeUpSession()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
