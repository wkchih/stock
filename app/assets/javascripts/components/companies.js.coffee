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
        id: 'chart-1'
        className: 'chart'
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
#        new Chartkick.LineChart("chart-1", data.prices, {"discrete": true, "min": data.price_min*0.99, "max": data.price_max*1.01})
      error: (xhr, status, err) ->
        console.error(that.props.url, status, err.toString())