# == Schema Information
#
# Table name: publications
#
#  id                   :integer          not null, primary key
#  pdf_generated        :boolean          default(FALSE), not null
#  publication_filename :string
#  publication_number   :string
#  publication_url      :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require 'test_helper'

class PublicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
