import React, { Component } from 'react'
const sampleImage = require('../static/images/sample.png')

class Index extends Component {
  render () {
    return (
      <div>
        <h1>Welcome to next.js!</h1>
        <img src={sampleImage} alt="Sample Image"/>
      </div>
    )
  }
}

export default Index
