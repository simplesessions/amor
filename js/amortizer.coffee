class Amortizer

  constructor: (@years, @loanAmount, @interest, @startDate) ->
    @extraPrincipalPayments = []
    @update(@years, @loanAmount, @interest, @startDate)

  update: (@years, @loanAmount, @interest, @startDate) ->
    @stateDate = moment(@stateDate)
    @numPayments = @years * 12
    @monthlyPayment = @calculateMonthlyPayment()
    @totalPayment = @monthlyPayment * @numPayments
    @totalInterest = @totalPayment - @loanAmount

  payExtra: (date, amount) ->
    date = moment(date).format('YYYY MM')
    amt = parseFloat(amount)
    if date of @extraPrincipalPayments
      @extraPrincipalPayments[date].push amt
    else
      @extraPrincipalPayments[date] = [amt]

  calculateMonthlyPayment: ->
    monthlyInterest = @interest / 12
    (@loanAmount * monthlyInterest * Math.pow(1 + monthlyInterest, @numPayments)) / (Math.pow(1 + monthlyInterest, @numPayments) - 1)

  paymentForBalance: (currentBalance) ->
    interestPmt = (@interest / 12) * currentBalance
    principalPmt = @monthlyPayment - interestPmt
    if principalPmt >= currentBalance
      principalPmt = currentBalance
      balance = 0
    else
      balance = currentBalance - (@monthlyPayment - ((@interest / 12) * currentBalance))
    {
      interestPmt: interestPmt
      principalPmt: principalPmt
      balance: balance
    }

  @$: (val) ->
    accounting.formatMoney(Math.round(val * 100) / 100)

  @emptyRow: ->
    {
      year: 'undefined'
      interestPmt: 0
      principalPmt: 0
      balance: 0
    }

  buildTable: ->
    html = ''
    date = @startDate
    months = @years * 12
    currentBalance = @loanAmount
    yearTotals = Amortizer.emptyRow()
    yearTotals.year = @startDate.format("YYYY")

    for numMonth in [0...months]
      row = @paymentForBalance(currentBalance)
      currentBalance = row.balance
      html += AmortizerRenderer.buildStandardRow(date, row)

      # check for extra payments
      if date.format('YYYY MM') of @extraPrincipalPayments
        for amt in @extraPrincipalPayments[date.format('YYYY MM')]
          currentBalance -= amt
          html += AmortizerRenderer.buildExtraPaymentRow(date, amt, currentBalance)

      yearTotals.interestPmt += row.interestPmt
      yearTotals.principalPmt += row.principalPmt
      yearTotals.balance += currentBalance

      date = date.add(1, 'months')
      # summary row if year changed
      if date.format("YYYY") != yearTotals.year
        html += AmortizerRenderer.buildYearSummaryRow(yearTotals.year, yearTotals.interestPmt, yearTotals.principalPmt, currentBalance)
        yearTotals = Amortizer.emptyRow()
        yearTotals.year = date.format("YYYY")

      break if currentBalance == 0

    html

class AmortizerRenderer

  @buildStandardRow: (date, row) ->
    html  = "<tr>"
    html += "<td>#{date.format("MMM YYYY")}</td>"
    html += "<td>#{Amortizer.$(row.interestPmt)}</td>"
    html += "<td>#{Amortizer.$(row.principalPmt)}</td>"
    html += "<td>#{Amortizer.$(row.balance)}</td>"
    html += "</tr>"

  @buildExtraPaymentRow: (date, amount, currentBalance) ->
    html  = "<tr class=\"extra\">"
    html += "<td>#{date.format("MMM YYYY")} +</td>"
    html += "<td>&ndash;</td>"
    html += "<td>(+) #{Amortizer.$(amount)}</td>"
    html += "<td>#{Amortizer.$(currentBalance)}</td>"
    html += "</tr>"

  @buildYearSummaryRow: (year, interestPmt, principalPmt, currentBalance) ->
    html  = "<tr class=\"year-summary\">"
    html += "<th>#{year}</th>"
    html += "<th>#{Amortizer.$(interestPmt)}</th>"
    html += "<th>#{Amortizer.$(principalPmt)}</th>"
    html += "<th>#{Amortizer.$(currentBalance)}</th>"
    html += "</tr>"
