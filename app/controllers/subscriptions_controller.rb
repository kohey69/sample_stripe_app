class SubscriptionsController < ApplicationController
  def create
    session = Stripe::Checkout::Session.create(
      {
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
    )

    redirect_to session.url, allow_other_host: true
  end
end
