require 'rails_helper'

RSpec.describe XmlProcessingService, type: :service do

  let(:valid_xml) { Rails.root.join('spec', 'fixtures', 'test.xml') }
  let(:invalid_xml) { Rails.root.join('spec', 'fixtures', 'test.txt') }
  let(:customer) { create(:customer) }

  describe "#parse_xml" do

  context "with an invalid XML file" do
    it "raises an error" do
      service = XmlProcessingService.new(invalid_xml, customer.id)
      expect { service.parse_xml(invalid_xml) }.to raise_error("Invalid XML file")
    end
  end

    context "with a valid XML file" do
      it "does not raise an error" do
        service = XmlProcessingService.new(valid_xml, customer.id)
        expect { service.parse_xml(valid_xml) }.not_to raise_error
      end
    end

  end



  describe "#process_and_save" do

  it "saves data to the database" do

    service = XmlProcessingService.new(valid_xml, customer.id)
    service.process_and_save
    expect(Nfce.count).to eq(1)
    end

  end

end
