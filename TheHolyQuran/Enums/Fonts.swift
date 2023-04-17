//
//  Fonts.swift
//  Quran
//
//  Created by No one on 4/2/23.
//

import Foundation

enum ArabicFonts: String, AppFonts {
    typealias FontCase = ArabicFonts
    
    // Bundled
    case SFArabic = "SF Arabic"
    case SFArabicRounded = "SF Arabic Rounded"
    case KFGQPCUthmanTahaNaskh = "KFGQPC Uthman Taha Naskh"
    case KFGQPCUthmanicHafs = "KFGQPC Uthmanic Script HAFS"
    case Lateef = "Lateef"
    case DroidKufi = "Droid Arabic Kufi"
    case DroidNaskh = "Droid Arabic Naskh"
    case Scheherazade = "Scheherazade"
    case DecoTypeNaskh = "DecoType Naskh"
    case DecoTypeThuluth = "DecoType Thuluth"
    case DecoTypeThuluthII = "DecoType Thuluth II"
    case GeezaPro = "Geeza Pro"
    case SFPro = "SF Pro"
    
    var source: String? {
        switch self {
        case .Lateef:
            return "https://www.fontspace.com/lateef-font-f13291"
        case .DroidKufi:
            return "https://www.fontsc.com/font/droid-arabic-kufi"
        case .DroidNaskh:
            return "https://www.fontsc.com/font/droid-arabic-naskh"
        case .Scheherazade:
            return "https://www.fontspace.com/scheherazade-font-f13290"
        case .KFGQPCUthmanicHafs:
            return "https://arabicfonts.net/fonts/kfgqpc-uthmanic-script-hafs-regular"
        case .KFGQPCUthmanTahaNaskh:
            return "https://arabicfonts.net/fonts/kfgqpc-uthman-taha-naskh-regular"
        case .DecoTypeThuluth:
            return "https://arabicfonts.net/fonts/decotype-thuluth-regular"
        case .DecoTypeThuluthII:
            return "https://www.freearabicfont.com/download.php?id=738132"
        case .DecoTypeNaskh:
            return "https://arabicfonts.net/fonts/decotype-naskh-regular_1"
        default:
            return nil
        }
    }
    
    static var defaultFontFamily: ArabicFonts {
        firstAvailable(from: [.SFArabic, .SFArabicRounded, .GeezaPro], fallback: .SFPro)
    }
    
    static var defaultFontSize: CGFloat {
        return 30
    }
}

enum TranslationFonts: String, AppFonts {
    typealias FontCase = TranslationFonts
    
    case Tahoma = "Tahoma"
    case SFArabic = "SF Arabic"
    case SFArabicRounded = "SF Arabic Rounded"
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
    case KFGQPCUthmanTahaNaskh = "KFGQPC Uthman Taha Naskh"
    case KFGQPCUthmanicHafs = "KFGQPC Uthmanic Script HAFS"
    
    static var defaultFontFamily: TranslationFonts {
        firstAvailable(from: [.Tahoma, .HelveticaNeue, .Arial], fallback: .SFPro)
    }
    
    static var defaultFontSize: CGFloat {
        return 13
    }
}

