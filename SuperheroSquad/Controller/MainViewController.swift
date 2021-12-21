//
//  ViewController.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 03/12/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var squad: [SquadMemberProtocol] = []
    var characters: [Character] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var numberCharactersDownloadedSoFar = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load squad from data store.
        loadSquad()
        
        // Load characters from Marvel API.
        loadCharacters()
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

