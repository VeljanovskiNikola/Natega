//
//  ReadingsBackgroundColour.swift
//  Natega
//
//  Created by Daniel Kamel on 19/03/2023.
//

import SwiftUI

struct ReadingsBackgroundColour: Identifiable {
    
    let id = UUID()
    var backgroundColour: UIColor
    var fontColour: UIColor
    var shadowColour: UIColor
    
}


var readingsBackgroundColours = [
    
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), fontColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), fontColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), fontColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), fontColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), fontColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), fontColour: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), fontColour: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), fontColour: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), fontColour: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsBackgroundColour(backgroundColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1), fontColour: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1))

]
