class Amortization

  constructor: (@interest, @loanAmount, @years) ->
    calculateMonthlyPayment()

  calculateMonthlyPayment: ->
    numPayments = @years*12
    monthlyInterest = @interest/12
    @monthlyPayment = (@interest *loanAmount * Math.pow(1 + monthlyInterest, numPayments)) / (Math.pow(1 + monthlyInterest, numPayments) - 1)
    @totalCost = @monthlyPayment*numPayments

