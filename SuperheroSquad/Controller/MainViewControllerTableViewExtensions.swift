//
//  MainViewControllerTableViewExtensions.swift
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
            cell.photo.image = UIImage(systemName: "questionmark.circle.fill") // Default
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle press of item to display details of selected birdcall.
        //let detailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        //detailsViewController.birdcall = birdcalls[(indexPath as NSIndexPath).row]
        //detailsViewController.hidesBottomBarWhenPushed = true // Prevent tabs showing in new screen.
        //navigationController!.pushViewController(detailsViewController, animated: true)
    }

}
