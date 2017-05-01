require "rails_helper"

describe SubscribersController do
  describe "Stripe webhooks hit system" do
    it "gets successful payment and marks user as paid" do
      user = Fabricate(:user)
      expect(user.membership_level).to eq("free")
      expect(user.stripeid).to eq("cus_AVUti38AGlyyVv")
      post :stripe_charge, {
        "id"=> "evt_1ABl6nI8HOATFuBIXmheKLAR",
        "object"=> "event",
        "api_version"=> "2016-03-07",
        "created"=> 1492955437,
        "data"=> {
          "object"=> {
            "id"=> "in_1AAfg6I8HOATFuBIeOuva42a",
            "object"=> "invoice",
            "amount_due"=> 999,
            "application_fee"=> nil,
            "attempt_count"=> 1,
            "attempted"=> true,
            "charge"=> "ch_1ABl6nI8HOATFuBInVrTH4No",
            "closed"=> true,
            "currency"=> "usd",
            "customer"=> "cus_AVUti38AGlyyVv",
            "date"=> 1492696234,
            "description"=> nil,
            "discount"=> nil,
            "ending_balance"=> 0,
            "forgiven"=> false,
            "lines"=> {
              "object"=> "list",
              "data"=> [
                {
                  "id"=> "sub_8foPL7HhFFcNdG",
                  "object"=> "line_item",
                  "amount"=> 999,
                  "currency"=> "usd",
                  "description"=> nil,
                  "discountable"=> true,
                  "livemode"=> false,
                  "metadata"=> {
                  },
                  "period"=> {
                    "start"=> 1492696181,
                    "end"=> 1495288181
                  },
                  "plan"=> {
                    "id"=> "base",
                    "object"=> "plan",
                    "amount"=> 999,
                    "created"=> 1466427110,
                    "currency"=> "usd",
                    "interval"=> "month",
                    "interval_count"=> 1,
                    "livemode"=> false,
                    "metadata"=> {
                    },
                    "name"=> "the base plan",
                    "statement_descriptor"=> nil,
                    "trial_period_days"=> nil
                  },
                  "proration"=> false,
                  "quantity"=> 1,
                  "subscription"=> nil,
                  "subscription_item"=> "si_18OSmXI8HOATFuBI4aJXEctI",
                  "type"=> "subscription"
                }
              ],
              "has_more"=> false,
              "total_count"=> 1,
              "url"=> "/v1/invoices/in_1AAfg6I8HOATFuBIeOuva42a/lines"
            },
            "livemode"=> false,
            "metadata"=> {
            },
            "next_payment_attempt"=> nil,
            "paid"=> true,
            "period_end"=> 1492696181,
            "period_start"=> 1490017781,
            "receipt_number"=> nil,
            "starting_balance"=> 0,
            "statement_descriptor"=> nil,
            "subscription"=> "sub_8foPL7HhFFcNdG",
            "subtotal"=> 999,
            "tax"=> nil,
            "tax_percent"=> nil,
            "total"=> 999,
            "webhooks_delivered_at"=> nil
          }
        },
        "livemode"=> false,
        "pending_webhooks"=> 1,
        "request"=> nil,
        "type"=> "invoice.payment_succeeded"
      }.to_json
      expect(user.reload.membership_level).to eq("paid");
    end

    it "gets unsuccessful payment and marks user as free" do
      user = Fabricate(:user, membership_level:"paid")
      expect(user.membership_level).to eq("paid")
      post :stripe_charge, {
        "id"=> "evt_1ABl6nI8HOATFuBIXmheKLAR",
        "object"=> "event",
        "api_version"=> "2016-03-07",
        "created"=> 1492955437,
        "data"=> {
          "object"=> {
            "id"=> "in_1AAfg6I8HOATFuBIeOuva42a",
            "object"=> "invoice",
            "amount_due"=> 999,
            "application_fee"=> nil,
            "attempt_count"=> 1,
            "attempted"=> true,
            "charge"=> "ch_1ABl6nI8HOATFuBInVrTH4No",
            "closed"=> true,
            "currency"=> "usd",
            "customer"=> "cus_AVUti38AGlyyVv",
            "date"=> 1492696234,
            "description"=> nil,
            "discount"=> nil,
            "ending_balance"=> 0,
            "forgiven"=> false,
            "lines"=> {
              "object"=> "list",
              "data"=> [
                {
                  "id"=> "sub_8foPL7HhFFcNdG",
                  "object"=> "line_item",
                  "amount"=> 999,
                  "currency"=> "usd",
                  "description"=> nil,
                  "discountable"=> true,
                  "livemode"=> false,
                  "metadata"=> {
                  },
                  "period"=> {
                    "start"=> 1492696181,
                    "end"=> 1495288181
                  },
                  "plan"=> {
                    "id"=> "base",
                    "object"=> "plan",
                    "amount"=> 999,
                    "created"=> 1466427110,
                    "currency"=> "usd",
                    "interval"=> "month",
                    "interval_count"=> 1,
                    "livemode"=> false,
                    "metadata"=> {
                    },
                    "name"=> "the base plan",
                    "statement_descriptor"=> nil,
                    "trial_period_days"=> nil
                  },
                  "proration"=> false,
                  "quantity"=> 1,
                  "subscription"=> nil,
                  "subscription_item"=> "si_18OSmXI8HOATFuBI4aJXEctI",
                  "type"=> "subscription"
                }
              ],
              "has_more"=> false,
              "total_count"=> 1,
              "url"=> "/v1/invoices/in_1AAfg6I8HOATFuBIeOuva42a/lines"
            },
            "livemode"=> false,
            "metadata"=> {
            },
            "next_payment_attempt"=> nil,
            "paid"=> true,
            "period_end"=> 1492696181,
            "period_start"=> 1490017781,
            "receipt_number"=> nil,
            "starting_balance"=> 0,
            "statement_descriptor"=> nil,
            "subscription"=> "sub_8foPL7HhFFcNdG",
            "subtotal"=> 999,
            "tax"=> nil,
            "tax_percent"=> nil,
            "total"=> 999,
            "webhooks_delivered_at"=> nil
          }
        },
        "livemode"=> false,
        "pending_webhooks"=> 1,
        "request"=> nil,
        "type"=> "invoice.payment_failed"
      }.to_json
      expect(user.reload.membership_level).to eq("free")
    end
  end
end
