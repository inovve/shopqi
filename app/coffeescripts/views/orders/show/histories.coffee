App.Views.Order.Show.Histories = Backbone.View.extend
  el: '#order-history-table'

  initialize: ->
    this.render()

  render: ->
    #按日期分组 {date: [history]}
    histories = {}
    _(App.order.get('histories')).each (history) ->
      created_at = new Date(history.created_at)
      date = "#{created_at.getFullYear()}-#{created_at.getMonth()}-#{created_at.getDate()}"
      histories[date] = [] unless histories[date]
      history.created_at = "#{created_at.getHours()}:#{created_at.getMinutes()}"
      histories[date].push history

    Handlebars.registerHelper 'loop', (block) ->
      _(this).map (histories, created_at) ->
        attr = created_at: created_at, histories: histories
        block(attr)
      .join('')

    template = Handlebars.compile $('#order-history-table-item').html()
    $(@el).html template histories
