//
//  ReadingsModel.swift
//  Natega
//
//  Created by Daniel Kamel on 05/02/2023.
//

import SwiftUI

struct ReadingsModel: Identifiable {
    
    let id = UUID()
    var bookTranslation0: String
    var bookRef0: String
    var bookTranslation1: String //this should be optional value
    var bookRef1: String //this should be optional value too
    var subSectionsTitle: String
    var sectionsTitle: String
    var backgroundColour: UIColor
    var shadowColour: UIColor
    
}


var readingsModel = [
    
    ReadingsModel(bookTranslation0: "Psalms", bookRef0: "5:16- 6:2", bookTranslation1: "Matt", bookRef1: "9:2 - 7:14", subSectionsTitle: "Gospel", sectionsTitle: "Vespers", backgroundColour: #colorLiteral(red: 0.6675507426, green: 0.8210205436, blue: 0.8714107275, alpha: 1), shadowColour: #colorLiteral(red: 0.5882352941, green: 0.7215686275, blue: 0.768627451, alpha: 1)),
    ReadingsModel(bookTranslation0: "Psalms", bookRef0: "9:6- 12:5", bookTranslation1: "John", bookRef1: "28:94 - 55:12", subSectionsTitle: "Gospel", sectionsTitle: "Matins", backgroundColour: #colorLiteral(red: 0.5459311604, green: 0.7349962592, blue: 0.7943460345, alpha: 1), shadowColour: #colorLiteral(red: 0.5064741801, green: 0.6827159129, blue: 0.7365359672, alpha: 1)),
    ReadingsModel(bookTranslation0: "Hebr", bookRef0: "5:16- 6:2", bookTranslation1: "", bookRef1: "", subSectionsTitle: "Pauline", sectionsTitle: "Liturgy", backgroundColour: #colorLiteral(red: 0.4585534334, green: 0.6763506532, blue: 0.7481973767, alpha: 1), shadowColour: #colorLiteral(red: 0.3833758654, green: 0.570027241, blue: 0.6299116783, alpha: 1)),
    ReadingsModel(bookTranslation0: "Eccles", bookRef0: "5:16- 6:2", bookTranslation1: "", bookRef1: "", subSectionsTitle: "Catholic Epistle", sectionsTitle: "Liturgy", backgroundColour: #colorLiteral(red: 0.7215166688, green: 0.495308578, blue: 0.5454573631, alpha: 1), shadowColour: #colorLiteral(red: 0.6231610124, green: 0.4285126279, blue: 0.4740481631, alpha: 1)),
    ReadingsModel(bookTranslation0: "Acts", bookRef0: "5:16- 6:2", bookTranslation1: "", bookRef1: "", subSectionsTitle: "Acts", sectionsTitle: "Liturgy", backgroundColour: #colorLiteral(red: 0.5917666554, green: 0.3747115433, blue: 0.4236382842, alpha: 1), shadowColour: #colorLiteral(red: 0.5193072818, green: 0.3294057615, blue: 0.3710972268, alpha: 1)),
    ReadingsModel(bookTranslation0: "Psalms", bookRef0: "5:16- 6:2", bookTranslation1: "Luke", bookRef1: "8:12 - 15:32", subSectionsTitle: "Gospel", sectionsTitle: "Liturgy", backgroundColour: #colorLiteral(red: 0.6449046731, green: 0.4493768215, blue: 0.7136461139, alpha: 1), shadowColour: #colorLiteral(red: 0.5613088652, green: 0.3897872796, blue: 0.6234878482, alpha: 1))

]
