$taxBrackets = @{
    14000   = 0.105
    48000   = 0.175
    70000   = 0.300
    180000  = 0.330
    180001  = 0.390
}
$ACCT = 1.53 #Default 1.53 for 1.53% 1 April 2023 to 31 March 2024 
$kiwi = 3 #Default 3 for 3%

$ACCT = $ACCT * 0.01
$kiwi = $kiwi * 0.01

#Calculates IETC
function IETC {
    param(
        [double]$income
    )
    if (($income -ge 24000) -and ($income -le 44000)) {
        return 520
    } elseif (($income -ge 44001) -and ($income -le 48000)) {
        $t = 520 - (($income - 44000) * 0.13 )
        return $t
    } else {
        return 0
    }
}

# Function to calculate tax based on income for New Zealand
function CalculateTaxNZ {
    param(
        [double]$income
    )

    $tax = 0
    $remainingIncome = $income

    foreach ($bracket in ($taxBrackets.GetEnumerator() | Sort-Object Name)) {
        $bracketIncome = [double]$bracket.Key
        $bracketRate = [double]$bracket.Value

        if ($remainingIncome -gt 0) {
            if ($remainingIncome -ge $bracketIncome) {
                $taxableIncome = $bracketIncome - $previousBracket
                $tax += $taxableIncome * $bracketRate
                $remainingIncome -= $taxableIncome
                $previousBracket = $bracketIncome
            } else {
                $tax += $remainingIncome * $bracketRate
                $remainingIncome = 0
            }
        } else {
            break
        }
    }

    return $tax
}

while ($true) {
    cls
    $incomeNZ = Read-Host "Gross Taxable Income"
    $pretax = Read-Host "Taxes Paid"
    if (([double]::TryParse($incomeNZ, [ref]$null)) -and ([double]::TryParse($pretax, [ref]$null))) {
        $ACC = ([double]$incomeNZ * $ACCT).ToString("N2")
        $taxNZ = CalculateTaxNZ -income $incomeNZ
        $IETC = IETC -income $incomeNZ
        $KiwiPT = ([double]$incomeNZ * $kiwi).ToString("N2")
        if ($kiwi -gt 0.03) {
            $kiwiT = [double]$incomeNZ * ($kiwi - 0.03)
        } else {$KiwiT = $KiwiPT}
        $AT = ($incomeNZ - ($taxNZ + $ACC + $kiwiT)).ToString("N2")
        $TC = ([double]$pretax - $ACC).ToString("N2")
        $TR = ($TC - ($taxNZ - $IETC)).ToString("N2")
        Write-Output @"
For an income of $incomeNZ NZD
PAYE: $($taxNZ.ToString("N2")) NZD
ACC: $ACC NZD
Kiwi Saver: $KiwiPT NZD
After Tax: $AT NZD
Tax Credits: $TC NZD
Tax Refund: $TR NZD
"@
        Write-Warning "These are all Estimates."
        Read-Host " "
    } else {
        Write-Warning "Invalid Number"
        Read-Host " "
    }
}