var am,updateValues;am=null,updateValues=function(t){var a,m;return a=t.buildTable(),$("#amortization tbody").html(a),m=t.monthlyPayment*t.years*12,$("#summary-monthly-payment").html(Amortizer.$(t.monthlyPayment)),$("#summary-total-payment").html(Amortizer.$(m)),$("#summary-total-interest").html(Amortizer.$(m-t.loanAmount)),$("#summary-pay-off-date").html(t.startDate.subtract(1,"months").format("MMM YYYY")),$(".num-payments").html(12*t.years)},$("#info").on("submit",function(t){return t.preventDefault(),am=new Amortizer(parseInt($("#input-term").val()),parseFloat($("#input-loan-amount").val()),parseFloat($("#input-interest").val())/100,moment(""+$("#input-start-date-year").val()+" "+$("#input-start-date-month").val())),updateValues(am)});
//# sourceMappingURL=./app.js.map