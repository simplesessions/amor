SampleInfo = {
  startDate: moment("2012 01")
  years: 30
  loanAmount: 324000
  interest: .04
}

updateValues = (info) ->
  table = Amortization.buildTable(info.startDate, info.years, info.loanAmount, info.interest)
  $('#amortization tbody').html(table)

  $('#summary-monthly-payment').html(Amortization.$(info.monthlyPayment))
  $('#summary-total-payment').html(Amortization.$(info.totalPayment))
  $('#summary-total-interest').html(Amortization.$(info.totalInterest))
  $('#summary-pay-off-date').html(info.startDate.subtract(1, 'months').format("MMM YYYY"))
  $('.num-payments').html(info.years * 12)

$('#info').on 'submit', (e) ->
  e.preventDefault()
  years = parseInt($('#input-term').val())
  loanAmount = parseFloat($('#input-loan-amount').val())
  interest = parseFloat($('#input-interest').val()) / 100
  monthlyPayment = Amortization.monthlyPayment(years, loanAmount, interest)
  totalPayment = monthlyPayment * years * 12
  totalInterest = totalPayment - loanAmount
  updateValues({
    monthlyPayment: monthlyPayment
    totalPayment: totalPayment
    totalInterest: totalInterest
    startDate: moment("#{$('#input-start-date-year').val()} #{$('#input-start-date-month').val()}")
    years: years
    loanAmount: loanAmount
    interest: interest
  })