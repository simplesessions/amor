$(document).foundation()



maskCurrencyInput = ->
  this.value = parseFloat(this.value.replace(/,/g, ""))
                    .toFixed(2)
                    .toString()
                    .replace(/\B(?=(\d{3})+(?!\d))/g, ",")

$('.currency').on('blur', maskCurrencyInput)