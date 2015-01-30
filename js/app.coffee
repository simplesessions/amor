am = null

updateValues = (am) ->
  $('#amortization tbody').html(am.buildTable())
  $('#summary-monthly-payment').html(Amortizer.$(am.monthlyPayment))
  $('#summary-total-payment').html(Amortizer.$(am.totalPayment))
  $('#summary-total-interest').html(Amortizer.$(am.totalInterest))
  $('#summary-pay-off-date').html(am.startDate.subtract(1, 'months').format("MMM YYYY"))
  $('.num-payments').html(am.numPayments)

$('#info').on 'submit', (e) ->
  e.preventDefault()
  am = new Amortizer(parseInt($('#input-term').val()),
                     parseFloat($('#input-loan-amount').val()),
                     parseFloat($('#input-interest').val()) / 100,
                     moment("#{$('#input-start-date-year').val()} #{$('#input-start-date-month').val()}"))
  updateValues(am)