require "rails_helper"

describe StripeController do

  describe "index" do
    let!(:paying_user) { Fabricate(:user, stripeid: "cus_123", membership_level: "free") }
    let!(:sub_running_out_user) { Fabricate(:user, stripeid: "cus_abc", membership_level: "paid") }
    
    let(:charge_succeeded_json)  {
       {
        created: 1326853478,
        livemode: false,
        id: "evt_00000000000000",
        type: "charge.succeeded",
        object: "event",
        request: "null",
        pending_webhooks: 1,
        api_version: "null",
        data: {
          object: {
            id: "ch_00000000000000",
            object: "charge",
            amount: 100,
            amount_refunded: 0,
            application: "null",
            application_fee: "null",
            balance_transaction: "txn_00000000000000",
            captured: false,
            created: 1501854777,
            currency: "usd",
            customer: paying_user.stripeid,
            description: "My First Test Charge (created for API docs)",
            destination: "null",
            dispute: "null",
            failure_code: "null",
            failure_message: "null",
            fraud_details: {
            },
            invoice: "null",
            livemode: false,
            metadata: {
            },
            on_behalf_of: "null",
            order: "null",
            outcome: "null",
            paid: true,
            receipt_email: "null",
            receipt_number: "null",
            refunded: false,
            refunds: {
              object: "list",
              data: [
              ],
              has_more: false,
              total_count: 0,
              url: "/v1/charges/ch_1An6EXI8HOATFuBIiQCB2zFQ/refunds"
            },
            review: "null",
            shipping: "null",
            source: {
              id: "card_00000000000000",
              object: "card",
              address_city: "null",
              address_country: "null",
              address_line1: "null",
              address_line1_check: "null",
              address_line2: "null",
              address_state: "null",
              address_zip: "null",
              address_zip_check: "null",
              brand: "Visa",
              country: "US",
              customer: "cus_00000000000000",
              cvc_check: "pass",
              dynamic_last4: "null",
              exp_month: 12,
              exp_year: 2031,
              fingerprint: "MQzk2nWyClMfPHmj",
              funding: "credit",
              last4: "4242",
              metadata: {
              },
              name: "lover@e.com",
              tokenization_method: "null"
            },
            source_transfer: "null",
            statement_descriptor: "null",
            status: "succeeded",
            transfer_group: "null"
          }
        }
      }
    }

    let(:delete_subscription) {
      {
        created: 1326853478,
        livemode: false,
        id: "evt_00000000000000",
        type: "customer.subscription.deleted",
        object: "event",
        request: "null",
        pending_webhooks: 1,
        api_version: "null",
        data: {
          object: {
            id: "sub_00000000000000",
            object: "subscription",
            application_fee_percent: "null",
            cancel_at_period_end: false,
            canceled_at: 1470649546,
            created: 1466757773,
            current_period_end: 1472028173,
            current_period_start: 1469349773,
            customer: "cus_abc",
            discount: "null",
            ended_at: 1501855061,
            items: {
              object: "list",
              data: [
                {
                  id: "si_18PptpI8HOATFuBIIoWqPGLU",
                  object: "subscription_item",
                  created: 1466757774,
                  metadata: {
                  },
                  plan: {
                    id: "base",
                    object: "plan",
                    amount: 999,
                    created: 1466427110,
                    currency: "usd",
                    interval: "month",
                    interval_count: 1,
                    livemode: false,
                    metadata: {
                    },
                    name: "the base plan",
                    statement_descriptor: "null",
                    trial_period_days: "null"
                  },
                  quantity: 1
                }
              ],
              has_more: false,
              total_count: 1,
              url: "/v1/subscription_items?subscription=sub_8hEMELe6PdwpWw"
            },
            livemode: false,
            metadata: {
            },
            plan: {
              id: "base_00000000000000",
              object: "plan",
              amount: 999,
              created: 1466427110,
              currency: "usd",
              interval: "month",
              interval_count: 1,
              livemode: false,
              metadata: {
              },
              name: "the base plan",
              statement_descriptor: "null",
              trial_period_days: "null"
            },
            quantity: 1,
            start: 1466757773,
            status: "canceled",
            tax_percent: "null",
            trial_end: "null",
            trial_start: "null"
          }
        }
      }
    }

    context "successful charge" do

      before do
        post :index, charge_succeeded_json
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it "adds a charge object" do     
        expect(Payment.count).to eq(1)
      end

      it "attached user to the payment" do
        expect(Payment.last.user).to eq(paying_user)
      end

      it "makes the user a paid member" do
        expect(paying_user.reload.membership_level).to eq("paid")
      end 

      it "sends an email to the user" do
        expect(ActionMailer::Base.deliveries.first.to).to eq([paying_user.email])
      end

      it "sends an email to the admin" do
        expect(ActionMailer::Base.deliveries.last.to).to eq([ENV['ADMIN_EMAIL']])
      end

    end # successful charge

    context "user subscription runs out" do
      before do
        post :index, delete_subscription
      end

       after do
        ActionMailer::Base.deliveries.clear
      end

      it "makes the user a free member" do
        expect(sub_running_out_user.reload.membership_level).to eq("free")
      end

      it "sends an email to the user" do
        expect(ActionMailer::Base.deliveries.first.to).to eq([sub_running_out_user.email])
      end 

      it "sends an email to the admin" do
        expect(ActionMailer::Base.deliveries.last.to).to eq([ENV['ADMIN_EMAIL']])
      end
    end #user subscription runs out

  end # index


end