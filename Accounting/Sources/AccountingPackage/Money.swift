import Foundation

enum MoneyError: Error {
    case attemptingToAddAmountsOfDifferentCurrencies
    case attemptingToSubtractAmountsOfDifferentCurrencies
    case instantiatedWIthInvalidCurrencyCode
}

/**
 An amount of money in a given currency.
 */
public struct Money: Hashable {
    public static var zero = Money(Decimal.zero, .XXX)
    public static var invalid = Money(Decimal.nan, .XXX)
    
    /// The amount of money.
    public var amount: Decimal
    
    /// The currency.
    public let currency: CurrencyType
    
    public var isInvalid: Bool {
        return self == Money.invalid
    }
    
    /// Returns a string formatted for the default locale.
    public var formatForDefaultLocale: String? {
        return CurrencyType.formatWithCurrentLocaleAmount(self.amount)
    }
    
    public var isPositive: Bool {
        return amount > 0
    }
    
    public var isNegative: Bool {
        return !self.isPositive
    }
    
     /// A monetary amount rounded to the number of places of the minor currency unit.
    public var rounded: Money {
        var approximate = self.amount
        var rounded = Decimal()
        NSDecimalRound(&rounded, &approximate, self.currency.minorUnit, .bankers)
        
        return Money(rounded, self.currency)
    }
    
    /// Created a Money from a Money
    public init(_ money: Money) {
        self.amount = money.amount
        self.currency = money.currency
    }
    
    /// Creates an amount of money with a given decimal number and currency
    public init(_ amount: Decimal, _ currency: CurrencyType) {
        self.amount = amount
        self.currency = currency.self
    }

    /// Creates an amount of money with a given decimal number and currency code
    public init(_ amount: Decimal, _ currencyCode: String) {
        self.amount = amount
        let currency = CurrencyType.currencyFromCode(currencyCode)
        self.currency = currency
    }
    
    public init(_ amount: Decimal) {
        self.init(amount, CurrencyType.currencyForDefaultLocale())
    }

    public init(_ amount: Double) {
        self.init(Decimal(amount), CurrencyType.currencyForDefaultLocale())
    }
    
    public func formatForLocale(_ locale: Locale) -> String? {
        return CurrencyType.formatAmount(self.amount, withLocale: locale)
    }
    
    public static func == (lhs: Money, rhs: Money) -> Bool {
        return (lhs.amount == rhs.amount) && type(of: lhs.currency) == type(of: rhs.currency)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.amount)
        hasher.combine(self.currency.code)
    }
}

/// A type that can be compared using the relational operators <, <=, >=, and >.
extension Money: Comparable {
    public static func < (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount < rhs.amount && type(of: lhs.currency) == type(of: rhs.currency)
    }
}

/// Represents Money instance as amount(currency code) i.e. 125(USD)
extension Money: CustomStringConvertible {
    public var description: String {
        return "\(self.amount)(\(self.currency))"
    }
}

/// A type that can be represented as a string in a lossless, unambiguous way.
extension Money: LosslessStringConvertible {
    public init?(_ description: String) {
        let fields = description.split(whereSeparator: { $0 == "(" || $0 == ")" })
        guard fields.count >= 1 else {
            return nil
        }
        guard let amount = Decimal(string: String(fields[0])) else {
            return nil
        }
        let currency: CurrencyType
        if fields.count >= 2 {
            currency = CurrencyType.currencyFromCode(String(fields[1]))
        } else {
            currency = CurrencyType.currencyForDefaultLocale()
        }
        self.init(amount, currency)
    }
}

extension Money: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(Decimal(integerLiteral: value))
    }
}

extension Money: ExpressibleByFloatLiteral {
    /**
     Creates a new value from the given floating-point literal.
     
     - Important: Swift floating-point literals are currently initialized using binary floating-point number type,
                  which cannot precisely express certain values. As a workaround, monetary amounts initialized
                  from a floating-point literal are rounded to the number of places of the minor currency unit.
                  To express a smaller fractional monetary amount, initialize from a string literal or decimal value instead.
     - Bug: See https://bugs.swift.org/browse/SR-920
    */
    public init(floatLiteral value: Double) {
        var approximate = Decimal(floatLiteral: value)
        var rounded = Decimal()
        NSDecimalRound(&rounded, &approximate, CurrencyType.currencyForDefaultLocale().minorUnit, .bankers)
        self.init(rounded)
    }
}

/// A type that can be initialized with a string literal.
extension Money: ExpressibleByStringLiteral {
    public init(unicodeScalarLiteral value: Unicode.Scalar) {
        self.init(stringLiteral: String(value))
    }

    public init(extendedGraphemeClusterLiteral value: Character) {
        self.init(stringLiteral: String(value))
    }

    public init(stringLiteral value: String) {
        self.init(value)!
    }
}

/// A type with values that support addition and subtraction.
extension Money: AdditiveArithmetic {
    /// Subtracts one monetary amount from another.
    public static func -= (lhs: inout Money, rhs: Money) {
        if (type(of: lhs.currency) == type(of: rhs.currency)) {
            lhs.amount -= rhs.amount
        } else {
            lhs.amount = Decimal.nan
        }
    }
    
    /// The sum of two monetary amounts.
    public static func + (lhs: Money, rhs: Money) -> Money {
        guard type(of: lhs.currency) == type(of: rhs.currency) else {
            return Money.invalid
        }
        return Money(lhs.amount + rhs.amount, lhs.currency)
    }

    /// Adds one monetary amount to another.
    public static func += (lhs: inout Money, rhs: Money) {
        if (type(of: lhs.currency) == type(of: rhs.currency)) {
            lhs.amount += rhs.amount
        } else {
            lhs.amount = Decimal.nan
        }
    }

    /// The difference between two monetary amounts.
    public static func - (lhs: Money, rhs: Money) -> Money {
        guard type(of: lhs.currency) == type(of: rhs.currency) else {
            return Money.invalid
        }
        return Money(lhs.amount - rhs.amount, lhs.currency)
    }
}

/// Multiplication operators
extension Money {
    /// The product of a monetary amount and a scalar value.
    public static func * (lhs: Money, rhs: Decimal) -> Money {
        return Money(lhs.amount * rhs, lhs.currency)
    }

    /**
        The product of a monetary amount and a scalar value.
     
        - Important: Multiplying a monetary amount by a floating-point number
                     results in an amount rounded to the number of places
                     of the minor currency unit.
                     To produce a smaller fractional monetary amount,
                     multiply by a `Decimal` value instead.
     */
    public static func * (lhs: Money, rhs: Double) -> Money {
        return (lhs * Decimal(rhs)).rounded
    }

    /// The product of a monetary amount and a scalar value.
    static func * (lhs: Money, rhs: Int) -> Money {
        return lhs * Decimal(rhs)
    }

    /// The product of a monetary amount and a scalar value.
    public static func * (lhs: Decimal, rhs: Money) -> Money {
        return rhs * lhs
    }

    /**
        The product of a monetary amount and a scalar value.
     
        - Important: Multiplying a monetary amount by a floating-point number results in an amount rounded to the number of places
                     of the minor currency unit.  To produce a smaller fractional monetary amount, multiply by a `Decimal` value instead.
     */
    public static func * (lhs: Double, rhs: Money) -> Money {
        return rhs * lhs
    }

    /// The product of a monetary amount and a scalar value.
    public static func * (lhs: Int, rhs: Money) -> Money {
        return rhs * lhs
    }

    /// Multiplies a monetary amount by a scalar value.
    public static func *= (lhs: inout Money, rhs: Decimal) {
        lhs.amount *= rhs
    }

    /**
        Multiplies a monetary amount by a scalar value.
     
        - Important: Multiplying a monetary amount by a floating-point number results in an amount rounded to the number of places
                     of the minor currency unit.  To produce a smaller fractional monetary amount, multiply by a `Decimal` value instead.
     */
    public static func *= (lhs: inout Money, rhs: Double) {
        lhs.amount = Money(lhs.amount * Decimal(rhs), lhs.currency).rounded.amount
    }

    /// Multiplies a monetary amount by a scalar value.
    public static func *= (lhs: inout Money, rhs: Int) {
        lhs.amount *= Decimal(rhs)
    }
}

/// Calculates the negative of a money amount.
extension Money {
    public static prefix func - (value: Money) -> Money {
        return Money(-value.amount, value.currency)
    }
}

/// A type that can convert itself into and out of an external representation.
extension Money: Codable {
    private enum CodingKeys: String, CodingKey {
        case amount
        case currencyCode
    }

    public init(from decoder: Decoder) throws {
        if let keyedContainer = try? decoder.container(keyedBy: CodingKeys.self) {
            let currencyCode = try keyedContainer.decode(String.self, forKey: .currencyCode)
            let currency = CurrencyType.currencyFromCode(currencyCode)
            self.currency = currency
            self.amount = try keyedContainer.decode(Decimal.self, forKey: .amount)
        } else if let singleValueContainer = try? decoder.singleValueContainer() {
            self.amount = try singleValueContainer.decode(Decimal.self)
            self.currency = CurrencyType.currencyForDefaultLocale()
        } else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Couldn't decode Money value")
            throw DecodingError.dataCorrupted(context)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var keyedContainer = encoder.container(keyedBy: CodingKeys.self)
        try keyedContainer.encode(self.amount, forKey: .amount)
        try keyedContainer.encode(self.currency.code, forKey: .currencyCode)
    }
}
