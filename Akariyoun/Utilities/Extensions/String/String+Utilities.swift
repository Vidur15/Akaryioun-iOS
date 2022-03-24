

import Foundation
import UIKit

extension String {
    
    func localized() -> String {

               let selectedLangCode = kSharedUserDefaults.getLanguageName()
               if let path = Bundle.main.path(forResource: selectedLangCode, ofType: "lproj"),
                   let bundle = Bundle.init(path: path) {
                   return bundle.localizedString(forKey: self, value: nil, table: nil)
               } else {
                   return self
               }
           }
}
