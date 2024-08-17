require 'mimemagic'

class UploadsController < ApplicationController

def index
  @uploads = current_customer.uploads
end



def create
   file = params[:file]

  if !file.present?
    flash[:error] = "File cant be blank"
    return redirect_to new_upload_path
  end

  file_path = Rails.root.join('tmp', 'uploads', file.original_filename)

  File.open(file_path, 'wb') do |f|
    f.write(file.read)
  end

  mime_type = MimeMagic.by_path(file_path)

   if File.exist?(file_path)

    if mime_type.subtype == "zip"
      ZipFileProcessingService.process(file_path,current_customer.id)
      flash[:success] = "your zip file is being processed"

      redirect_to uploads_path

      elsif mime_type.subtype == "xml"

        upload = Upload.create!(file_name:file.original_filename, status:"processing", customer_id:current_customer.id)

        XmlProcessingWorkerJob.perform_in(60,file_path.to_s,current_customer.id,upload.id)

        flash[:success] = "your xml file is being processed"

        redirect_to uploads_path

      else
        flash[:error] = "The file must be in XML or ZIP format. Please upload a file with one of the supported extensions."
        return redirect_to new_upload_path
      end
    else
      flash[:error] = "Failed to save the file. Please try again."
      return redirect_to new_upload_path
    end
end





end
