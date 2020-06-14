class Publication < ApplicationRecord
  after_save :download_publication, :notify_main_application

  def download_publication

  end

  def notify_main_application

  end
end
