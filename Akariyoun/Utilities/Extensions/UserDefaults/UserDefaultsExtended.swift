

import Foundation

extension UserDefaults {
    
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
    
    func setLanguage(languageName: String) {
      self.set(languageName, forKey: "Lang")
      self.synchronize()
    }
    
    func getLanguageName() -> String? {
      let selectedName = self.string(forKey: "Lang")
      return selectedName
    }
}
