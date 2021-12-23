//
//  ViewController.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 03/12/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    enum Pages: Int {
        case A = 0
        case B = 1
        case C = 2
        case D = 3
        case E = 4
        case F = 5
        case G = 6
        case H = 7
        case I = 8
        case J = 9
        case K = 10
        case L = 11
        case M = 12
        case N = 13
        case O = 14
        case P = 15
        case Q = 16
        case R = 17
        case S = 18
        case T = 19
        case U = 20
        case V = 21
        case W = 22
        case X = 23
        case Y = 24
        case Z = 25
    }
    
    var squad: [SquadMemberProtocol] = []
    
    var characters: [Pages: [Character]] = [Pages.A:[], Pages.B:[], Pages.C:[], Pages.D:[], Pages.E:[], Pages.F:[], Pages.G:[], Pages.H:[], Pages.I:[], Pages.J:[], Pages.K:[], Pages.L:[], Pages.M:[], Pages.N:[], Pages.O:[], Pages.P:[], Pages.Q:[], Pages.R:[], Pages.S:[], Pages.T:[], Pages.U:[], Pages.V:[], Pages.W:[], Pages.X:[], Pages.Y:[], Pages.Z:[]]
    var currentPage = Pages.A

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var pager: UIPageControl!
       
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load squad from data store.
        loadSquad()
        
        // Load characters from Marvel API.
        loadCharactersForCurrentPage()
    }

    /// Load squad from data store.
    func loadSquad() {
        squad = DataController.shared.loadSquad()
        tableView.reloadData()
    }
    
    /// Load characters from Marvel API for current page.
    /// - Note: Getting enum name from answer to "How to get the name of enumeration value in Swift?" by Stuart:
    /// https://stackoverflow.com/questions/24113126/how-to-get-the-name-of-enumeration-value-in-swift
    func loadCharactersForCurrentPage() {
        MarvelClient.getCharacters(letter: "\(currentPage)", numberDownloaded: 0, completion: handleResponseToLoadCharacters)
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
                
        // Update placeholders with newly loaded characters.
        characters[currentPage] = newCharacters
        self.collectionView.reloadData()
    }
}

