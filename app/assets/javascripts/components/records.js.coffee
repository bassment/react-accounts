@Records = React.createClass
  getInitialState: ->
    records: @props.data

  getDefaultProps: ->
    records: []

  addRecord: (record) ->
    records = @state.records.slice()
    records.push record
    @setState records: records

  credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) -> prev + parseFloat(curr.amount)), 0

  debits: ->
    credits = @state.records.filter (val) -> val.amount < 0
    credits.reduce ((prev, curr) -> prev + parseFloat(curr.amount)), 0

  balance: ->
    @credits() + @debits()

  deleteRecord: (record) ->
    records = @state.records.slice()
    index = records.indexOf record
    records.splice index, 1
    @replaceState records: records

  updateRecord: (record, data) ->
    records = @state.records.slice()
    index = records.indexOf record
    records.splice index, 1, data
    @replaceState records: records

  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Records'
      React.DOM.div
        className: 'row'
        React.createElement AmmountBox, type: 'success', amount: @credits(), text: 'Credit'
        React.createElement AmmountBox, type: 'danger', amount: @debits(), text: 'Debit'
        React.createElement AmmountBox, type: 'info', amount: @balance(), text: 'Balance'
      React.createElement RecordForm, handleNewRecord: @addRecord
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Amount'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for record in @state.records
            React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord