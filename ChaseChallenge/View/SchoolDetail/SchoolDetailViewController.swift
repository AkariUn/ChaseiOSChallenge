//
//  SchoolDetailViewController.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation
import UIKit

class SchoolDetailViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gradesLabel: UILabel!
    @IBOutlet weak var studentsLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var testTakersLabel: UILabel!
    @IBOutlet weak var readScoresLabel: UILabel!
    @IBOutlet weak var mathScoresLabel: UILabel!
    @IBOutlet weak var writingScoresLabel: UILabel!

    
    var viewModel:SatViewModel? {
        didSet {
            viewModel?.setCallback {
                DispatchQueue.main.async {  [weak self] in
                    self?.updateUI()
                }
            }
            viewModel?.loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI() {
        guard let viewModel else {
            return
        }
        
        nameLabel.text = viewModel.school.name
        descriptionLabel.text = viewModel.school.overview
        gradesLabel.text = viewModel.school.grades
        studentsLabel.text = viewModel.school.totalStudents
        cityLabel.text = viewModel.school.city
        stateLabel.text = viewModel.school.state
        phoneLabel.text = viewModel.school.phoneNumber
        
        guard let scores = viewModel.satScore else {
            self.stackView.isHidden = false
            return
        }
        
        testTakersLabel.text = scores.testTakers
        readScoresLabel.text = scores.readScores
        mathScoresLabel.text = scores.mathScores
        writingScoresLabel.text = scores.writingScores

        self.stackView.isHidden = false
    }
}
