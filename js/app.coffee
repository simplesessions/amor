am = null

updateValues = (am) ->
  table = am.buildTable()
  $('#amortization tbody').html(table)

  totalPayment = am.monthlyPayment * am.years * 12
  $('#summary-monthly-payment').html(Amortizer.$(am.monthlyPayment))
  $('#summary-total-payment').html(Amortizer.$(totalPayment))
  $('#summary-total-interest').html(Amortizer.$(totalPayment - am.loanAmount))
  $('#summary-pay-off-date').html(am.startDate.subtract(1, 'months').format("MMM YYYY"))
  $('.num-payments').html(am.years * 12)

$('#info').on 'submit', (e) ->
  e.preventDefault()
  am = new Amortizer(parseInt($('#input-term').val()),
                     parseFloat($('#input-loan-amount').val()),
                     parseFloat($('#input-interest').val()) / 100,
                     moment("#{$('#input-start-date-year').val()} #{$('#input-start-date-month').val()}"))
  updateValues(am)