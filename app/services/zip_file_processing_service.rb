require 'zip'

class ZipFileProcessingService
  def self.process(file,customer_id)

    Zip::File.open(file) do |zipfile|

      zipfile.each do |entry|

        if entry.file? && File.extname(entry.name) == ".xml"

          begin
            entry.get_input_stream do |io|
              file_content = io.read
              upload = Upload.create!(file_name: entry.name, status: "processing", customer_id: customer_id)
              XmlProcessingWorkerJob.perform_async(file_content, customer_id, upload.id)
            end

          rescue => e
            Upload.create!(file_name: entry.name, status: "failed", customer_id: customer_id, error_message: "Failed to process file: #{e.message}")
            Rails.logger.error "Failed to process #{entry.name}: #{e.message}"
          end

        end

      end


    end




  end
end
