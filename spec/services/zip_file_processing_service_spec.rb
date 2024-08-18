require 'rails_helper'

RSpec.describe ZipFileProcessingService, type: :service do
  let(:customer) { create(:customer) }
  let(:valid_zip) { Rails.root.join('spec', 'fixtures', 'nfces.zip') }

  it 'creates an Upload record for each XML file' do
    initial_count = Upload.count
    ZipFileProcessingService.process(valid_zip, customer.id)
    expect(Upload.count).to be > initial_count
  end

end
