import React, { Component } from 'react'

export default class NumberField extends Component {
  render () {
    return (
      <div className="field field__number">
        <label className="label">
          <div className="label__text">{this.props.labelText}</div>
          <input
            type="number"
            name={this.props.fieldName}
            placeholder={this.props.placeholder}
          />
        </label>
      </div>
    )
  }
}
