class SubscriptionsController < ApplicationController
  def create
    session = Stripe::Checkout::Session.create(stripe_checkout_params)

    redirect_to session.url, allow_other_host: true
  end

  private

  def stripe_checkout_params
    stripe_params = {
      payment_method_types: [ "card" ],
      mode: "subscription",
      line_items: [
        {
          price: "price_1QtpZtRtL7jbbjcR58xp9FcU",
          quantity: 1
        }
      ],
      success_url: root_url,
      cancel_url: root_url
    }

    if current_user.stripe_customer_id.present?
      stripe_params[:customer] = current_user.stripe_customer_id
    else
      stripe_params[:customer_email] = current_user.email_address
    end

    stripe_params
  end
end
