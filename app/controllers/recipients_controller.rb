class RecipientsController < ApplicationController


  def index
    if search_params[:search_filter].present?
      @nfces = search
    else
      @nfces = []
    end
  end

  private

  def search
    cnpj = search_params[:search_filter].gsub(/\D/, '')
    recipient_cnpj = Recipient.arel_table[:cnpj]
    current_customer.nfces.joins(:recipient).where(recipient_cnpj.eq(cnpj))
  end

  def search_params
    params.permit(:search_filter)
  end


end
