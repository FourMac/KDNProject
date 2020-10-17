//
//  MainViewController.swift
//  KDNProject
//
//  Created by 조주혁 on 2020/10/06.
//

import UIKit
import Firebase
import SideMenu





class MainViewController: UIViewController, SideMenuTableViewControllerDelegate {

    private var sideMenu: SideMenuNavigationController?
    
    private let settingsController = SettingsViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menu = SideMenuTableViewController(with: SideMenuItem.allCases)
        
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildControllers()
    }

    
    private func addChildControllers(){
        addChild(self.settingsController)
        
        view.addSubview(settingsController.view)
        
        settingsController.view.frame = view.bounds
        
        settingsController.didMove(toParent: self)
        
        settingsController.view.isHidden = true
    }
    
    
    @IBAction func didTapMenuButton() {
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
            
            title = named.rawValue

            switch named {
            case .home:
                settingsController.view.isHidden = true
            case .settings:
                settingsController.view.isHidden = false
            }
            
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

