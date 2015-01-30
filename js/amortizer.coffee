class Amortizer

  constructor: (@years, @loanAmount, @interest, @startDate) ->
    @numPayments = @years * 12
    @monthlyPayment = @calculateMonthlyPayment()
    @totalPayment = @monthlyPayment * @numPayments
    @totalInterest = @totalPayment - @loanAmount

  calculateMonthlyPayment: ->
    monthlyInterest = @interest / 12
    (@loanAmount * monthlyInterest * Math.pow(1 + monthlyInterest, @numPayments)) / (Math.pow(1 + monthlyInterest, @numPayments) - 1)

  paymentForBalance: (currentBalance) ->
    interestPmt = (@interest / 12) * currentBalance
    {
      interestPmt: interestPmt
      principalPmt: @monthlyPayment - interestPmt
      balance: currentBalance - (@monthlyPayment - ((@interest / 12) * currentBalance))
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

      html += "<tr>"
      html += "<td>#{date.format("MMM YYYY")}</td>"
      html += "<td>#{Amortizer.$(row.interestPmt)}</td>"
      html += "<td>#{Amortizer.$(row.principalPmt)}</td>"
      html += "<td>#{Amortizer.$(row.balance)}</td>"
      html += "</tr>"

      yearTotals.interestPmt += row.interestPmt
      yearTotals.principalPmt += row.principalPmt
      yearTotals.balance += row.balance

      date = date.add(1, 'months')
      # summary row if year changed
      if date.format("YYYY") != yearTotals.year
        html += "<tr class=\"year-summary\">"
        html += "<th>#{yearTotals.year}</th>"
        html += "<th>#{Amortizer.$(yearTotals.interestPmt)}</th>"
        html += "<th>#{Amortizer.$(yearTotals.principalPmt)}</th>"
        html += "<th>#{Amortizer.$(row.balance)}</th>"
        html += "</tr>"

      yearTotals = Amortizer.emptyRow()
      yearTotals.year = date.format("YYYY")

      currentBalance = row.balance

    html