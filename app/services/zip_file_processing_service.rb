require 'zip'

class ZipFileProcessingService
  def self.process(file,customer_id)

    Zip::File.open(file) do |zipfile|

      zipfile.each do |entry|

        if entry.file? && File.extname(entry.name) == ".xml"

          file_name =  entry.name.gsub(" ", "_")

          extracted_file_path = Rails.root.join('tmp', 'uploads', file_name)


          FileUtils.mkdir_p(File.dirname(extracted_file_path))

          begin
            entry.extract(extracted_file_path) { true }

          rescue => e
            Upload.create!(file_name: file_name, status: "failed", customer_id: customer_id,message:"failed to extract file")
            Rails.logger.error "Erro ao extrair #{entry.name}: #{e.message}"
            next
          end

          upload = Upload.create!(file_name: file_name, status: "processing", customer_id: customer_id)
          XmlProcessingWorkerJob.perform_async(extracted_file_path.to_s, customer_id, upload.id)
        end
      end

      File.delete(file) if File.exist?(file)
    end
  end
end


# elsif entry.directory?
#   puts "#{entry.name} is a directory!"
# elsif entry.symlink?
#   puts "#{entry.name} is a symlink!"
