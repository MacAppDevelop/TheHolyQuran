//
//  TranslationLanguages.swift
//  TheHolyQuran
//
//  Created by No one on 4/7/23.
//

enum TranslationLanguages: String, CaseIterable, Identifiable {
    case am = "Amharic"
    case az = "Azerbaijani"
    case ber = "Amazigh"
    case bg = "Bulgarian"
    case bn = "Bengali"
    case bs = "Bosnian"
    case cs = "Czech"
    case de = "German"
    case dv = "Divehi"
    case en = "English"
    case es = "Spanish"
    case fa = "Persian"
    case fr = "French"
    case ha = "Hausa"
    case hi = "Hindi"
    case id = "Indonesian"
    case it = "Italian"
    case ja = "Japanese"
    case ko = "Korean"
    case ku = "Kurdish"
    case ml = "Malayalam"
    case ms = "Malay"
    case nl = "Dutch"
    case no = "Norwegian"
    case pl = "Polish"
    case ps = "Pashto"
    case pt = "Portuguese"
    case ro = "Romanian"
    case ru = "Russian"
    case sd = "Sindhi"
    case so = "Somali"
    case sq = "Albanian"
    case sv = "Swedish"
    case sw = "Swahili"
    case ta = "Tamil"
    case tg = "Tajik"
    case th = "Thai"
    case tr = "Turkish"
    case tt = "Tatar"
    case ug = "Uyghur"
    case ur = "Urdu"
    case uz = "Uzbek"
    case zh = "Chinese"
    
    var locale: String {
        String(describing: self).uppercased()
    }
    
    var localName: String {
        switch self {
        case .am:
            return "አማርኛ"
        case .az:
            return "Azəri"
        case .ber:
            return "Tamaziɣt"
        case .bg:
            return "български"
        case .bn:
            return "বাংলা"
        case .bs:
            return "босански"
        case .cs:
            return "čeština"
        case .de:
            return "Deutsch"
        case .dv:
            return "ދިވެހ"
        case .en:
            return "English"
        case .es:
            return "Español"
        case .fa:
            return "فارسی"
        case .fr:
            return "Français"
        case .ha:
            return "Hausa"
        case .hi:
            return "हिन्दी"
        case .id:
            return "Bahasa Indonesia"
        case .it:
            return "Italiano"
        case .ja:
            return "日本語"
        case .ko:
            return "한국어"
        case .ku:
            return "کوردی"
        case .ml:
            return "മലയാളം"
        case .ms:
            return "Bahasa Melayu"
        case .nl:
            return "Nederlands"
        case .no:
            return "Norsk"
        case .pl:
            return "Polski"
        case .ps:
            return "پښتو"
        case .pt:
            return "Português"
        case .ro:
            return "Limba Română"
        case .ru:
            return "русский язык"
        case .sd:
            return "سنڌي"
        case .so:
            return "Af-Soomaali"
        case .sq:
            return "Gjuha shqipe"
        case .sv:
            return "Svenska"
        case .sw:
            return "Kiswahili"
        case .ta:
            return "தமிழ்"
        case .tg:
            return "Тоҷикӣ"
        case .th:
            return "ภาษาไทย"
        case .tr:
            return "Türkçe"
        case .tt:
            return "татар теле"
        case .ug:
            return "ئۇيغۇر تىلى"
        case .ur:
            return "اردو"
        case .uz:
            return "Ўзбек тили"
        case .zh:
            return "中文"
        }
    }
    
    var id: String {
        self.rawValue
    }
}
