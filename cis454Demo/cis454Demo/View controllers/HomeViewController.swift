//
//  ViewController.swift
//  Main Menu
//
//  Created by Yian Yu on 2/6/20.
//  Copyright © 2020 Yian Yu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  let transition = SlideAndTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    


  
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
       guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
        else
       {return}
    menuViewController.modalPresentationStyle = .overCurrentContext
    menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }

}
extension HomeViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    }

