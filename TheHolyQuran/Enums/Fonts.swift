//
//  Fonts.swift
//  Quran
//
//  Created by No one on 4/2/23.
//

import Foundation

enum ArabicFonts: String, AppFonts {
    typealias FontCase = ArabicFonts
    
    case AlNile = "Al Nile"
    case AlBayan = "Al Bayan"
    case AlTarikh = "Al Tarikh"
    case Baghdad = "Baghdad"
    case Farisi = "Farisi"
    case Nadeem = "Nadeem"
    case Mishafi = "Mishafi"
    case DiwanThuluth = "Diwan Thuluth"
    case DiwanKufi = "Diwan Kufi"
    case GeezaPro = "Geeza Pro"
    case SFPro = "SF Pro"
    
    static var defaultFontFamily: ArabicFonts {
        firstAvailable(from: [.AlNile, .AlBayan, .Baghdad], fallback: .SFPro)
    }
    
    static var defaultFontSize: CGFloat {
        return 30
    }
}

enum TranslationFonts: String, AppFonts {
    typealias FontCase = TranslationFonts
    
    case Tahoma = "Tahoma"
    case SFPro = "SF Pro"
    case Arial = "Arial"
    case Helvetica = "Helvetica"
    case HelveticaNeue = "Helvetica Neue"
    case Monaco = "Monaco"
    case Times = "Times"
    case Farisi = "Farisi"
    case AlBayan = "Al Bayan"
    case Baghdad = "Baghdad"
    case Nadeem = "Nadeem"
    case GeezaPro = "Geeza Pro"
    
    static var defaultFontFamily: TranslationFonts {
        firstAvailable(from: [.Tahoma, .HelveticaNeue, .Arial], fallback: .SFPro)
    }
    
    static var defaultFontSize: CGFloat {
        return 13
    }
}

