import React, { Component } from 'react'
import DataInput from '../components/data-input'
const sampleImage = require('../static/images/sample.png')

class Index extends Component {
  render () {
    return (
      <div>
        <h1>Amortizer</h1>
        <DataInput/>
      </div>
    )
  }
}

export default Index
