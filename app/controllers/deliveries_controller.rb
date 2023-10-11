class DeliveriesController < ApplicationController
  before_action :authenticate_user!

  def mark_as_received
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)
    the_delivery.is_received = true
  
    if the_delivery.save
      redirect_to("/deliveries", { :notice => "Delivery marked as received."})
    else
      redirect_to("/deliveries", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end
  

  def index
    @list_of_waiting_deliveries = Delivery.where(is_received: false).order({ :created_at => :desc })
    @list_of_received_deliveries = Delivery.where(is_received: true).order({ :created_at => :desc })
    render({ :template => "deliveries/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_deliveries = Delivery.where({ :id => the_id })

    @the_delivery = matching_deliveries.at(0)

    render({ :template => "deliveries/show" })
  end


  def create
    the_delivery = Delivery.new
    the_delivery.description = params.fetch("query_description")
    the_delivery.supposed_to_arrive_on = params.fetch("query_supposed_to_arrive_on")
    the_delivery.details = params.fetch("query_details")
    the_delivery.user_id = params.fetch("query_user_id")
    the_delivery.is_received = params.fetch("query_is_received", false)

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries", { :notice => "Added to list" })
    else
      redirect_to("/deliveries", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.description = params.fetch("query_description")
    the_delivery.supposed_to_arrive_on = params.fetch("query_supposed_to_arrive_on")
    the_delivery.details = params.fetch("query_details")
    the_delivery.user_id = params.fetch("query_user_id")
    the_delivery.is_received = params.fetch("query_is_received", false)

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries/#{the_delivery.id}", { :notice => "Delivery updated successfully."} )
    else
      redirect_to("/deliveries/#{the_delivery.id}", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.destroy

    redirect_to("/deliveries", { :notice => "Delivery deleted successfully."} )
  end
end
