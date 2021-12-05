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
    
    var numberCharactersDownloadedSoFar = 0

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
        
        createTestSquad()
        
        // Load squad from data store.
        //loadSquad()
        
        // Load characters from Marvel API.
        loadCharacters()
    }
    
    /// Create temp squad.
    func createTestSquad() {
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
        //squad.append(temp4)
        //squad.append(temp5)
    }
    
    /// Load squad from data store.
    func loadSquad() {
        squad = DataController.shared.loadSquad()
        tableView.reloadData()
    }
    
    /// Load characters from Marvel API, page by page.
    func loadCharacters() {
        MarvelClient.getCharacters(numberDownloaded: numberCharactersDownloadedSoFar, completion: handleResponseToLoadCharacters)
    }
    
    
    /// Create placeholder characters after first response and total number
    /// of characters is known.
    /// - Parameter totalNumberCharacters: Total number of characters.
    func createPlaceholders(_ totalNumberCharacters: Int) {
        if self.numberCharactersDownloadedSoFar <= 0 && totalNumberCharacters > 0 {
            self.characters = Array(repeating: Character(), count: totalNumberCharacters)
        }
    }
    
    /// Handle response to load characters.
    /// - Parameters:
    ///   - newCharacters: New downloaded characters.
    ///   - totalNumberCharacters: Total number of characters.
    ///   - error: Error, if there was a problem.
    func handleResponseToLoadCharacters(newCharacters: [Character], totalNumberCharacters: Int, error: Error?) {
        guard error == nil else {
            ControllerHelpers.showMessage(parent: self, caption: "Marvel API Error", introMessage: "There was a problem downloading characters using the Marvel API.", error: error)
            return
        }
        
        // Create placeholder characters after first response and total number
        // of characters is known.
        createPlaceholders(totalNumberCharacters)
        
        // Update placeholders with newly loaded characters.
        if newCharacters.count > 0 {
            let indexesToUpdate = numberCharactersDownloadedSoFar...numberCharactersDownloadedSoFar + newCharacters.count - 1 // Get indexes of characters to update.
            
            // Increment number of downloaded characters.
            self.numberCharactersDownloadedSoFar += newCharacters.count
            
            // Update characters.
            self.characters.replaceSubrange(indexesToUpdate, with: newCharacters)
            
            // Update collection.
            let indexPathsToUpdate = indexesToUpdate.map { IndexPath(indexes:[0, $0]) } // Convert to IndexPaths.
            self.collectionView.reloadItems(at: indexPathsToUpdate)
            
            // Attempt to load next page.
            self.loadCharacters()
        }
    }
}

