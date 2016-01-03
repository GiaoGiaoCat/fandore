$("#<%= dom_id(@order)%>").before("<%= j render(partial: 'order', object: @order) %>").remove();
