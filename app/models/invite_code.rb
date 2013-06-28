class InviteCode < ActiveRecord::Base
  attr_accessible :code, :used, :invite_id, :user_id
end
