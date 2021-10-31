//
//  ProfilePupilsCells.swift
//  HW12-NavigationListPupils
//
//  Created by lion on 29.10.21.
//


final class ModelPupilsData {
    let pupilNameString: String
    let pupilScoreInt: Int
    let pupilClassString: String
    
    init(pupilNameString: String, pupilClassString: String) {
        self.pupilNameString = pupilNameString
        self.pupilClassString = pupilClassString
        self.pupilScoreInt = Int.random(in: 0...100)
    }
}

import UIKit

final class ProfilePupilsCells: UITableViewCell {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var pupilsNameLabel: UILabel!
    @IBOutlet weak var scorePupilsLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .black
        profileView.layer.cornerRadius = 30
    }
    
    static let identifier = "ProfilePupilsCells"

    func makeProfileCellBy(model: ModelPupilsData) {
        pupilsNameLabel.text = "Name: \(model.pupilNameString)"
        scorePupilsLabel.text = "Score: \(model.pupilScoreInt)"
    }
}
