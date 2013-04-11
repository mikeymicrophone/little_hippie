# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130411083928) do

  create_table "banners", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "caption"
  end

  create_table "body_style_categorizations", :force => true do |t|
    t.integer  "body_style_id"
    t.integer  "category_id"
    t.integer  "position"
    t.boolean  "active"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "body_style_categorizations", ["body_style_id"], :name => "index_body_style_categorizations_on_body_style_id"
  add_index "body_style_categorizations", ["category_id"], :name => "index_body_style_categorizations_on_category_id"

  create_table "body_style_product_features", :force => true do |t|
    t.integer  "body_style_id"
    t.integer  "product_color_id"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "body_style_product_features", ["body_style_id"], :name => "index_body_style_product_features_on_body_style_id"
  add_index "body_style_product_features", ["product_color_id"], :name => "index_body_style_product_features_on_product_color_id"

  create_table "body_style_sizes", :force => true do |t|
    t.integer  "body_style_id"
    t.integer  "size_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "position"
  end

  add_index "body_style_sizes", ["body_style_id"], :name => "index_body_style_sizes_on_body_style_id"
  add_index "body_style_sizes", ["size_id"], :name => "index_body_style_sizes_on_size_id"

  create_table "body_styles", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
    t.integer  "base_price"
    t.string   "image"
    t.integer  "xxl_price"
    t.integer  "xxxl_price"
  end

  create_table "bulletin_pairings", :force => true do |t|
    t.integer  "bulletin_id"
    t.integer  "content_page_id"
    t.integer  "position"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "bulletin_pairings", ["bulletin_id"], :name => "index_bulletin_pairings_on_bulletin_id"
  add_index "bulletin_pairings", ["content_page_id"], :name => "index_bulletin_pairings_on_content_page_id"

  create_table "bulletins", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "teaser"
  end

  create_table "business_managers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.boolean  "active"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "business_managers", ["email"], :name => "index_business_managers_on_email", :unique => true
  add_index "business_managers", ["reset_password_token"], :name => "index_business_managers_on_reset_password_token", :unique => true

  create_table "carts", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "status"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "shipping_address_id"
    t.string   "ip_address"
  end

  add_index "carts", ["customer_id"], :name => "index_carts_on_customer_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "active"
    t.integer  "parent_id"
    t.boolean  "is_age_group"
    t.boolean  "is_cut_type"
    t.string   "slug"
  end

  create_table "category_images", :force => true do |t|
    t.integer  "category_id"
    t.string   "image"
    t.datetime "display_start"
    t.datetime "display_end"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "category_images", ["category_id"], :name => "index_category_images_on_category_id"

  create_table "category_pairings", :force => true do |t|
    t.integer  "category_id"
    t.integer  "content_page_id"
    t.integer  "position"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "category_pairings", ["category_id"], :name => "index_category_pairings_on_category_id"
  add_index "category_pairings", ["content_page_id"], :name => "index_category_pairings_on_content_page_id"

  create_table "category_product_features", :force => true do |t|
    t.integer  "category_id"
    t.integer  "product_color_id"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "category_product_features", ["category_id"], :name => "index_category_product_features_on_category_id"
  add_index "category_product_features", ["product_color_id"], :name => "index_category_product_features_on_product_color_id"

  create_table "charges", :force => true do |t|
    t.integer  "cart_id"
    t.string   "token"
    t.integer  "amount"
    t.string   "result"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "charges", ["cart_id"], :name => "index_charges_on_cart_id"

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "position"
    t.string   "css_hex_code"
  end

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "subject"
    t.text     "message"
    t.string   "referer"
    t.integer  "read"
    t.integer  "flagged"
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "content_pages", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "parent_id"
    t.integer  "position"
  end

  create_table "countries", :force => true do |t|
    t.string "iso"
    t.string "name"
  end

  create_table "credit_cards", :force => true do |t|
    t.integer  "customer_id"
    t.string   "stripe_customer_id"
    t.string   "status"
    t.integer  "position"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "credit_cards", ["customer_id"], :name => "index_credit_cards_on_customer_id"

  create_table "customers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "facebook_id"
  end

  add_index "customers", ["authentication_token"], :name => "index_customers_on_authentication_token", :unique => true
  add_index "customers", ["confirmation_token"], :name => "index_customers_on_confirmation_token", :unique => true
  add_index "customers", ["email"], :name => "index_customers_on_email", :unique => true
  add_index "customers", ["reset_password_token"], :name => "index_customers_on_reset_password_token", :unique => true

  create_table "design_features", :force => true do |t|
    t.integer  "design_id"
    t.integer  "position"
    t.datetime "active_from"
    t.datetime "active_until"
    t.integer  "business_manager_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "design_features", ["design_id"], :name => "index_design_features_on_design_id"

  create_table "designs", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.string   "art"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "position"
    t.string   "background_color"
  end

  create_table "feedbacks", :force => true do |t|
    t.text     "message"
    t.integer  "customer_id"
    t.string   "ip"
    t.integer  "read"
    t.integer  "starred"
    t.integer  "needs_reply"
    t.integer  "testimonial"
    t.integer  "refund"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "feedbacks", ["customer_id"], :name => "index_feedbacks_on_customer_id"

  create_table "friend_emails", :force => true do |t|
    t.text     "message"
    t.integer  "product_id"
    t.integer  "color_id"
    t.integer  "size_id"
    t.integer  "customer_id"
    t.text     "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "friend_emails", ["color_id"], :name => "index_friend_emails_on_color_id"
  add_index "friend_emails", ["customer_id"], :name => "index_friend_emails_on_customer_id"
  add_index "friend_emails", ["product_id"], :name => "index_friend_emails_on_product_id"
  add_index "friend_emails", ["size_id"], :name => "index_friend_emails_on_size_id"

  create_table "image_position_templates", :force => true do |t|
    t.float    "scale"
    t.float    "top"
    t.float    "left"
    t.string   "name"
    t.integer  "position"
    t.integer  "product_manager_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "image_position_templates", ["product_manager_id"], :name => "index_image_position_templates_on_product_manager_id"

  create_table "inventories", :force => true do |t|
    t.integer  "product_color_id"
    t.integer  "size_id"
    t.integer  "amount"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "inventories", ["product_color_id"], :name => "index_inventories_on_product_color_id"
  add_index "inventories", ["size_id"], :name => "index_inventories_on_size_id"

  create_table "items", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "product_color_id"
    t.integer  "size_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "gift_wrap"
    t.integer  "quantity"
  end

  add_index "items", ["cart_id"], :name => "index_items_on_cart_id"
  add_index "items", ["product_color_id"], :name => "index_items_on_product_color_id"
  add_index "items", ["size_id"], :name => "index_items_on_size_id"

  create_table "mailing_list_registrations", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "street"
    t.string   "street2"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "festival"
    t.integer  "referral_id"
  end

  create_table "product_colors", :force => true do |t|
    t.integer  "product_id"
    t.integer  "color_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "og_code"
  end

  add_index "product_colors", ["color_id"], :name => "index_product_colors_on_color_id"
  add_index "product_colors", ["product_id"], :name => "index_product_colors_on_product_id"

  create_table "product_images", :force => true do |t|
    t.integer  "product_color_id"
    t.string   "image"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "image_position_template_id"
  end

  add_index "product_images", ["product_color_id"], :name => "index_product_images_on_product_color_id"

  create_table "product_managers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.boolean  "active"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "product_managers", ["email"], :name => "index_product_managers_on_email", :unique => true
  add_index "product_managers", ["reset_password_token"], :name => "index_product_managers_on_reset_password_token", :unique => true

  create_table "products", :force => true do |t|
    t.integer  "design_id"
    t.integer  "body_style_id"
    t.integer  "price"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "active"
    t.integer  "position"
    t.text     "copy"
    t.string   "code"
    t.integer  "landing_color_id"
  end

  add_index "products", ["body_style_id"], :name => "index_products_on_body_style_id"
  add_index "products", ["design_id"], :name => "index_products_on_design_id"

  create_table "referrals", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shipping_addresses", :force => true do |t|
    t.integer  "customer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "street"
    t.string   "street2"
    t.string   "city"
    t.string   "zip"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "ip_address"
    t.integer  "cart_id"
    t.string   "company"
    t.integer  "country_id"
    t.integer  "state_id"
    t.datetime "hidden"
  end

  add_index "shipping_addresses", ["customer_id"], :name => "index_shipping_addresses_on_customer_id"

  create_table "sizes", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "states", :force => true do |t|
    t.string  "name"
    t.integer "country_id"
    t.string  "iso"
  end

  add_index "states", ["country_id"], :name => "index_states_on_country_id"
  add_index "states", ["name"], :name => "index_states_on_name"

  create_table "wishlist_items", :force => true do |t|
    t.integer  "wishlist_id"
    t.integer  "product_color_id"
    t.integer  "size_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "wishlist_items", ["product_color_id"], :name => "index_wishlist_items_on_product_color_id"
  add_index "wishlist_items", ["size_id"], :name => "index_wishlist_items_on_size_id"
  add_index "wishlist_items", ["wishlist_id"], :name => "index_wishlist_items_on_wishlist_id"

  create_table "wishlists", :force => true do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "wishlists", ["customer_id"], :name => "index_wishlists_on_customer_id"

end
