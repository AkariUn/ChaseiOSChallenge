//
//  SchoolTableViewCell.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation
import UIKit

class SchoolTableViewCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradesLabel: UILabel!
    @IBOutlet weak var studentsLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    var school:SchoolModel? {
        didSet {
            guard let school else {
                return
            }
            nameLabel.text = school.name
            gradesLabel.text = school.grades
            studentsLabel.text = school.totalStudents
            cityLabel.text = school.city
            stateLabel.text = school.state
            phoneLabel.text = school.phoneNumber
        }
    }
}
