//
//  ViewController.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 03/12/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var squad: [SquadMember] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create new birdcall.
        let temp1 = DataController.shared.createSquadMember()
        temp1.name = "Superman"
        temp1.photo = UIImage(named: "test")?.pngData()
        let temp2 = DataController.shared.createSquadMember()
        temp2.name = "Batman"
        temp2.photo = nil
        let temp3 = DataController.shared.createSquadMember()
        temp3.name = "Spiderman"
        temp3.photo = UIImage(named: "test")?.pngData()
        let temp4 = DataController.shared.createSquadMember()
        temp4.name = "Dad"
        temp4.photo = UIImage(named: "test")?.pngData()
        let temp5 = DataController.shared.createSquadMember()
        temp5.name = "The Incredible Hulk"
        temp5.photo = nil
        squad.append(temp1)
        squad.append(temp2)
        squad.append(temp3)
        squad.append(temp4)
        squad.append(temp5)
    }
}

