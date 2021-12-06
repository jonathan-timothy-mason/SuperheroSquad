//
//  MainViewControllerTableViewExtension.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 04/12/2021.
//

import Foundation
import UIKit

/// TableView implementation for MainViewController as extension.
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return squad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "SquadMemberCell") as! SquadMemberCell
        
        // Get corresponding squad member.
        let squadMember = squad[(indexPath as NSIndexPath).row]
        
        // Set text and image of cell.
        cell.name.text = squadMember.name
        if let photo = squadMember.photo {
            cell.photo.image = UIImage(data: photo)
        }
        else {
            cell.photo.image = UIImage(systemName: Character.defaultSystemImageName)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show review screen and allow option to fire character from squad.
        let reviewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController

        // Pass required parameters.
        let squadMember = squad[indexPath.row]
        let character = Character(squadMember) // Convert from SquadMember to Character for Review screen.
        reviewViewController.character = character
        reviewViewController.question = "Fire?"
        reviewViewController.yesCompletionHandler = {
            DataController.shared.fireFromToSquad(squadMember: squadMember)
            self.loadSquad()
        }
        
        // Show screen.
        self.present(reviewViewController, animated: true)
    }
}
