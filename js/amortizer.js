var Amortizer,AmortizerRenderer;Amortizer=function(){function t(t,r,e,a){this.years=t,this.loanAmount=r,this.interest=e,this.startDate=a,this.extraPrincipalPayments=[],this.update(this.years,this.loanAmount,this.interest,this.startDate)}return t.prototype.update=function(t,r,e,a){return this.years=t,this.loanAmount=r,this.interest=e,this.startDate=a,this.stateDate=moment(this.stateDate),this.numPayments=12*this.years,this.monthlyPayment=this.calculateMonthlyPayment(),this.totalPayment=this.monthlyPayment*this.numPayments,this.totalInterest=this.totalPayment-this.loanAmount},t.prototype.payExtra=function(t,r){var e;return t=moment(t).format("YYYY MM"),e=parseFloat(r),t in this.extraPrincipalPayments?this.extraPrincipalPayments[t].push(e):this.extraPrincipalPayments[t]=[e]},t.prototype.calculateMonthlyPayment=function(){var t;return t=this.interest/12,this.loanAmount*t*Math.pow(1+t,this.numPayments)/(Math.pow(1+t,this.numPayments)-1)},t.prototype.paymentForBalance=function(t){var r,e,a;return e=this.interest/12*t,a=this.monthlyPayment-e,a>=t?(a=t,r=0):r=t-(this.monthlyPayment-this.interest/12*t),{interestPmt:e,principalPmt:a,balance:r}},t.$=function(t){return accounting.formatMoney(Math.round(100*t)/100)},t.emptyRow=function(){return{year:"undefined",interestPmt:0,principalPmt:0,balance:0}},t.prototype.buildTable=function(){var r,e,a,n,i,o,s,m,h,u,y,l;for(n="",a=this.startDate,i=12*this.years,e=this.loanAmount,m=t.emptyRow(),m.year=this.startDate.format("YYYY"),o=h=0;i>=0?i>h:h>i;o=i>=0?++h:--h){if(s=this.paymentForBalance(e),e=s.balance,n+=AmortizerRenderer.buildStandardRow(a,s),a.format("YYYY MM")in this.extraPrincipalPayments)for(l=this.extraPrincipalPayments[a.format("YYYY MM")],u=0,y=l.length;y>u;u++)r=l[u],e-=r,n+=AmortizerRenderer.buildExtraPaymentRow(a,r,e);if(m.interestPmt+=s.interestPmt,m.principalPmt+=s.principalPmt,m.balance+=e,a=a.add(1,"months"),a.format("YYYY")!==m.year&&(n+=AmortizerRenderer.buildYearSummaryRow(m.year,m.interestPmt,m.principalPmt,e),m=t.emptyRow(),m.year=a.format("YYYY")),0===e)break}return n},t}(),AmortizerRenderer=function(){function t(){}return t.buildStandardRow=function(t,r){var e;return e="<tr>",e+="<td>"+t.format("MMM YYYY")+"</td>",e+="<td>"+Amortizer.$(r.interestPmt)+"</td>",e+="<td>"+Amortizer.$(r.principalPmt)+"</td>",e+="<td>"+Amortizer.$(r.balance)+"</td>",e+="</tr>"},t.buildExtraPaymentRow=function(t,r,e){var a;return a='<tr class="extra">',a+="<td>"+t.format("MMM YYYY")+" +</td>",a+="<td>&ndash;</td>",a+="<td>(+) "+Amortizer.$(r)+"</td>",a+="<td>"+Amortizer.$(e)+"</td>",a+="</tr>"},t.buildYearSummaryRow=function(t,r,e,a){var n;return n='<tr class="year-summary">',n+="<th>"+t+"</th>",n+="<th>"+Amortizer.$(r)+"</th>",n+="<th>"+Amortizer.$(e)+"</th>",n+="<th>"+Amortizer.$(a)+"</th>",n+="</tr>"},t}();
//# sourceMappingURL=./amortizer.js.map