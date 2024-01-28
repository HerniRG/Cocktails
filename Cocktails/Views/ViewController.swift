//  ViewController.swift
//  Cocktails
//
//  Created by Hernán Rodríguez on 27/1/24.

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cocktailsTableView: UITableView!
    
    // MARK: - Properties
    var cocktailList: [Cocktail] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Actions
    @IBAction func searchButtonAction(_ sender: Any) {
        searchRecipe()
    }

    // MARK: - Private Methods
    private func configureTableView() {
        cocktailsTableView.delegate = self
        cocktailsTableView.dataSource = self
    }

    private func searchRecipe() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Please enter a cocktail name.")
            return
        }
        
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(name)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                print("Error performing the request: \(error)")
                self.showAlert(message: "Error performing the search. Please try again.")
                return
            }
            
            guard let data = data else {
                print("No response received from the API.")
                self.showAlert(message: "No response received from the API server. Please try again.")
                return
            }
            
            do {
                let cocktailResponse = try JSONDecoder().decode(CocktailResponse.self, from: data)
                
                if cocktailResponse.drinks.isEmpty {
                    self.showAlert(message: "No results found for '(name)'. Please try another name.")
                }
                
                self.cocktailList = cocktailResponse.drinks
                
                DispatchQueue.main.async {
                    self.cocktailsTableView.reloadData()
                }
            } catch {
                print("Error decoding the API response: \(error)")
                self.showAlert(message: "No results found for '(name)'. Please try another name.")
            }
        }.resume()
    }

    private func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - TableView Delegate and DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCellId", for: indexPath) as! CocktailRecipeTableViewCell
        let cocktail = cocktailList[indexPath.row]
        cell.setRecipe(with: cocktail)
        return cell
    }
}
