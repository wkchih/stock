@Companies = React.createClass
  getInitialState: ->
    companies: @props.data
  getDefaultProps: ->
    companies: []
  componentDidUpdate: ->
    new Chartkick.LineChart("chart-1", @state.prices, {"discrete": true, "min": @state.price_min*0.99, "max": @state.price_max*1.01})
  render: ->
    React.DOM.div
      className: 'form-group'
    React.DOM.div
      className: 'companies'
      React.DOM.h2
        className: 'name'
        'Select Company'
      React.DOM.select
        className: 'company-select'
        onChange: @handleChange
        React.DOM.option {key: null}
        for company in @state.companies
          React.DOM.option {key: company.id, value: company.id}, company.name
      if @state.company
        React.DOM.h2
          id: 'company-name'
          @state.company.name + ' (' + @state.company.symbol + ')'
        React.DOM.div
          className: 'div'
          React.DOM.input
            id: 'add-input'
            className: 'input'
          React.DOM.button
            id: 'add-submit'
            onClick: @handleAdd
            className: 'submit'
            'Add value'

      React.DOM.div
        id: 'chart-1'
        className: 'chart'

  handleAdd: (e) ->
    that = @
    price = $('#add-input').val()
    company_id = $('.company-select').val()
    $.ajax
      url: '/companies/' + company_id + '/prices.json',
      type: 'POST'
      data: {price: price}
      success: (data) ->
        $.extend(that.state.prices, data)
        that.setState({prices: that.state.prices})
        console.log(that.setState.prices)
      error: (xhr, status) ->
        console.log(xhr.responseText)

  handleChange: (e) ->
    that = @
    company_id = e.target.value
    if(company_id == '')
      @setState({prices:[], company:null, price_min:0, price_max:1 })
      return
    $.ajax
      url: '/companies/' + company_id + '.json',
      dataType: 'json',
      cache: false,
      success: (data) ->
        that.setState({prices: data.prices, company: data.company, price_min: data.price_min, price_max: data.price_max})
      error: (xhr, status, err) ->
        console.error(that.props.url, status, err.toString())
