// CocktailRecipeTableViewCell.swift
// Cocktails
//
// Created by Hernán Rodríguez on 27/1/24.

import UIKit

class CocktailRecipeTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeIngredientesLabel: UILabel!
    @IBOutlet weak var recipeGlassLabel: UILabel!
    @IBOutlet weak var recipeAlcoholLabel: UILabel!
    @IBOutlet weak var recipeInstructionsLabel: UILabel!

    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: - Public Method
    func setRecipe(with cocktail: Cocktail) {
        recipeTitleLabel.text = cocktail.strDrink
        // Configurar la etiqueta de ingredientes con atributos
            recipeIngredientesLabel.attributedText = cocktail.getIngredientsString()

            // Configurar la etiqueta de instrucciones con atributos
            recipeInstructionsLabel.attributedText = cocktail.getInstructionsString()
        recipeAlcoholLabel.text = cocktail.strAlcoholic
        recipeGlassLabel.text = cocktail.strGlass

        loadImage(from: cocktail.strDrinkThumb)
    }

    // MARK: - Private Methods
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString,
              let imageUrl = URL(string: urlString) else {
            recipeImageView.image = UIImage(named: Constants.placeholderImage)
            return
        }

        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error al descargar la imagen: \(error)")
                DispatchQueue.main.async {
                    self.recipeImageView.image = UIImage(named: Constants.placeholderImage)
                }
                return
            }

            if let imageData = data, let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.recipeImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.recipeImageView.image = UIImage(named: Constants.placeholderImage)
                }
            }
        }.resume()
    }
}

// MARK: - Constants
private struct Constants {
    static let placeholderImage = "noPhoto"
}
