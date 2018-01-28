import React, { Component } from 'react'
import Calendar from 'react-calendar'
import NumberField from './number-field'

export default class DataInput extends Component {
  constructor (props) {
    super(props)
    this.state = { date: undefined }
  }

  onDateChange = date => this.setState({ date })

  render () {
    return (
      <div className="data-input">
        <NumberField labelText="Loan Amount" fieldName="amount" placeholder="How much?"/>
        <NumberField labelText="Term" fieldName="term" placeholder="How much?"/>
        <NumberField labelText="Interest Rate" fieldName="rate" placeholder="How much?"/>
        <Calendar
          onChange={this.onChange}
          value={this.state.date}
          maxDetail="month"
          minDetail="year"
        />
      </div>
    )
  }
}
