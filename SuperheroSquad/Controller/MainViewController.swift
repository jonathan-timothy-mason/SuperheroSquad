//
//  ViewController.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 03/12/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var squad: [SquadMember] = []
    var characters: [Character] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // From "Code for Collection View Flow Layout" of "Lesson 8: Complete
        // the MemeMe App".
        // Size cells according to screen size.
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        // Create temp squad.
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
        
        // Create temp characters.
        for _ in 1...25 {
            characters.append(Character(name: "Dad", bio: "What a guy!", photoURL: nil, photo: UIImage(named: "test")))
        }
        for _ in 1...25 {
            characters.append(Character(name: "Mum", bio: "Soooo nice.", photoURL: nil, photo: nil))
        }
    }
}

