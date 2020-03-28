Sources/Accounting/CurrencyType.swift : Sources/iso4217.csv

%.swift: %.swift.gyb
	@gyb --line-directive '' -o $@ $<

.PHONY:
clean:
	@rm Sources/Accounting/CurrencyType.swift
