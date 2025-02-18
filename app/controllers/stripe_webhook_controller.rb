class StripeWebhookController < ApplicationController
  allow_unauthenticated_access
  skip_before_action :verify_authenticity_token

  def checkout
    payload = request.body.read

    event = begin
      Stripe::Event.construct_from(
        JSON.parse(payload, symbolize_names: true)
      )
    rescue JSON::ParserError => e
      status :bad_request
      return
    end

    case event.type
    when "invoice.payment_succeeded"
      invoice = event.data.object

      user =  User.find_by!(email_address: invoice.customer_email)
      if invoice.customer.present?
        user.update!(stripe_customer_id: invoice.customer)
      end

      # TODO: 決済した情報をDBに登録する処理

      render json: { message: "success" }, status: :ok
    else
      render json: { message: "unhandled event" }, status: :ok
    end
  end
end
