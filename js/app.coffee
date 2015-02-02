am = new Amortizer()
am.payExtra('2015 12', 10000)
am.payExtra('2016 12', 10000)
am.payExtra('2017 12', 10000)
am.payExtra('2018 12', 10000)
am.payExtra('2019 12', 10000)
am.payExtra('2020 12', 10000)
am.payExtra('2021 12', 10000)
am.payExtra('2022 12', 10000)

updateValues = (am) ->
  $('#amortization .body').html(am.buildTable())
  $('#summary-monthly-payment').html(Amortizer.$(am.monthlyPayment))
  $('#summary-total-payment').html(Amortizer.$(am.totalPayment))
  $('#summary-total-interest').html(Amortizer.$(am.totalInterest))
  $('#summary-pay-off-date').html(am.startDate.subtract(1, 'months').format("MMM YYYY"))
  $('.num-payments').html(am.numPayments)

$('#info').on 'submit', (e) ->
  e.preventDefault()
  am.update(parseInt($('#input-term').val()),
            parseFloat($('#input-loan-amount').val()),
            parseFloat($('#input-interest').val()) / 100,
            moment("#{$('#input-start-date-year').val()} #{$('#input-start-date-month').val()}"))
  updateValues(am)