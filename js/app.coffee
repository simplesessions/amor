am = new Amortizer()
info = {}

updateValues = (info) ->
  table = am.buildTable(info.startDate)
  $('#amortization tbody').html(table)

  $('#summary-monthly-payment').html(Amortizer.$(info.monthlyPayment))
  $('#summary-total-payment').html(Amortizer.$(info.totalPayment))
  $('#summary-total-interest').html(Amortizer.$(info.totalInterest))
  $('#summary-pay-off-date').html(info.startDate.subtract(1, 'months').format("MMM YYYY"))
  $('.num-payments').html(info.years * 12)

$('#info').on 'submit', (e) ->
  e.preventDefault()
  am.years = info.years = parseInt($('#input-term').val())
  am.loanAmount = info.loanAmount = parseFloat($('#input-loan-amount').val())
  am.interest = parseFloat($('#input-interest').val())
  info.interest = am.interest / 100
  info.monthlyPayment = am.monthlyPayment()
  info.totalPayment = info.monthlyPayment * info.years * 12
  info.totalInterest = info.totalPayment - info.loanAmount
  info.startDate = moment("#{$('#input-start-date-year').val()} #{$('#input-start-date-month').val()}")
  updateValues(info)