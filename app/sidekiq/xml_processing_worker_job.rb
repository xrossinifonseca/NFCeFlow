class XmlProcessingWorkerJob
  include Sidekiq::Job

  def perform(file_path,customer_id,upload_id)

  upload = Upload.find(upload_id)

  begin
    service = XmlProcessingService.new(file_path,customer_id)
    service.process_and_save
    upload.update(status: 'success')
  rescue StandardError => e

    upload.update(status: 'failed', error_message: e.message)
    logger.error "Failed to process XML file: #{e.message}"

  ensure

    File.delete(file_path) if File.exist?(file_path)

  end
  end
end
