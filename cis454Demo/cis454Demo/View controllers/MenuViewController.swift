//
//  MenuViewController.swift
//  cis454Demo
//
//  Created by Yumi on 2/22/20.
//  Copyright © 2020 Yumi. All rights reserved.
//


import UIKit
enum MenuType: Int {
    case NewApplication
    case Schedule
    case Setting
}

class MenuViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath){
        guard  let menuType = MenuType(rawValue: indexPath.row) else {return}
        dismiss(animated:true){
        print("Dismissing:\(menuType)")
    }
    }
    }
