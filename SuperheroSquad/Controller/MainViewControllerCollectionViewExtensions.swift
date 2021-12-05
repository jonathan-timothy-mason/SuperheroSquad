//
//  MainViewControllerCollectionViewExtensions.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 04/12/2021.
//

import Foundation
import UIKit

/// CollectionView implementation for MainViewController as extension.
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // Retrieve cell.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCharacterCell", for: indexPath) as! NewCharacterCell

        // Get corresponding character.
        let character = characters[indexPath.row]
        if let photo = character.photo {
            // Image has been downloaded, so set it.
            cell.photo.image = photo
        }
        else {
            // Image has not been downloaded, so set default.
            cell.photo.image = UIImage(systemName: Character.defaultSystemImageName)
            
            // And download image.
            if let photoURL = character.photoURL {
                MarvelClient.getPhoto(photoURL: photoURL) { image, error in
                    if let image = image {
                        character.photo = image
                        cell.photo.image = image // Update image in cell.
                    }
                }
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}
