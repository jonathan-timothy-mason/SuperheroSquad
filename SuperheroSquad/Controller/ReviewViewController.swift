//
//  ReviewViewController.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 05/12/2021.
//

import Foundation
import UIKit

/// Screen to review character and ask question, i.e. Recruit?, Fire?
class ReviewViewController: UIViewController {
    var character: Character?
    var question: String?
    var yesCompletionHandler: (() -> Void)?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let character = self.character else {
            fatalError("No character supplied when displaying \(self).")
        }
        guard let question = self.question else {
            fatalError("No question supplied when displaying \(self).")
        }
        guard yesCompletionHandler != nil else {
            fatalError("No completion handler for YES supplied when displaying \(self).")
        }
        
        questionLabel.text = question
        bioLabel.text = character.bio.count > 0 ? character.bio : "Bio unavailable."
        nameLabel.text = character.name.count > 0 ? character.name : "Unknown"
    
        // Load main photo of character.
        loadMainPhoto()
    }
    
    /// Load main photo of character, if not already loaded.
    func loadMainPhoto() {
        if let photo = character!.bigPhoto {
            // Image has been downloaded, so set it.
            photoImageView.image = photo
        }
        else {
            // Image has not been downloaded, so set default.
            photoImageView.image = UIImage(systemName: Character.defaultSystemImageName)
            
            // And download image.
            if let photoURL = character!.bigPhotoURL {
                self.startIndicatingActivity()
                
                MarvelClient.getPhoto(photoURL: photoURL) { image, error in
                    self.stopIndicatingActivity()
                    
                    if let image = image {
                        self.character!.bigPhoto = image // Cache image in character.
                        self.photoImageView.image = image // Display on screen.
                    }
                }
            }
        }
    }
    
    /// Indicate activity while photo is being downloaded.
    func startIndicatingActivity() {
        activityIndicator.startAnimating()
        bioLabel.isHidden = true
        photoImageView.isHidden = true
    }
    
    /// Stop indicating activity.
    func stopIndicatingActivity() {
        activityIndicator.stopAnimating()
        bioLabel.isHidden = false
        photoImageView.isHidden = false
    }
    
    /// Handle press of Yes button to call completion handler and close.
    @IBAction func yesPressed() {
        yesCompletionHandler!()
        dismiss(animated: true, completion: nil)
    }
    
    /// Close screen.
    @IBAction func noPressed() {
        dismiss(animated: true, completion: nil)
    }
}
