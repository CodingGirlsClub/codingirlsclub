# == Schema Information
#
# Table name: accounts
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  token       :string(150)
#  secret      :string(150)
#  provider    :string(40)
#  sid         :string(40)
#  uniq_id     :string(255)
#  email       :string(150)
#  name        :string(150)
#  location    :string(150)
#  photo       :string(150)
#  url         :string(150)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Account < ApplicationRecord
  belongs_to :user, optional: true

  validates_presence_of :sid, :provider
  validates_uniqueness_of :sid, scope: :provider, case_sensitive: false
end