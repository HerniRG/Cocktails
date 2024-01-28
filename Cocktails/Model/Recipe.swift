// Recipe.swift
// Cocktails
//
// Created by Hernán Rodríguez on 27/1/24.

import Foundation
import UIKit

struct CocktailResponse: Codable {
    let drinks: [Cocktail]
}

struct Cocktail: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strInstructions: String?
    let strGlass: String?
    let strAlcoholic: String?

    // Método para obtener una cadena de ingredientes no nulos
    func getIngredientsString() -> NSAttributedString {
        let ingredientsList = [
            strIngredient1,
            strIngredient2,
            strIngredient3,
            strIngredient4,
            strIngredient5,
            strIngredient6,
            strIngredient7,
            strIngredient8,
            strIngredient9,
            strIngredient10,
            strIngredient11,
            strIngredient12,
            strIngredient13,
            strIngredient14,
            strIngredient15
        ].compactMap { $0 }

        let ingredientsString = "Ingredients:\n" + ingredientsList.joined(separator: ", ")

        let attributedString = NSMutableAttributedString(string: ingredientsString)
        attributedString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: 0, length: 12)) // 12 is the length of "Ingredients:"

        return attributedString
    }

    // Método para obtener las instrucciones
    func getInstructionsString() -> NSAttributedString {
        if let instructions = strInstructions, !instructions.isEmpty {
            let instructionsString = "Instructions:\n" + instructions

            let attributedString = NSMutableAttributedString(string: instructionsString)
            attributedString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: 0, length: 13)) // 13 is the length of "Instructions:"

            return attributedString
        } else {
            return NSAttributedString(string: "No instructions available.")
        }
    }
}
