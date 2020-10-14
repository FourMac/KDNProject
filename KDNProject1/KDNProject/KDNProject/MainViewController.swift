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
    
    private let selfIntrodutionController = SelfIntrodutionViewController()
    private let portfolioController = PortfolioViewController()
    private let questionController = QuestionViewController()
    
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
        addChild(self.selfIntrodutionController)
        addChild(self.portfolioController)
        addChild(self.questionController)
        
        view.addSubview(selfIntrodutionController.view)
        view.addSubview(portfolioController.view)
        view.addSubview(questionController.view)
        
        selfIntrodutionController.view.frame = view.bounds
        portfolioController.view.frame = view.bounds
        questionController.view.frame = view.bounds
        
        selfIntrodutionController.didMove(toParent: self)
        portfolioController.didMove(toParent: self)
        questionController.didMove(toParent: self)
        
        selfIntrodutionController.view.isHidden = true
        portfolioController.view.isHidden = true
        questionController.view.isHidden = true
    }
    
    
    @IBAction func didTapMenuButton() {
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
            
            title = named.rawValue

            switch named {
            case .home:
                selfIntrodutionController.view.isHidden = true
                portfolioController.view.isHidden = true
                questionController.view.isHidden = true
            case .selfIntrodution:
                selfIntrodutionController.view.isHidden = false
                portfolioController.view.isHidden = true
                questionController.view.isHidden = true
            case .portfolio:
                selfIntrodutionController.view.isHidden = true
                portfolioController.view.isHidden = false
                questionController.view.isHidden = true
            case .question:
                selfIntrodutionController.view.isHidden = true
                portfolioController.view.isHidden = true
                questionController.view.isHidden = false
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

