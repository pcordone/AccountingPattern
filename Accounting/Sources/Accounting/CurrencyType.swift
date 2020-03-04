// This file was automatically generated and should not be edited.

import Foundation
import os.log

/// A monetary unit.
/// https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes
/// https://en.wikipedia.org/wiki/ISO_4217
public enum CurrencyType: String {
        case AED="AED"
            ,AFN = "AFN"
            ,ALL = "ALL"
            ,AMD = "AMD"
            ,ANG = "ANG"
            ,AOA = "AOA"
            ,ARS = "ARS"
            ,AUD = "AUD"
            ,AWG = "AWG"
            ,AZN = "AZN"
            ,BAM = "BAM"
            ,BBD = "BBD"
            ,BDT = "BDT"
            ,BGN = "BGN"
            ,BHD = "BHD"
            ,BIF = "BIF"
            ,BMD = "BMD"
            ,BND = "BND"
            ,BOB = "BOB"
            ,BOV = "BOV"
            ,BRL = "BRL"
            ,BSD = "BSD"
            ,BTN = "BTN"
            ,BWP = "BWP"
            ,BYN = "BYN"
            ,BZD = "BZD"
            ,CAD = "CAD"
            ,CDF = "CDF"
            ,CHE = "CHE"
            ,CHF = "CHF"
            ,CHW = "CHW"
            ,CLF = "CLF"
            ,CLP = "CLP"
            ,CNY = "CNY"
            ,COP = "COP"
            ,COU = "COU"
            ,CRC = "CRC"
            ,CUC = "CUC"
            ,CUP = "CUP"
            ,CVE = "CVE"
            ,CZK = "CZK"
            ,DJF = "DJF"
            ,DKK = "DKK"
            ,DOP = "DOP"
            ,DZD = "DZD"
            ,EGP = "EGP"
            ,ERN = "ERN"
            ,ETB = "ETB"
            ,EUR = "EUR"
            ,FJD = "FJD"
            ,FKP = "FKP"
            ,GBP = "GBP"
            ,GEL = "GEL"
            ,GHS = "GHS"
            ,GIP = "GIP"
            ,GMD = "GMD"
            ,GNF = "GNF"
            ,GTQ = "GTQ"
            ,GYD = "GYD"
            ,HKD = "HKD"
            ,HNL = "HNL"
            ,HRK = "HRK"
            ,HTG = "HTG"
            ,HUF = "HUF"
            ,IDR = "IDR"
            ,ILS = "ILS"
            ,INR = "INR"
            ,IQD = "IQD"
            ,IRR = "IRR"
            ,ISK = "ISK"
            ,JMD = "JMD"
            ,JOD = "JOD"
            ,JPY = "JPY"
            ,KES = "KES"
            ,KGS = "KGS"
            ,KHR = "KHR"
            ,KMF = "KMF"
            ,KPW = "KPW"
            ,KRW = "KRW"
            ,KWD = "KWD"
            ,KYD = "KYD"
            ,KZT = "KZT"
            ,LAK = "LAK"
            ,LBP = "LBP"
            ,LKR = "LKR"
            ,LRD = "LRD"
            ,LSL = "LSL"
            ,LYD = "LYD"
            ,MAD = "MAD"
            ,MDL = "MDL"
            ,MGA = "MGA"
            ,MKD = "MKD"
            ,MMK = "MMK"
            ,MNT = "MNT"
            ,MOP = "MOP"
            ,MRU = "MRU"
            ,MUR = "MUR"
            ,MVR = "MVR"
            ,MWK = "MWK"
            ,MXN = "MXN"
            ,MXV = "MXV"
            ,MYR = "MYR"
            ,MZN = "MZN"
            ,NAD = "NAD"
            ,NGN = "NGN"
            ,NIO = "NIO"
            ,NOK = "NOK"
            ,NPR = "NPR"
            ,NZD = "NZD"
            ,OMR = "OMR"
            ,PAB = "PAB"
            ,PEN = "PEN"
            ,PGK = "PGK"
            ,PHP = "PHP"
            ,PKR = "PKR"
            ,PLN = "PLN"
            ,PYG = "PYG"
            ,QAR = "QAR"
            ,RON = "RON"
            ,RSD = "RSD"
            ,RUB = "RUB"
            ,RWF = "RWF"
            ,SAR = "SAR"
            ,SBD = "SBD"
            ,SCR = "SCR"
            ,SDG = "SDG"
            ,SEK = "SEK"
            ,SGD = "SGD"
            ,SHP = "SHP"
            ,SLL = "SLL"
            ,SOS = "SOS"
            ,SRD = "SRD"
            ,SSP = "SSP"
            ,STN = "STN"
            ,SVC = "SVC"
            ,SYP = "SYP"
            ,SZL = "SZL"
            ,THB = "THB"
            ,TJS = "TJS"
            ,TMT = "TMT"
            ,TND = "TND"
            ,TOP = "TOP"
            ,TRY = "TRY"
            ,TTD = "TTD"
            ,TWD = "TWD"
            ,TZS = "TZS"
            ,UAH = "UAH"
            ,UGX = "UGX"
            ,USD = "USD"
            ,UYI = "UYI"
            ,UYU = "UYU"
            ,UZS = "UZS"
            ,VEF = "VEF"
            ,VND = "VND"
            ,VUV = "VUV"
            ,WST = "WST"
            ,XCD = "XCD"
            ,YER = "YER"
            ,ZAR = "ZAR"
            ,ZMW = "ZMW"
            ,ZWL = "ZWL"
            ,XTS = "XTS"
            ,XXX = "XXX"

    public var code: String {
        return self.rawValue
    }

    public var name: String {
        switch self {
        case .AED:
            return "UAE Dirham"
        case .AFN:
            return "Afghani"
        case .ALL:
            return "Lek"
        case .AMD:
            return "Armenian Dram"
        case .ANG:
            return "Netherlands Antillean Guilder"
        case .AOA:
            return "Kwanza"
        case .ARS:
            return "Argentine Peso"
        case .AUD:
            return "Australian Dollar"
        case .AWG:
            return "Aruban Florin"
        case .AZN:
            return "Azerbaijan Manat"
        case .BAM:
            return "Convertible Mark"
        case .BBD:
            return "Barbados Dollar"
        case .BDT:
            return "Taka"
        case .BGN:
            return "Bulgarian Lev"
        case .BHD:
            return "Bahraini Dinar"
        case .BIF:
            return "Burundi Franc"
        case .BMD:
            return "Bermudian Dollar"
        case .BND:
            return "Brunei Dollar"
        case .BOB:
            return "Boliviano"
        case .BOV:
            return "Mvdol"
        case .BRL:
            return "Brazilian Real"
        case .BSD:
            return "Bahamian Dollar"
        case .BTN:
            return "Ngultrum"
        case .BWP:
            return "Pula"
        case .BYN:
            return "Belarusian Ruble"
        case .BZD:
            return "Belize Dollar"
        case .CAD:
            return "Canadian Dollar"
        case .CDF:
            return "Congolese Franc"
        case .CHE:
            return "WIR Euro"
        case .CHF:
            return "Swiss Franc"
        case .CHW:
            return "WIR Franc"
        case .CLF:
            return "Unidad de Fomento"
        case .CLP:
            return "Chilean Peso"
        case .CNY:
            return "Yuan Renminbi"
        case .COP:
            return "Colombian Peso"
        case .COU:
            return "Unidad de Valor Real"
        case .CRC:
            return "Costa Rican Colon"
        case .CUC:
            return "Peso Convertible"
        case .CUP:
            return "Cuban Peso"
        case .CVE:
            return "Cabo Verde Escudo"
        case .CZK:
            return "Czech Koruna"
        case .DJF:
            return "Djibouti Franc"
        case .DKK:
            return "Danish Krone"
        case .DOP:
            return "Dominican Peso"
        case .DZD:
            return "Algerian Dinar"
        case .EGP:
            return "Egyptian Pound"
        case .ERN:
            return "Nakfa"
        case .ETB:
            return "Ethiopian Birr"
        case .EUR:
            return "Euro"
        case .FJD:
            return "Fiji Dollar"
        case .FKP:
            return "Falkland Islands Pound"
        case .GBP:
            return "Pound Sterling"
        case .GEL:
            return "Lari"
        case .GHS:
            return "Ghana Cedi"
        case .GIP:
            return "Gibraltar Pound"
        case .GMD:
            return "Dalasi"
        case .GNF:
            return "Guinean Franc"
        case .GTQ:
            return "Quetzal"
        case .GYD:
            return "Guyana Dollar"
        case .HKD:
            return "Hong Kong Dollar"
        case .HNL:
            return "Lempira"
        case .HRK:
            return "Kuna"
        case .HTG:
            return "Gourde"
        case .HUF:
            return "Forint"
        case .IDR:
            return "Rupiah"
        case .ILS:
            return "New Israeli Sheqel"
        case .INR:
            return "Indian Rupee"
        case .IQD:
            return "Iraqi Dinar"
        case .IRR:
            return "Iranian Rial"
        case .ISK:
            return "Iceland Krona"
        case .JMD:
            return "Jamaican Dollar"
        case .JOD:
            return "Jordanian Dinar"
        case .JPY:
            return "Yen"
        case .KES:
            return "Kenyan Shilling"
        case .KGS:
            return "Som"
        case .KHR:
            return "Riel"
        case .KMF:
            return "Comorian Franc"
        case .KPW:
            return "North Korean Won"
        case .KRW:
            return "Won"
        case .KWD:
            return "Kuwaiti Dinar"
        case .KYD:
            return "Cayman Islands Dollar"
        case .KZT:
            return "Tenge"
        case .LAK:
            return "Lao Kip"
        case .LBP:
            return "Lebanese Pound"
        case .LKR:
            return "Sri Lanka Rupee"
        case .LRD:
            return "Liberian Dollar"
        case .LSL:
            return "Loti"
        case .LYD:
            return "Libyan Dinar"
        case .MAD:
            return "Moroccan Dirham"
        case .MDL:
            return "Moldovan Leu"
        case .MGA:
            return "Malagasy Ariary"
        case .MKD:
            return "Denar"
        case .MMK:
            return "Kyat"
        case .MNT:
            return "Tugrik"
        case .MOP:
            return "Pataca"
        case .MRU:
            return "Ouguiya"
        case .MUR:
            return "Mauritius Rupee"
        case .MVR:
            return "Rufiyaa"
        case .MWK:
            return "Malawi Kwacha"
        case .MXN:
            return "Mexican Peso"
        case .MXV:
            return "Mexican Unidad de Inversion (UDI)"
        case .MYR:
            return "Malaysian Ringgit"
        case .MZN:
            return "Mozambique Metical"
        case .NAD:
            return "Namibia Dollar"
        case .NGN:
            return "Naira"
        case .NIO:
            return "Cordoba Oro"
        case .NOK:
            return "Norwegian Krone"
        case .NPR:
            return "Nepalese Rupee"
        case .NZD:
            return "New Zealand Dollar"
        case .OMR:
            return "Rial Omani"
        case .PAB:
            return "Balboa"
        case .PEN:
            return "Sol"
        case .PGK:
            return "Kina"
        case .PHP:
            return "Philippine Piso"
        case .PKR:
            return "Pakistan Rupee"
        case .PLN:
            return "Zloty"
        case .PYG:
            return "Guarani"
        case .QAR:
            return "Qatari Rial"
        case .RON:
            return "Romanian Leu"
        case .RSD:
            return "Serbian Dinar"
        case .RUB:
            return "Russian Ruble"
        case .RWF:
            return "Rwanda Franc"
        case .SAR:
            return "Saudi Riyal"
        case .SBD:
            return "Solomon Islands Dollar"
        case .SCR:
            return "Seychelles Rupee"
        case .SDG:
            return "Sudanese Pound"
        case .SEK:
            return "Swedish Krona"
        case .SGD:
            return "Singapore Dollar"
        case .SHP:
            return "Saint Helena Pound"
        case .SLL:
            return "Leone"
        case .SOS:
            return "Somali Shilling"
        case .SRD:
            return "Surinam Dollar"
        case .SSP:
            return "South Sudanese Pound"
        case .STN:
            return "Dobra"
        case .SVC:
            return "El Salvador Colon"
        case .SYP:
            return "Syrian Pound"
        case .SZL:
            return "Lilangeni"
        case .THB:
            return "Baht"
        case .TJS:
            return "Somoni"
        case .TMT:
            return "Turkmenistan New Manat"
        case .TND:
            return "Tunisian Dinar"
        case .TOP:
            return "Pa’anga"
        case .TRY:
            return "Turkish Lira"
        case .TTD:
            return "Trinidad and Tobago Dollar"
        case .TWD:
            return "New Taiwan Dollar"
        case .TZS:
            return "Tanzanian Shilling"
        case .UAH:
            return "Hryvnia"
        case .UGX:
            return "Uganda Shilling"
        case .USD:
            return "US Dollar"
        case .UYI:
            return "Uruguay Peso en Unidades Indexadas (UI)"
        case .UYU:
            return "Peso Uruguayo"
        case .UZS:
            return "Uzbekistan Sum"
        case .VEF:
            return "Bolívar"
        case .VND:
            return "Dong"
        case .VUV:
            return "Vatu"
        case .WST:
            return "Tala"
        case .XCD:
            return "East Caribbean Dollar"
        case .YER:
            return "Yemeni Rial"
        case .ZAR:
            return "Rand"
        case .ZMW:
            return "Zambian Kwacha"
        case .ZWL:
            return "Zimbabwe Dollar"
        case .XTS:
            return "Testing"
        case .XXX:
            return "None"
        }
    }

    public var minorUnit: Int {
        switch self {
        case .AED:
            return 2
        case .AFN:
            return 2
        case .ALL:
            return 2
        case .AMD:
            return 2
        case .ANG:
            return 2
        case .AOA:
            return 2
        case .ARS:
            return 2
        case .AUD:
            return 2
        case .AWG:
            return 2
        case .AZN:
            return 2
        case .BAM:
            return 2
        case .BBD:
            return 2
        case .BDT:
            return 2
        case .BGN:
            return 2
        case .BHD:
            return 3
        case .BIF:
            return 0
        case .BMD:
            return 2
        case .BND:
            return 2
        case .BOB:
            return 2
        case .BOV:
            return 2
        case .BRL:
            return 2
        case .BSD:
            return 2
        case .BTN:
            return 2
        case .BWP:
            return 2
        case .BYN:
            return 2
        case .BZD:
            return 2
        case .CAD:
            return 2
        case .CDF:
            return 2
        case .CHE:
            return 2
        case .CHF:
            return 2
        case .CHW:
            return 2
        case .CLF:
            return 4
        case .CLP:
            return 0
        case .CNY:
            return 2
        case .COP:
            return 2
        case .COU:
            return 2
        case .CRC:
            return 2
        case .CUC:
            return 2
        case .CUP:
            return 2
        case .CVE:
            return 2
        case .CZK:
            return 2
        case .DJF:
            return 0
        case .DKK:
            return 2
        case .DOP:
            return 2
        case .DZD:
            return 2
        case .EGP:
            return 2
        case .ERN:
            return 2
        case .ETB:
            return 2
        case .EUR:
            return 2
        case .FJD:
            return 2
        case .FKP:
            return 2
        case .GBP:
            return 2
        case .GEL:
            return 2
        case .GHS:
            return 2
        case .GIP:
            return 2
        case .GMD:
            return 2
        case .GNF:
            return 0
        case .GTQ:
            return 2
        case .GYD:
            return 2
        case .HKD:
            return 2
        case .HNL:
            return 2
        case .HRK:
            return 2
        case .HTG:
            return 2
        case .HUF:
            return 2
        case .IDR:
            return 2
        case .ILS:
            return 2
        case .INR:
            return 2
        case .IQD:
            return 3
        case .IRR:
            return 2
        case .ISK:
            return 0
        case .JMD:
            return 2
        case .JOD:
            return 3
        case .JPY:
            return 0
        case .KES:
            return 2
        case .KGS:
            return 2
        case .KHR:
            return 2
        case .KMF:
            return 0
        case .KPW:
            return 2
        case .KRW:
            return 0
        case .KWD:
            return 3
        case .KYD:
            return 2
        case .KZT:
            return 2
        case .LAK:
            return 2
        case .LBP:
            return 2
        case .LKR:
            return 2
        case .LRD:
            return 2
        case .LSL:
            return 2
        case .LYD:
            return 3
        case .MAD:
            return 2
        case .MDL:
            return 2
        case .MGA:
            return 2
        case .MKD:
            return 2
        case .MMK:
            return 2
        case .MNT:
            return 2
        case .MOP:
            return 2
        case .MRU:
            return 2
        case .MUR:
            return 2
        case .MVR:
            return 2
        case .MWK:
            return 2
        case .MXN:
            return 2
        case .MXV:
            return 2
        case .MYR:
            return 2
        case .MZN:
            return 2
        case .NAD:
            return 2
        case .NGN:
            return 2
        case .NIO:
            return 2
        case .NOK:
            return 2
        case .NPR:
            return 2
        case .NZD:
            return 2
        case .OMR:
            return 3
        case .PAB:
            return 2
        case .PEN:
            return 2
        case .PGK:
            return 2
        case .PHP:
            return 2
        case .PKR:
            return 2
        case .PLN:
            return 2
        case .PYG:
            return 0
        case .QAR:
            return 2
        case .RON:
            return 2
        case .RSD:
            return 2
        case .RUB:
            return 2
        case .RWF:
            return 0
        case .SAR:
            return 2
        case .SBD:
            return 2
        case .SCR:
            return 2
        case .SDG:
            return 2
        case .SEK:
            return 2
        case .SGD:
            return 2
        case .SHP:
            return 2
        case .SLL:
            return 2
        case .SOS:
            return 2
        case .SRD:
            return 2
        case .SSP:
            return 2
        case .STN:
            return 2
        case .SVC:
            return 2
        case .SYP:
            return 2
        case .SZL:
            return 2
        case .THB:
            return 2
        case .TJS:
            return 2
        case .TMT:
            return 2
        case .TND:
            return 3
        case .TOP:
            return 2
        case .TRY:
            return 2
        case .TTD:
            return 2
        case .TWD:
            return 2
        case .TZS:
            return 2
        case .UAH:
            return 2
        case .UGX:
            return 0
        case .USD:
            return 2
        case .UYI:
            return 0
        case .UYU:
            return 2
        case .UZS:
            return 2
        case .VEF:
            return 2
        case .VND:
            return 0
        case .VUV:
            return 0
        case .WST:
            return 2
        case .XCD:
            return 2
        case .YER:
            return 2
        case .ZAR:
            return 2
        case .ZMW:
            return 2
        case .ZWL:
            return 2
        case .XTS:
            return 0
        case .XXX:
            return 0
        }
    }

    public static func currencyFromCode(_ code: String) -> CurrencyType {
        guard let result = CurrencyType(rawValue: code) else {
            preconditionFailure("Currency code parameter \(code) does not match raw value in CurrencyType")
        }
        return result
    }

    public static func currencyFromLocale(_ locale: Locale) -> CurrencyType {
        guard let currencyCode = locale.currencyCode else {
            preconditionFailure("Locale \(locale) does not have a currency code associated with it.")
        }
        return try CurrencyType.currencyFromCode(currencyCode)
    }

    public static func currencyForDefaultLocale() -> CurrencyType {
        return try currencyFromLocale(Locale.current)
    }

    /**
     Formats the decimal as a currency for the locale specified.
    */
    public static func formatAmount(_ amount: Decimal, withLocale locale: Locale) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        return formatter.string(from: NSDecimalNumber(decimal: amount))
    }

    /**
     Formats the decimal as a currency for the current locale.
    */
    public static func formatWithCurrentLocaleAmount(_ amount: Decimal) -> String? {
        return CurrencyType.formatAmount(amount, withLocale: Locale.current)
    }
}
