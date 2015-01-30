updateValues = (info) ->
  table = Amortizer.buildTable(info.startDate, info.years, info.loanAmount, info.interest)
  $('#amortization tbody').html(table)

  $('#summary-monthly-payment').html(Amortizer.$(info.monthlyPayment))
  $('#summary-total-payment').html(Amortizer.$(info.totalPayment))
  $('#summary-total-interest').html(Amortizer.$(info.totalInterest))
  $('#summary-pay-off-date').html(info.startDate.subtract(1, 'months').format("MMM YYYY"))
  $('.num-payments').html(info.years * 12)

$('#info').on 'submit', (e) ->
  e.preventDefault()
  info = {}
  info.years = parseInt($('#input-term').val())
  info.loanAmount = parseFloat($('#input-loan-amount').val())
  info.interest = parseFloat($('#input-interest').val()) / 100
  info.monthlyPayment = Amortizer.monthlyPayment(info.years, info.loanAmount, info.interest)
  info.totalPayment = info.monthlyPayment * info.years * 12
  info.totalInterest = info.totalPayment - info.loanAmount
  info.startDate = moment("#{$('#input-start-date-year').val()} #{$('#input-start-date-month').val()}")
  updateValues(info)