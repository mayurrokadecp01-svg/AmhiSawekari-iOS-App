import Foundation
import SwiftUI

@Observable
class LyricsViewModel {
    var fontSize: CGFloat = 18.0
    
    func increaseFontSize() {
        if fontSize < 40 {
            fontSize += 2
        }
    }
    
    func decreaseFontSize() {
        if fontSize > 12 {
            fontSize -= 2
        }
    }
}
