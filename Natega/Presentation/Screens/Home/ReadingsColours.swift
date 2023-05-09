//
//  ReadingsColours.swift
//  Natega
//
//  Created by Daniel Kamel on 17/04/2023.
//

import SwiftUI

import SwiftUI

struct ReadingsColours: Identifiable {
    
    let id = UUID()
    var backgroundColour: UIColor
    var fontColour: UIColor
    var shadowColour: UIColor
    
}


var readingsColours = [
    
    ReadingsColours(backgroundColour: #colorLiteral(red: 0.6549019608, green: 0.8274509804, blue: 0.8862745098, alpha: 1), fontColour: #colorLiteral(red: 0.07058823529, green: 0.2117647059, blue: 0.2588235294, alpha: 1), shadowColour: #colorLiteral(red: 0.7624871053, green: 0.8630574965, blue: 0.8958211425, alpha: 1)),
    ReadingsColours(backgroundColour: #colorLiteral(red: 0.7411764706, green: 0.6862745098, blue: 0.9607843137, alpha: 1), fontColour: #colorLiteral(red: 0.1647058824, green: 0.1294117647, blue: 0.3058823529, alpha: 0.7478736812), shadowColour: #colorLiteral(red: 0.8352941176, green: 0.8, blue: 0.9803921569, alpha: 0.7082039596)),
    ReadingsColours(backgroundColour: #colorLiteral(red: 0.9882352941, green: 0.7176470588, blue: 0.9450980392, alpha: 1), fontColour: #colorLiteral(red: 0.4, green: 0.1215686275, blue: 0.3568627451, alpha: 1), shadowColour: #colorLiteral(red: 1, green: 0.8392156863, blue: 0.9725490196, alpha: 1)),
    ReadingsColours(backgroundColour: #colorLiteral(red: 0.6862745098, green: 0.9215686275, blue: 0.662745098, alpha: 1), fontColour: #colorLiteral(red: 0.09019607843, green: 0.3843137255, blue: 0.06666666667, alpha: 1), shadowColour: #colorLiteral(red: 0.8196078431, green: 0.9803921569, blue: 0.8039215686, alpha: 1)),
    ReadingsColours(backgroundColour: #colorLiteral(red: 0.9607843137, green: 0.8117647059, blue: 0.6745098039, alpha: 1), fontColour: #colorLiteral(red: 0.4156862745, green: 0.2862745098, blue: 0.168627451, alpha: 1), shadowColour: #colorLiteral(red: 0.9803921569, green: 0.8862745098, blue: 0.8039215686, alpha: 1)),
    ReadingsColours(backgroundColour: #colorLiteral(red: 0.6392156863, green: 0.7098039216, blue: 0.9568627451, alpha: 1), fontColour: #colorLiteral(red: 0.1607843137, green: 0.2274509804, blue: 0.4588235294, alpha: 1), shadowColour: #colorLiteral(red: 0.8509803922, green: 0.8823529412, blue: 0.9882352941, alpha: 1))

]

