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

ActiveRecord::Schema.define(:version => 20130922001448) do

  create_table "bus_buyers", :force => true do |t|
    t.string   "busName",                              :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "user_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "busType"
    t.string   "busPhone"
    t.string   "busFax"
    t.string   "busContact"
    t.string   "busEmail"
    t.string   "busWebsite"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "active",            :default => true,  :null => false
    t.text     "tagline"
    t.boolean  "verified",          :default => false, :null => false
  end

  add_index "bus_buyers", ["id"], :name => "index_bus_buyers_on_id"

  create_table "bus_vendors", :force => true do |t|
    t.string   "busName",                              :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "user_id"
    t.string   "busType"
    t.string   "busPhone"
    t.string   "busFax"
    t.string   "busContact"
    t.string   "busEmail"
    t.string   "busWebsite"
    t.boolean  "active",            :default => true,  :null => false
    t.text     "tagline"
    t.boolean  "verified",          :default => false, :null => false
  end

  add_index "bus_vendors", ["id"], :name => "index_bus_vendors_on_id"
  add_index "bus_vendors", ["user_id"], :name => "index_bus_vendors_on_user_id"

  create_table "categories", :force => true do |t|
    t.integer  "parent_id",       :default => -1,    :null => false
    t.integer  "hierarchy_level", :default => 1,     :null => false
    t.string   "cat_name",        :default => "err", :null => false
    t.boolean  "active",          :default => true,  :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "categories", ["id"], :name => "index_categories_on_id"

  create_table "category_to_locations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "category_to_locations", ["category_id"], :name => "index_category_to_locations_on_category_id"
  add_index "category_to_locations", ["id"], :name => "index_category_to_locations_on_id"
  add_index "category_to_locations", ["location_id"], :name => "index_category_to_locations_on_location_id"

  create_table "claim_buyers", :force => true do |t|
    t.string  "user_login"
    t.string  "user_email"
    t.string  "user_type"
    t.string  "bus_name"
    t.string  "bus_phone"
    t.string  "claim_token"
    t.boolean "claimed",     :default => false
  end

  create_table "claim_locations", :force => true do |t|
    t.string  "user_login"
    t.string  "user_email"
    t.string  "user_type"
    t.string  "bus_name"
    t.string  "loc_phone"
    t.string  "loc_address1"
    t.string  "loc_address2"
    t.string  "loc_city"
    t.string  "loc_state"
    t.string  "loc_zip"
    t.string  "loc_website"
    t.string  "claim_token"
    t.float   "latitude"
    t.float   "longitude"
    t.boolean "claimed",      :default => false
  end

  create_table "contacts", :force => true do |t|
    t.integer  "location_id",                      :null => false
    t.string   "firstName",                        :null => false
    t.string   "lastName"
    t.string   "primaryPhone"
    t.string   "secondaryPhone"
    t.string   "fax"
    t.string   "email"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "active",         :default => true, :null => false
  end

  create_table "fav_locations", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "location_id",                   :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "active",      :default => true, :null => false
  end

  create_table "fav_products", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.integer  "product_id",                         :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "featured_item_id"
    t.boolean  "active",           :default => true, :null => false
  end

  create_table "featured_item_view_logs", :force => true do |t|
    t.integer  "viewed_by_user_id", :null => false
    t.integer  "featured_item_id",  :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "featured_items", :force => true do |t|
    t.integer  "location_id",                                                       :null => false
    t.integer  "product_id",                                                        :null => false
    t.integer  "product_image_id"
    t.text     "description"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.string   "size"
    t.decimal  "price",            :precision => 10, :scale => 2
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "active",                                          :default => true, :null => false
    t.string   "commonName"
    t.string   "busName"
  end

  add_index "featured_items", ["active"], :name => "index_featured_items_on_active"
  add_index "featured_items", ["busName"], :name => "index_featured_items_on_busName"
  add_index "featured_items", ["commonName"], :name => "index_featured_items_on_commonName"
  add_index "featured_items", ["id"], :name => "index_featured_items_on_id"
  add_index "featured_items", ["location_id"], :name => "index_featured_items_on_location_id"
  add_index "featured_items", ["product_id"], :name => "index_featured_items_on_product_id"
  add_index "featured_items", ["product_image_id"], :name => "index_featured_items_on_product_image_id"

  create_table "inventories", :force => true do |t|
    t.integer  "location_id"
    t.integer  "num_views"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "active",            :default => true, :null => false
    t.boolean  "current",           :default => true, :null => false
  end

  create_table "invite_codes", :force => true do |t|
    t.string   "code"
    t.boolean  "used",       :default => false
    t.integer  "invite_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "invites", :force => true do |t|
    t.boolean  "inviteSent", :default => false
    t.string   "email"
    t.string   "userType"
    t.string   "busName"
    t.string   "busType"
    t.string   "state"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "location_public_settings", :force => true do |t|
    t.boolean  "show_company_logo",               :default => true,  :null => false
    t.boolean  "show_tagline",                    :default => true,  :null => false
    t.boolean  "show_full_address",               :default => true,  :null => false
    t.boolean  "show_city_and_state",             :default => false, :null => false
    t.boolean  "show_state_only",                 :default => false, :null => false
    t.boolean  "show_primary_phone",              :default => true,  :null => false
    t.boolean  "show_secondary_phone",            :default => false, :null => false
    t.boolean  "show_fax",                        :default => false, :null => false
    t.boolean  "show_primary_email",              :default => true,  :null => false
    t.boolean  "show_secondary_email",            :default => false, :null => false
    t.boolean  "show_website",                    :default => true,  :null => false
    t.boolean  "show_facebook",                   :default => true,  :null => false
    t.boolean  "show_twitter",                    :default => true,  :null => false
    t.boolean  "show_google",                     :default => true,  :null => false
    t.boolean  "show_featured_items",             :default => true,  :null => false
    t.boolean  "show_featured_items_price",       :default => false, :null => false
    t.boolean  "show_featured_items_size",        :default => false, :null => false
    t.boolean  "show_featured_items_description", :default => true,  :null => false
    t.boolean  "show_categories",                 :default => true,  :null => false
    t.boolean  "show_other_locations",            :default => false, :null => false
    t.integer  "location_id",                                        :null => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.boolean  "show_about",                      :default => true,  :null => false
    t.boolean  "show_inventory",                  :default => true,  :null => false
  end

  create_table "location_view_logs", :force => true do |t|
    t.integer  "viewed_by_user_id", :null => false
    t.integer  "location_id",       :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer  "bus_vendor_id",                                 :null => false
    t.string   "locName"
    t.string   "primaryPhone"
    t.string   "secondaryPhone"
    t.string   "fax"
    t.string   "address1",                                      :null => false
    t.string   "address2"
    t.string   "city",                                          :null => false
    t.string   "state",                                         :null => false
    t.string   "zip",                                           :null => false
    t.string   "primaryEmail"
    t.string   "secondaryEmail"
    t.string   "websiteLink"
    t.string   "facebookLink"
    t.string   "twitterLink"
    t.string   "googleLink"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "active",                     :default => true,  :null => false
    t.boolean  "verified",                   :default => false, :null => false
    t.text     "bio"
    t.integer  "searchWeight",               :default => 0,     :null => false
    t.string   "public_url"
    t.boolean  "public_url_active",          :default => true,  :null => false
    t.boolean  "url_is_custom",              :default => false, :null => false
    t.string   "busName"
    t.boolean  "is_subscribed_to_inventory", :default => false, :null => false
  end

  add_index "locations", ["active"], :name => "index_locations_on_active"
  add_index "locations", ["busName"], :name => "index_locations_on_busName"
  add_index "locations", ["bus_vendor_id"], :name => "index_locations_on_bus_vendor_id"
  add_index "locations", ["id"], :name => "index_locations_on_id"

  create_table "newsletter_emails", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.string   "status"
    t.string   "transaction_id"
    t.string   "location_id"
    t.string   "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "product_images", :force => true do |t|
    t.integer  "product_id",                            :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active",             :default => true,  :null => false
    t.boolean  "verified",           :default => false, :null => false
  end

  add_index "product_images", ["id"], :name => "index_product_images_on_id"
  add_index "product_images", ["product_id"], :name => "index_product_images_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "commonName",                    :null => false
    t.string   "latinName"
    t.string   "altName"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "active",     :default => true,  :null => false
    t.boolean  "verified",   :default => false, :null => false
  end

  add_index "products", ["id"], :name => "index_products_on_id"

  create_table "search_logs", :force => true do |t|
    t.string   "searchTerm"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.text     "categories"
    t.string   "distanceFrom"
    t.text     "searchType"
    t.boolean  "active",       :default => true, :null => false
    t.string   "location"
    t.integer  "numResults"
    t.string   "resultsView"
  end

  create_table "statuses", :force => true do |t|
    t.text     "status"
    t.boolean  "active",      :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "location_id",                   :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "user_sessions_id", :null => false
    t.text     "data"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "user_sessions", ["user_sessions_id"], :name => "index_user_sessions_on_user_sessions_id"

  create_table "users", :force => true do |t|
    t.string   "login",                                        :null => false
    t.string   "email",                                        :null => false
    t.string   "userType",                  :default => "",    :null => false
    t.string   "crypted_password",                             :null => false
    t.string   "password_salt",                                :null => false
    t.string   "persistence_token",                            :null => false
    t.integer  "login_count",               :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "bus_vendor_id"
    t.integer  "bus_buyer_id"
    t.string   "profileImage_file_name"
    t.string   "profileImage_content_type"
    t.integer  "profileImage_file_size"
    t.datetime "profileImage_updated_at"
    t.string   "perishable_token",          :default => "",    :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "currentCity"
    t.string   "currentState"
    t.boolean  "active",                    :default => true,  :null => false
    t.boolean  "verified",                  :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["userType"], :name => "index_users_on_userType"

end
