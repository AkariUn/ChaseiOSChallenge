//
//  ViewController.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:SchoolViewModel? {
        didSet {
            viewModel?.loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gets Core data context to be passed to provider
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Provider will "provide" the Data layer, that way View model can be agnostic of where the data comes from
        let provider = DataServiceProvider(context: context)
        
        // Assign the view model to our view controller
        viewModel = SchoolViewModel(withProvider: provider, completion: {
            DispatchQueue.main.async {  [weak self] in
                self?.tableView.reloadData()
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? SchoolDetailViewController,
        let provider = viewModel?.provider,
        let cell = sender as? SchoolTableViewCell,
        let school = cell.school else {
            return
        }
        let satViewModel = SatViewModel(withSchool: school, provider: provider)
        viewController.viewModel = satViewModel
            
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else {
            return 0
        }
        return viewModel.schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SchoolTableViewCell else {
            return UITableViewCell()
        }

        cell.school = viewModel.schools[indexPath.row]
        return cell
    }
    
}
