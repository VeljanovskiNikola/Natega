//
//  SaintIconModel.swift
//  Natega
//
//  Created by Daniel Kamel on 22/01/2023.
//

import SwiftUI
import UIImageColors

struct SaintIconModel: Identifiable {
    let id = UUID()
    var name: String
    var textBackgroundColour: UIColor {
        getImageColor().primary
    }
    
    var image: UIImage {
        UIImage(named: name) ?? UIImage(named: "placeholder")!
    }
    
    func getImageColor() -> UIImageColors {
        image.getColors() ?? UIImageColors(background: .black,
                                           primary: .white,
                                           secondary: .black, detail: .blue)
    }
}

var saintIconModels = [
    SaintIconModel(name: "Also Pope Kyrillos VI Colorized"),
    SaintIconModel(name: "Christ Walking on Water")
//    SaintIconModel(image: #imageLiteral(resourceName: "Baptism of Christ - Epiphany"), name: "Baptism of Christ - Epiphany", textBackgroundColour: #colorLiteral(red: 0.3842259645, green: 0.6392288804, blue: 0.8784164786, alpha: 1)),
//    SaintIconModel(image: #imageLiteral(resourceName: "Pope cyril with relics of St Mark"), name: "Pope Kyrillos VI Transporting Relics of St Mark To Egypt", textBackgroundColour: #colorLiteral(red: 0.04706653208, green: 0, blue: 1.355371182e-06, alpha: 1)),
//    SaintIconModel(image: #imageLiteral(resourceName: "IMG_7110 2"), name: "💙", textBackgroundColour: #colorLiteral(red: 0.2823027372, green: 0.4156957269, blue: 0.6470468044, alpha: 1)),
//    SaintIconModel(image: #imageLiteral(resourceName: "Last supper"), name: "The Last Supper", textBackgroundColour: #colorLiteral(red: 0.5647462606, green: 0.2352636158, blue: 0.1137743667, alpha: 1)),
//    SaintIconModel(image: #imageLiteral(resourceName: "Archangel Michael"), name: "Archangeal Michael", textBackgroundColour: #colorLiteral(red: 0.8706330657, green: 0.6078236699, blue: 0.1138941124, alpha: 1)),
//    SaintIconModel(image: #imageLiteral(resourceName: "Miracle of Cana at Galilee - turning the water into wine"), name: "Miracle of Cana at Galilee - turning the water into wine", textBackgroundColour: #colorLiteral(red: 0.7294577956, green: 0.4078175426, blue: 0.03160278499, alpha: 1)),
//    SaintIconModel(image: #imageLiteral(resourceName: "Feeding the Multitude"), name: "Feeding the Multitude", textBackgroundColour: #colorLiteral(red: 0.160746634, green: 0.3294155598, blue: 0.1294233501, alpha: 1)),
//    SaintIconModel(image: #imageLiteral(resourceName: "Christ Praying in the Garden"), name: "Christ Praying in the Garden", textBackgroundColour: #colorLiteral(red: 0.1176311895, green: 0.1529450715, blue: 0.2745040655, alpha: 1)),

]
