//
//  Constants.swift
//  Quran
//
//  Created by No one on 4/1/23.
//

import Foundation

struct K {
    static let mainAppNavigationTitle = "The Holy Quran"
    
    static let theHolyQuranArabicSQLiteFile = "TheHolyQuran"
    
    static let includedTranslations: [IncludedTranslation] = [
        IncludedTranslation.disableTranslation,
        IncludedTranslation(lang: "Amharic", langLocal: "አማርኛ", name: "ሳዲቅ & ሳኒ ሐቢብ", translator: "Muhammed Sadiq and Muhammed Sani Habib", sql: "am_sadiq", locId: "am"),
        IncludedTranslation(lang: "Azerbaijani", langLocal: "Azəri", name: "Məmmədəliyev & Bünyadov", translator: "Vasim Mammadaliyev and Ziya Bunyadov", sql: "az_mammadaliyev", locId: "az"),
        IncludedTranslation(lang: "Azerbaijani", langLocal: "Azəri", name: "Musayev", translator: "Alikhan Musayev", sql: "az_musayev", locId: "az"),
        IncludedTranslation(lang: "Amazigh", langLocal: "Tamaziɣt / Amazigh", name: "At Mensur", translator: "Ramdane At Mansour", sql: "ber_mensur", locId: "ber"),
        IncludedTranslation(lang: "Bulgarian", langLocal: "български", name: "Теофанов", translator: "Tzvetan Theophanov", sql: "bg_theophanov", locId: "bg"),
        IncludedTranslation(lang: "Bengali", langLocal: "বাংলা", name: "মুহিউদ্দীন খান", translator: "Muhiuddin Khan", sql: "bn_bengali", locId: "bn"),
        IncludedTranslation(lang: "Bengali", langLocal: "বাংলা", name: "জহুরুল হক", translator: "Zohurul Hoque", sql: "bn_hoque", locId: "bn"),
        IncludedTranslation(lang: "Bosnian", langLocal: "босански", name: "Korkut", translator: "Besim Korkut", sql: "bs_korkut", locId: "bs"),
        IncludedTranslation(lang: "Bosnian", langLocal: "босански", name: "Mlivo", translator: "Mustafa Mlivo", sql: "bs_mlivo", locId: "bs"),
        IncludedTranslation(lang: "Czech", langLocal: "čeština", name: "Hrbek", translator: "Preklad I. Hrbek", sql: "cs_hrbek", locId: "cs"),
        IncludedTranslation(lang: "Czech", langLocal: "čeština", name: "Nykl", translator: "A. R. Nykl", sql: "cs_nykl", locId: "cs"),
        IncludedTranslation(lang: "German", langLocal: "Deutsch", name: "Abu Rida", translator: "Abu Rida Muhammad ibn Ahmad ibn Rassoul", sql: "de_aburida", locId: "de"),
        IncludedTranslation(lang: "German", langLocal: "Deutsch", name: "Bubenheim & Elyas", translator: "A. S. F. Bubenheim and N. Elyas", sql: "de_bubenheim", locId: "de"),
        IncludedTranslation(lang: "German", langLocal: "Deutsch", name: "Khoury", translator: "Adel Theodor Khoury", sql: "de_khoury", locId: "de"),
        IncludedTranslation(lang: "Divehi", langLocal: "ދިވެހ", name: "ދިވެހި", translator: "Office of the President of Maldives", sql: "dv_divehi", locId: "dv", dir: .rightToLeft),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Ahmed Ali", translator: "Ahmed Ali", sql: "en_ahmedali", locId: "en"),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Ahmed Raza Khan", translator: "Ahmed Raza Khan", sql: "en_ahmedraza", locId: "en"),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Arberry", translator: "A. J. Arberry", sql: "en_arberry", locId: "en"),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Daryabadi", translator: "Abdul Majid Daryabadi", sql: "en_daryabadi", locId: "en"),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Hilali & Khan", translator: "Muhammad Taqi-ud-Din al-Hilali and Muhammad Muhsin Khan", sql: "en_hilali", locId: "en"),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Maududi", translator: "Abul Ala Maududi", sql: "en_maududi", locId: "en"),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Sarwar", translator: "Muhammad Sarwar", sql: "en_sarwar", locId: "en"),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Shakir", translator: "Mohammad Habib Shakir", sql: "en_shakir", locId: "en"),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Wahiduddin Khan", translator: "Wahiduddin Khan", sql: "en_wahiduddin", locId: "en"),
        IncludedTranslation(lang: "English", langLocal: "English", name: "Yusuf Ali", translator: "Abdullah Yusuf Ali", sql: "en_yusufali", locId: "en"),
        IncludedTranslation(lang: "Spanish", langLocal: "Español", name: "Cortes", translator: "Julio Cortes ", sql: "es_cortes", locId: "es"),
        IncludedTranslation(lang: "Spanish", langLocal: "Español", name: "Garcia", translator: "Muhammad Isa García", sql: "es_garcia", locId: "es"),
        IncludedTranslation(lang: "Persian", langLocal: "فارسی", name: "فولادوند", translator: "Mohammad Mahdi Fooladvand", sql: "fa_fooladvand", locId: "fa", dir: .rightToLeft),
        IncludedTranslation(lang: "Persian", langLocal: "فارسی", name: "الهی قمشه‌ای", translator: "Mahdi Elahi Ghomshei", sql: "fa_ghomshei", locId: "fa", dir: .rightToLeft),
        IncludedTranslation(lang: "Persian", langLocal: "فارسی", name: "خرمشاهی", translator: "Baha'oddin Khorramshahi", sql: "fa_khorramshahi", locId: "fa", dir: .rightToLeft),
        IncludedTranslation(lang: "Persian", langLocal: "فارسی", name: "مجتبوی", translator: "Sayyed Jalaloddin Mojtabavi", sql: "fa_mojtabavi", locId: "fa", dir: .rightToLeft),
        IncludedTranslation(lang: "French", langLocal: "Français", name: "Hamidullah", translator: "Muhammad Hamidullah", sql: "fr_hamidullah", locId: "fr"),
        IncludedTranslation(lang: "Hausa", langLocal: "Hausa", name: "Gumi", translator: "Abubakar Mahmoud Gumi", sql: "ha_gumi", locId: "ha"),
        IncludedTranslation(lang: "Hindi", langLocal: "हिन्दी", name: "फ़ारूक़ ख़ान & अहमद", translator: "Muhammad Farooq Khan and Muhammad Ahmed", sql: "hi_farooq", locId: "hi"),
        IncludedTranslation(lang: "Hindi", langLocal: "हिन्दी", name: "फ़ारूक़ ख़ान & नदवी", translator: "Suhel Farooq Khan and Saifur Rahman Nadwi", sql: "hi_hindi", locId: "hi"),
        IncludedTranslation(lang: "Indonesian", langLocal: "Bahasa Indonesia", name: "Bahasa Indonesia", translator: "Indonesian Ministry of Religious Affairs", sql: "id_indonesian", locId: "id"),
        IncludedTranslation(lang: "Italian", langLocal: "Italiano", name: "Piccardo", translator: "Hamza Roberto Piccardo", sql: "it_piccardo", locId: "it"),
        IncludedTranslation(lang: "Japanese", langLocal: "日本語", name: "Japanese", translator: "Unknown", sql: "ja_japanese", locId: "ja"),
        IncludedTranslation(lang: "Korean", langLocal: "한국어", name: "Korean", translator: "Unknown", sql: "ko_korean", locId: "ko"),
        IncludedTranslation(lang: "Kurdish", langLocal: "کوردی", name: "ته‌فسیری ئاسان", translator: "Burhan Muhammad-Amin", sql: "ku_asan", locId: "ku", dir: .rightToLeft),
        IncludedTranslation(lang: "Malayalam", langLocal: "മലയാളം", name: "അബ്ദുല്‍ ഹമീദ് & പറപ്പൂര്‍", translator: "Cheriyamundam Abdul Hameed and Kunhi Mohammed Parappoor", sql: "ml_abdulhameed", locId: "ml"),
        IncludedTranslation(lang: "Malayalam", langLocal: "മലയാളം", name: "കാരകുന്ന് & എളയാവൂര്", translator: "Muhammad Karakunnu and Vanidas Elayavoor", sql: "ml_karakunnu", locId: "ml"),
        IncludedTranslation(lang: "Malay", langLocal: "Bahasa Melayu", name: "Basmeih", translator: "Abdullah Muhammad Basmeih", sql: "ms_basmeih", locId: "ms"),
        IncludedTranslation(lang: "Dutch", langLocal: "Nederlands", name: "Keyzer", translator: "Salomo Keyzer", sql: "nl_keyzer", locId: "nl"),
        IncludedTranslation(lang: "Dutch", langLocal: "Nederlands", name: "Leemhuis", translator: "Fred Leemhuis", sql: "nl_leemhuis", locId: "nl"),
        IncludedTranslation(lang: "Norwegian", langLocal: "Norsk", name: "Einar Berg", translator: "Einar Berg", sql: "no_berg", locId: "no"),
        IncludedTranslation(lang: "Polish", langLocal: "Polski", name: "Bielawskiego", translator: "Józefa Bielawskiego", sql: "pl_bielawskiego", locId: "pl"),
        IncludedTranslation(lang: "Pashto", langLocal: "پښتو", name: "عبدالولي", translator: "Abdulwali Khan", sql: "ps_abdulwali", locId: "ps", dir: .rightToLeft),
        IncludedTranslation(lang: "Portuguese", langLocal: "Português", name: "El-Hayek", translator: "Samir El-Hayek", sql: "pt_elhayek", locId: "pt"),
        IncludedTranslation(lang: "Romanian", langLocal: "Limba Română", name: "Grigore", translator: "George Grigore", sql: "ro_grigore", locId: "ro"),
        IncludedTranslation(lang: "Russian", langLocal: "русский язык", name: "Крачковский", translator: "Ignaty Yulianovich Krachkovsky", sql: "ru_krachkovsky", locId: "ru"),
        IncludedTranslation(lang: "Russian", langLocal: "русский язык", name: "Османов", translator: "Magomed-Nuri Osmanovich Osmanov", sql: "ru_osmanov", locId: "ru"),
        IncludedTranslation(lang: "Russian", langLocal: "русский язык", name: "Порохова", translator: "V. Porokhova", sql: "ru_porokhova", locId: "ru"),
        IncludedTranslation(lang: "Russian", langLocal: "русский язык", name: "Саблуков", translator: "Gordy Semyonovich Sablukov", sql: "ru_sablukov", locId: "ru"),
        IncludedTranslation(lang: "Sindhi", langLocal: "سنڌي", name: "امروٽي", translator: "Taj Mehmood Amroti", sql: "sd_amroti", locId: "sd", dir: .rightToLeft),
        IncludedTranslation(lang: "Somali", langLocal: "Af-Soomaali", name: "Abduh", translator: "Mahmud Muhammad Abduh", sql: "so_abduh", locId: "so"),
        IncludedTranslation(lang: "Albanian", langLocal: "Gjuha shqipe", name: "Sherif Ahmeti", translator: "Sherif Ahmeti", sql: "sq_ahmeti", locId: "sq"),
        IncludedTranslation(lang: "Albanian", langLocal: "Gjuha shqipe", name: "Feti Mehdiu", translator: "Feti Mehdiu", sql: "sq_mehdiu", locId: "sq"),
        IncludedTranslation(lang: "Albanian", langLocal: "Gjuha shqipe", name: "Efendi Nahi", translator: "Hasan Efendi Nahi", sql: "sq_nahi", locId: "sq"),
        IncludedTranslation(lang: "Swedish", langLocal: "Svenska", name: "Bernström", translator: "Knut Bernström", sql: "sv_bernstrom", locId: "sv"),
        IncludedTranslation(lang: "Swahili", langLocal: "Kiswahili / Swahili", name: "Al-Barwani", translator: "Ali Muhsin Al-Barwani", sql: "sw_barwani", locId: "sw"),
        IncludedTranslation(lang: "Tamil", langLocal: "தமிழ்", name: "ஜான் டிரஸ்ட்", translator: "Jan Turst Foundation", sql: "ta_tamil", locId: "ta"),
        IncludedTranslation(lang: "Tajik", langLocal: "Тоҷикӣ", name: "Оятӣ", translator: "AbdolMohammad Ayati", sql: "tg_ayati", locId: "tg"),
        IncludedTranslation(lang: "Thai", langLocal: "ภาษาไทย", name: "ภาษาไทย", translator: "King Fahad Quran Complex", sql: "th_thai", locId: "th"),
        IncludedTranslation(lang: "Turkish", langLocal: "Türkçe", name: "Süleyman Ateş", translator: "Suleyman Ates", sql: "tr_ates", locId: "tr"),
        IncludedTranslation(lang: "Turkish", langLocal: "Türkçe", name: "Diyanet İşleri", translator: "Diyanet Isleri", sql: "tr_diyanet", locId: "tr"),
        IncludedTranslation(lang: "Turkish", langLocal: "Türkçe", name: "Öztürk", translator: "Yasar Nuri Ozturk", sql: "tr_ozturk", locId: "tr"),
        IncludedTranslation(lang: "Turkish", langLocal: "Türkçe", name: "Çeviriyazı", translator: "Muhammet Abay", sql: "tr_transliteration", locId: "tr"),
        IncludedTranslation(lang: "Turkish", langLocal: "Türkçe", name: "Elmalılı Hamdi Yazır", translator: "Elmalili Hamdi Yazir", sql: "tr_yazir", locId: "tr"),
        IncludedTranslation(lang: "Turkish", langLocal: "Türkçe", name: "Yıldırım", translator: "Suat Yildirim", sql: "tr_yildirim", locId: "tr"),
        IncludedTranslation(lang: "Turkish", langLocal: "Türkçe", name: "Edip Yüksel", translator: "Edip Yüksel", sql: "tr_yuksel", locId: "tr"),
        IncludedTranslation(lang: "Tatar", langLocal: "татар теле", name: "Yakub Ibn Nugman", translator: "Yakub Ibn Nugman", sql: "tt_nugman", locId: "tt"),
        IncludedTranslation(lang: "Uyghur", langLocal: "ئۇيغۇر تىلى", name: "محمد صالح", translator: "Muhammad Saleh", sql: "ug_saleh", locId: "ug", dir: .rightToLeft),
        IncludedTranslation(lang: "Urdu", langLocal: "اردو", name: "احمد علی", translator: "Ahmed Ali", sql: "ur_ahmedali", locId: "ur", dir: .rightToLeft),
        IncludedTranslation(lang: "Urdu", langLocal: "اردو", name: "احمد رضا خان", translator: "Ahmed Raza Khan", sql: "ur_kanzuliman", locId: "ur", dir: .rightToLeft),
        IncludedTranslation(lang: "Urdu", langLocal: "اردو", name: "ابوالاعلی مودودی", translator: "Abul A'ala Maududi", sql: "ur_maududi", locId: "ur", dir: .rightToLeft),
        IncludedTranslation(lang: "Uzbek", langLocal: "Ўзбек тили", name: "Мухаммад Содик", translator: "Muhammad Sodik Muhammad Yusuf", sql: "uz_sodik", locId: "uz"),
        IncludedTranslation(lang: "Chinese", langLocal: "中文", name: "Ma Jian", translator: "Ma Jian", sql: "zh_jian", locId: "zh"),
        IncludedTranslation(lang: "Chinese", langLocal: "中文", name: "Ma Jian (Traditional)", translator: "Ma Jian", sql: "zh_majian", locId: "zh")
    ]
    static let defaultTranslationSQLiteFileName = "en_hilali"
    
    static let minimumMainSearchCharacters = 3
    
    static let surahNameFontFamily: ArabicFonts = .firstAvailable(from: [.SFArabic, .SFArabicRounded, .GeezaPro], fallback: .SFPro)
    static let surahNameFontSize: CGFloat = 35
    static let surahSpacing: CGFloat = 30
    static let verseNumberSize: CGFloat = 38
    
    static let ayaFontMinSize: Double = 20
    static let ayaFontMaxSize: Double = 100
    
    static let translationFontMinSize: Double = 8
    static let translationFontMaxSize: Double = 50
    static let translationLineSpacing: CGFloat = 5
    
    struct StorageKeys {
        static let quranTextTypeSelection = "quranTextTypeSelection"
        
        static let appearance = "appearance"
        
        static let arabicFontFamily = "arabicFontFamily"
        static let arabicFontSize = "arabicFontSize"
        
        static let selectedTranslationSQLiteFileName = "selectedTranslationSQLiteFileName"
        static let translationFontFamily = "translationFontFamily"
        static let translationFontSize = "translationFontSize"
        
        static let bookmarkedSurahs = "bookmarkedSurahs"
        
        static let savedStateSurah = "savedStateSurah"
        static let savedStateAya = "savedStateAya"
    }
}
