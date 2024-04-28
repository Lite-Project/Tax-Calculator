# Tax Calculator
Ready for a quick peek at your potential tax refund? Our calculator provides estimates to give you a ballpark figure—because let's face it, tax season can be unpredictable. Get a rough idea of what you might receive without the hassle of waiting. Take the uncertainty out of your finances today!

 Use this calculator to get a close estimate on tax info. 

# How to use
1. Download the "Tax Calculator.ps1"
2. Run the script
3. Use it.

# Tips for use
>[!WARNING]
>Does not consider student loans or personally filed IRD refund
>Differences may arise due to rounding, and Gross Taxable Income including both Income and Bank Interest.

It is recommended that you collect your Gross Taxable Income and Paid Taxes from [IRD](https://ird.govt.nz/) for more accurate results.

### ACC
Enter your correct ACC earners' levy rates


1 April 2024 to 31 March 2025 = 1.60%


1 April 2023 to 31 March 2024 = 1.53%


1 April 2022 to 31 March 2023 = 1.46%


1 April 2021 to 31 March 2022 = 1.39%
```ps
$ACC = 1.46
```
This is an example for 1 April 2022 to 31 March 2023 tax year. (This is done on Line 8)


Information collected from [ACC IRD](https://www.ird.govt.nz/income-tax/income-tax-for-individuals/acc-clients-and-carers/acc-earners-levy-rates)

### KiwiSaver Scheme
Adjust your KiwiSaver percentage to suit your needs. The default 3% is set because employers match this minimum, ensuring minimal impact on your post-tax income. Contributing more than 3% may affect your income unless matched by your employer.
```ps
$kiwi = 4
```
 This is an example for Kiwisaver scheme is 4% (This is done on Line 9)


